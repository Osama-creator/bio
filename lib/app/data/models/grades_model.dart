import 'package:bio/app/data/models/question_model.dart';

class Grade {
  final String name;
  final String id;
  final List<Question>? students;
  Grade({required this.name, required this.id, this.students});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'students': students!.map((student) => student.toJson()).toList(),
    };
  }
}
