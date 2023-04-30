class Question {
  final String? id;
  late final String rightAnswer;
  String? userChoice;
  late final String? question;
  late final List<String>? wrongAnswers;
  late final String? image;

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
