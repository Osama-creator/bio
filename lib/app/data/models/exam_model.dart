import 'package:bio/app/data/models/question_model.dart';

class Exam {
  final String id;
  final String name;
  final DateTime date;
  final List<Question> questions;

  Exam(
      {required this.name,
      required this.questions,
      required this.id,
      required this.date});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'date': date,
      'questions': questions.map((student) => student.toJson()).toList(),
    };
  }
}
