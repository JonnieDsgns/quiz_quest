import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_quest/quiz.dart';

class QuizSensor extends GameDecoration with Sensor<Player> {
  final String id;
  bool hasContact = false;
  final String questionFilePath;
  final String questionID;

  QuizSensor(
    this.id, // Name des Objekts
    Vector2 position,
    Vector2 size,
    this.questionFilePath, // ist in maps.dart als Inhalt der CustomProperty ['nextMap'] definiert
    this.questionID, // ist in maps.dart als Inhalt der CustomProperty ['playerPosition'] definiert
  ) : super(
        position: position,
        size: size,
      ) {
    print('QuizSensor created with questionFilePath: $questionFilePath and questionID: $questionID');
  }

  Future<bool> _isQuestionAnswered(String questionID) async {
    final box = await Hive.openBox('quizDataBox');
    final answeredQuestions = box.get('quizDataBox', defaultValue: <String>{}).cast<String>().toSet();
    return answeredQuestions.contains(questionID);
  }

  @override
  void onContact(Player component) async {
    if (!hasContact) {
      hasContact = true;
      print('Contact has been made with $id');
      print('Loading $questionID with question in Filepath $questionFilePath');

      bool isAnswered = await _isQuestionAnswered(questionID);
      if (!isAnswered) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizPage(questionFilePath: questionFilePath, questionID: questionID),
          ),
        );
      } else {
        print('Question $questionID has already been answered.');
      }
    }
    super.onContact(component);
  }
}