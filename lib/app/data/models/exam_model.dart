import 'package:bio/app/data/models/question_model.dart';

class Exam {
  final String id;
  final String name;
  final List<Question> questions;

  Exam({required this.name, required this.questions, required this.id});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'questions': questions.map((student) => student.toJson()).toList(),
    };
  }
}
