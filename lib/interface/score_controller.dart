import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ScoreController extends ChangeNotifier {
  static final ScoreController _singleton = ScoreController._internal();

  factory ScoreController() {
    return _singleton;
  }

  ScoreController._internal() {
    _loadScore();
  }

  int _score = 0;

  int get score => _score;

  set score(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void incrementScore(int value) {
    _score += value;
    notifyListeners();
    _saveScore();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
    _saveScore();
  }

  Future<void> _loadScore() async {
    final box = await Hive.openBox('quizDataBox');
    _score = box.get('score', defaultValue: 0);
    notifyListeners();
  }

  Future<void> _saveScore() async {
    final box = await Hive.openBox('quizDataBox');
    await box.put('score', _score);
  }
}