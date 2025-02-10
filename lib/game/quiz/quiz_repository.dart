import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_quest/game/quiz/question_model.dart';

class QuizRepository {

  Future<List<QuizQuestion>> getQuestionsFromFile(String filePath) async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString(filePath);
      final List<dynamic> data = json.decode(response);

      // Convert the JSON data to a list of Question objects
      final List<QuizQuestion> questions = data.map((e) {
        final question = QuizQuestion.fromMap(e);
        final shuffledAnswers = List<String>.from(question.answers);
        shuffledAnswers.shuffle(); // Shuffle the answers here
        return QuizQuestion(
          questionID: question.questionID,
          question: question.question,
          correctAnswer: question.correctAnswer,
          incorrectAnswers: question.incorrectAnswers,
          answers: shuffledAnswers, // Use shuffled answers
        );
      }).toList();

      // Return the requested number of questions
      return questions;
    } catch (err) {
      print(err);
      return [];
    }
  }
}