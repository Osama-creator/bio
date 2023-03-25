import 'package:bio/app/data/models/student_model.dart';

class Group {
  final String name;
  final String id;
  final int? price;
  final String? sessions;
  final List<Studen>? students;

  Group(
      {required this.name,
      required this.id,
      this.price,
      this.sessions,
      this.students});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'id': id,
      'sessions': sessions,
      'students': students!.map((student) => student.toJson()).toList(),
    };
  }
}
