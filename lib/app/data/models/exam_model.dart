import 'package:bio/app/data/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final String id;
  String name;
  final DateTime date;
  bool isActive;
  final List<Question> questions;

  Exam({required this.name, required this.questions, required this.id, this.isActive = false, required this.date});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'date': date,
      'is_active': isActive,
      'questions': questions.map((student) => student.toJson()).toList(),
    };
  }

  factory Exam.fromJson(Map<String, dynamic> json, String jsonId, List<Question> questionList) {
    return Exam(
      name: json['name'],
      id: jsonId,
      date: (json['date'] as Timestamp).toDate(),
      isActive: json['is_active'],
      questions: questionList,
    );
  }
}
