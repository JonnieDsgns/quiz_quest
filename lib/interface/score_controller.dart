import 'package:flutter/foundation.dart';

class ScoreController extends ChangeNotifier {
  static final ScoreController _singleton = ScoreController._internal();

  factory ScoreController() {
    return _singleton;
  }

  ScoreController._internal();

  int _score = 0;

  int get score => _score;

  set score(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void incrementScore(int value) {
    _score += value;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}