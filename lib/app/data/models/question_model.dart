class Question {
  final String? id;
  late final String rightAnswer;
  final String? pick;
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
    this.pick = "",
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

  factory Question.fromJson(Map<String, dynamic> json) {
    final wrongAnswers = List<String>.from(json['wrong_answer']);
    return Question(
      question: json['question'],
      id: json['id'],
      rightAnswer: json['right_answer'],
      image: json['image'],
      wrongAnswers: [
        ...wrongAnswers,
        json['right_answer'],
      ]..shuffle(),
    );
  }
}
