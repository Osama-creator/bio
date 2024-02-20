import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bio/app/data/models/student_model.dart';

class GroupPreviousMonths {
  final String groupId;
  final Timestamp date;
  final int? sessions;
  final List<Studen>? students;

  GroupPreviousMonths({
    required this.groupId,
    required this.date,
    required this.students,
    required this.sessions,
  });

  factory GroupPreviousMonths.fromJson(Map<String, dynamic> json) {
    return GroupPreviousMonths(
      groupId: json['groupId'],
      date: json['date'],
      sessions: json['sessions'],
      students: (json['students'] as List<dynamic>?)?.map((studentData) => Studen.fromJson(studentData)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'date': date,
      'sessions': sessions,
      'students': students?.map((student) => student.toJson()).toList(),
    };
  }
}
