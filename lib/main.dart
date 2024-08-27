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


class QuestionPage extends StatelessWidget {
  final int questionIndex;
  final int score;

  const QuestionPage({super.key, required this.questionIndex, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pergunta 1/6'),
        backgroundColor: const Color(0xFF1f7788),
      ),
      body: GradientBackground(
        child: Center(
          child: Text('Conteúdo do nosso quiz aqui!',
          style: Theme.of(context).textTheme.bodyLarge,),
        ),
      ),
    );
  }
}



