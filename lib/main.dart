import 'package:flutter/material.dart';

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

  const QuestionPage({super.key, required this.questionIndex, required this.score});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Question> questions;
  bool answered = false;
  int? selectedOption;

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
  }

  void _onNextPressed() {
    if (widget.questionIndex < questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionPage(
            questionIndex: widget.questionIndex + 1,
            score: widget.score,
          ),
        ),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[widget.questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta ${widget.questionIndex + 1}/${questions.length}'),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.questionText,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: answered ? null : () => _onOptionSelected(index),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                    child: Text(
                      question.options[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              if (answered)
                ElevatedButton(
                  onPressed: _onNextPressed,
                  child: const Text('Próxima'),
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




