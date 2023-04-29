class Question {
  final String? id;
  final String rightAnswer;
  String? userChoice;
  final String? question;
  final List<String>? wrongAnswers;
  final String? image;

  Question({
    this.id,
    required this.rightAnswer,
    this.question,
    this.userChoice,
    this.wrongAnswers,
    this.image = "",
  });
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'id': id,
      'image': image,
      'wrong_answer': wrongAnswers,
      'right_answer': rightAnswer,
    };
  }
}
