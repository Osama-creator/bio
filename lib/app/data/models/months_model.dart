import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupPreviousMonths {
  final String groupId;
  final Timestamp date;
  final int? sessions;

  final List<Studen>? students;

  GroupPreviousMonths(
      {required this.groupId,
      required this.date,
      required this.students,
      required this.sessions});
}
