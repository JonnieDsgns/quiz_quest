import 'package:flutter/material.dart';
import 'package:quiz_quest/interface/score_controller.dart';

Widget questionCard(BuildContext context, String question) { // Hintergrund/Widget für die Frage im Quiz
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.2,
    child: Card(
      color: const Color(0xFF181426),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            question,
            style: const TextStyle(fontFamily: 'Pixel', fontSize: 36),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

class AnswerCard extends StatelessWidget {  // Widget für die Antwortmöglichkeiten im Quiz
  final String answer;
  final String? selectedAnswer;
  final String correctAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFF181426); // Standardfarbe

    if (selectedAnswer != null) { // Farbe der Antwortmöglichkeiten ändert sich, wenn eine Antwort ausgewählt wurde. Grün für richtig, rot für falsch, rest bleibt gleich
      if (answer == correctAnswer) {
        backgroundColor = Colors.green;
      } else if (answer == selectedAnswer) {
        backgroundColor = Colors.red;
      }
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.125,
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
          child: InkWell(
            onTap: selectedAnswer == null ? onTap : null, 
            borderRadius: BorderRadius.circular(8.0), // Match the rounded corners
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  answer,
                  style: const TextStyle(fontFamily: 'Pixel', fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
  }
}

Widget exitCard(String string, BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Card(
        color: const Color(0xFF181426),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Abgerundete Ecken
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0), // Match the rounded corners
          onTap: Navigator.of(context).pop,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                string,
                style: const TextStyle(fontFamily: 'Pixel', fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
}

class ScoreWidget extends StatelessWidget {
  final String imgPath;
  const ScoreWidget({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    final controller = ScoreController();
    return Material(
      type: MaterialType.transparency,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return Positioned(
            top: 20,
            left: 20,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Image.asset(
                      imgPath,
                      height: 72.0,
                      fit: BoxFit.contain,
                    ),
                  Padding(
                  padding: const EdgeInsets.only(left: 120, top: 14),
                    child: Text(
                      '${controller.score}',   
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Pixel',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

