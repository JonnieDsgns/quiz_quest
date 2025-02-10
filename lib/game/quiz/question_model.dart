class QuizQuestion {
  final String questionID;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> answers; // Add this field to store shuffled answers

  const QuizQuestion({
    required this.questionID,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.answers, // Initialize this field
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    final incorrectAnswers = List<String>.from(map['incorrectAnswers'] ?? []);
    final correctAnswer = map['correctAnswer'] ?? '';
    final answers = List<String>.from(incorrectAnswers)..add(correctAnswer);

    return QuizQuestion(
      questionID: map['questionID'] ?? '',
      question: map['question'] ?? '',
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
      answers: answers, // Store answers without shuffling
    );
  }

  Map<String, dynamic> toJson() => {
    'questionID': questionID,
    'question': question,
    'correctAnswer': correctAnswer,
    'incorrectAnswers': incorrectAnswers,
    'answers': answers, // Include answers in JSON
  };
}