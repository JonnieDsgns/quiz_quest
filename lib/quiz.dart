import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_quest/game/quiz/question_model.dart';
import 'package:quiz_quest/game/quiz/quiz_repository.dart';
import 'package:quiz_quest/interface/ui_elements_quiz.dart';
import 'package:quiz_quest/interface/score_controller.dart';

class QuizPage extends StatefulWidget {
  final String questionFilePath;
  final String questionID;

  const QuizPage({super.key, required this.questionFilePath, required this.questionID});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? selectedAnswer;
  bool? isCorrect;
  QuizQuestion? question;
  final ScoreController scoreController = ScoreController();

  @override
  void initState() {
    super.initState();
    _loadQuestion(); // Um zu vermeiden, dass Fragenreihenfolge bei Antwort geändert wird
  }

  Future<void> _loadQuestion() async { // Lädt Frage aus JSON-Datei abhängig von der ID, die vom TiledObject gegeben wird
    final repository = QuizRepository();
    final questions = await repository.getQuestionsFromFile(widget.questionFilePath);
    setState(() {
      question = questions.firstWhere((q) => q.questionID == widget.questionID);
    });
  }

  Future<Set<String>> _getAnsweredQuestions() async { // Liest gespeicherte questionIDs aus quizDataBox aus -> Dient dazu, dass Fragen nicht wiederholt gespielt werden
    final box = await Hive.openBox('quizDataBox');
    return box.get('quizDataBox', defaultValue: <String>{}).cast<String>().toSet(); // sorgt dafür, dass der DefaultValue ein Leeres String-Set ist
  }

  Future<void> _saveAnsweredQuestion(String questionID) async { // Speichert die ID der beantworteten Frage in quizDataBox -> Dient dazu, dass Fragen nicht wiederholt gespielt werden
    final box = await Hive.openBox('quizDataBox');
    final answeredQuestions = await _getAnsweredQuestions();
    answeredQuestions.add(questionID);
    await box.put('quizDataBox', answeredQuestions.toList());
  }

  void _submitAnswer(QuizQuestion question, String answer) { // Überprüft, ob die Antwort korrekt ist und speichert die beantwortete Frage
    setState(() {
      selectedAnswer = answer;
      isCorrect = question.correctAnswer == answer;
      if (isCorrect!) {
        scoreController.incrementScore(100);
      }
    });
    _saveAnsweredQuestion(widget.questionID);
    _saveScore();
  }

  Future<void> _saveScore() async {
    final box = await Hive.openBox('quizDataBox');
    await box.put('score', scoreController.score);
  }

  @override
  Widget build(BuildContext context) {
    if (question == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: questionCard(context, question!.question),
            ),
            AnswerCard(
              answer: question!.answers[0],
              selectedAnswer: selectedAnswer,
              correctAnswer: question!.correctAnswer,
              onTap: () => _submitAnswer(question!, question!.answers[0]),
            ),
            AnswerCard(
              answer: question!.answers[1],
              selectedAnswer: selectedAnswer,
              correctAnswer: question!.correctAnswer,
              onTap: () => _submitAnswer(question!, question!.answers[1]),
            ),
            AnswerCard(
              answer: question!.answers[2],
              selectedAnswer: selectedAnswer,
              correctAnswer: question!.correctAnswer,
              onTap: () => _submitAnswer(question!, question!.answers[2]),
            ),
            AnswerCard(
              answer: question!.answers[3],
              selectedAnswer: selectedAnswer,
              correctAnswer: question!.correctAnswer,
              onTap: () => _submitAnswer(question!, question!.answers[3]),
            ),
            const Spacer(),
            exitCard('Weiter spielen', context),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}