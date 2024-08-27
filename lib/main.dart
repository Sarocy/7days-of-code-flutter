import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz AluraPop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF357787),
          primary: const Color(0xFF1f7788),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge:
              TextStyle(fontSize: 18, color: Color.fromARGB(221, 215, 207, 207)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1f7788),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
        )
      ),
      home: const WelcomeScreen(),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF01080E), Color.fromARGB(255, 5, 46, 63)],
        ),
      ),
      child: child,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/lampada.png', height: 100, width: 100),
              Image.asset('lib/assets/foto-capa.png', height: 400, width: 600),
              const SizedBox(height: 20),
              const Text(
                'Descubra quanto você sabe!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const QuestionPage(questionIndex: 0, score: 0)),
                  );
                },
                child: const Text('Começar', style: TextStyle(fontSize: 20)),
              ),
              Image.asset('lib/assets/alura_icon.png',
                  height: 60, width: 100),
            ],
          ),
        ),
      ),
    );
  }
}


class Question {
  final String questionText;
  final List<String> options;
  final int correctOption;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
  });
}

List<Question> _getQuestions() {
  return [
    Question(
      questionText: 'Qual série é conhecida por ter o personagem principal chamado "Walter White"?',
      options: ['a) Better Call Saul', 'b) The Sopranos', 'c) Breaking Bad', 'd) Mad Men'],
      correctOption: 2,
    ),
    Question(
      questionText: 'Qual é o nome da cidade fictícia onde se passa "Stranger Things"?',
      options: ['a) Hawkins', 'b) Riverdale', 'c) Gotham', 'd) Sunnydale'],
      correctOption: 0,
    ),
    Question(
      questionText: 'Qual é o nome do trono no qual os personagens lutam pelo poder em "Game of Thrones"?',
      options: ['a) Trono de Ferro', 'b) Trono de Ouro', 'c) Trono de Vidro', 'd) Trono de Pedra'],
      correctOption: 0,
    ),
    Question(
      questionText: 'Qual personagem de "Star Wars" é conhecido por sua habilidade em usar a Força e seu sabre de luz azul?',
      options: ['a) Luke Skywalker', 'b) Darth Vader', 'c) Han Solo', 'd) Obi-Wan Kenobi'],
      correctOption: 3,
    ),
    Question(
      questionText: 'Quem dirigiu o filme "Pulp Fiction"?',
      options: ['a) Quentin Tarantino', 'b) Steven Spielberg', 'c) Martin Scorsese', 'd) Christopher Nolan'],
      correctOption: 0,
    ),
    Question(
      questionText: 'Qual é o nome do planeta natal de Superman?',
      options: ['a) Krypton', 'b) Mars', 'c) Earth', 'd) Saturn'],
      correctOption: 0,
    ),

  ];
}


class QuestionPage extends StatefulWidget {
  final int questionIndex;
  final int score;

  const QuestionPage(
      {super.key, required this.questionIndex, required this.score});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Question> questions;
  bool answered = false;
  int? selectedOption;


  // Mapa que associa o índice da pergunta com o caminho da imagem
  final Map<int, String> _imagePaths = {
    0: 'lib/assets/Walter-White.jpg',
    1: 'lib/assets/stranger-things.jpg',
    2: 'lib/assets/game_of_thrones.jpg',
    3: 'lib/assets/star-wars.jpg',
    4: 'lib/assets/tarantino.jpg',
    5: 'lib/assets/superman.jpeg',
  };


  @override
  void initState() {
    super.initState();
    questions = _getQuestions();
  }

  void _onOptionSelected(int index) {
    setState(() {
      selectedOption = index;
      answered = true;
    });


    Future.delayed(const Duration(seconds: 1), () {
      final isCorrect = selectedOption ==
          questions[widget.questionIndex].correctOption;
      final updatedScore =
          isCorrect ? widget.score + 1 : widget.score;
      _showFeedbackDialog(isCorrect, updatedScore);
    });
  }
  

  void _showFeedbackDialog(bool isCorrect, int updatedScore) {
    final imagePath =
        _imagePaths[widget.questionIndex] ?? 'lib/assets/default.jpg';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(isCorrect
                  ? 'Parabéns, você acertou!'
                  : 'Ops, você errou...')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'A resposta correta é: ${questions[widget.questionIndex].options[questions[widget.questionIndex].correctOption]}'),
              const SizedBox(height: 10),
              Image.asset(imagePath, height: 250, width: 300),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                if (widget.questionIndex < questions.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(
                        questionIndex:
                            widget.questionIndex + 1,
                        score: updatedScore,
                      ),
                    ),
                  );
                  }
                  else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizCompletedPage(
                          score: updatedScore,
                          totalQuestions: questions.length),
                    ),
                  );
                }
              },
              child: const Text('Avançar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final question = questions[widget.questionIndex];
    final progress =
        (widget.questionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Pergunta ${widget.questionIndex + 1}/${questions.length}'),
        backgroundColor: const Color(0xFF1f7788),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              // Barra de progresso
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey[800],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 196, 168, 102)),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      question.questionText,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...List.generate(
                  question.options.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5),
                        child: ElevatedButton(
                          onPressed: answered
                              ? null
                              : () => _onOptionSelected(index),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15),
                          ),
                          child: Text(
                            question.options[index],
                            style: const TextStyle(
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              Image.asset('lib/assets/alura_icon.png',
                  height: 60, width: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizCompletedPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizCompletedPage({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    final correctAnswers = score;
    final incorrectAnswers = totalQuestions - score;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Completo!'),
        backgroundColor: Color(0xFF1f7788),
      ),
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: const Text(
                  'Parabéns! Você completou o quiz.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Sua pontuação: $score/$totalQuestions',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: correctAnswers.toDouble(),
                          title: 'Corretas',
                          color: Colors.green,
                          radius: 60,
                          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: incorrectAnswers.toDouble(),
                          title: 'Incorretas',
                          color: Colors.red,
                          radius: 60,
                          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  );
                },
                child: const Text('Jogar Novamente'),
              ),
              Image.asset('lib/assets/alura_icon.png', height: 60, width: 100),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

