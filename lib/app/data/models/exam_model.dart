import 'package:bio/app/data/models/question_model.dart';

class Exam {
  final String id;
  String name;
  final DateTime date;
  bool isActive;
  final List<Question> questions;

  Exam(
      {required this.name,
      required this.questions,
      required this.id,
      this.isActive = false,
      required this.date});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'date': date,
      'is_active': isActive,
      'questions': questions.map((student) => student.toJson()).toList(),
    };
  }
}
