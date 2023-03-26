import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import 'package:intl/intl.dart';

import '../../../data/models/student_model.dart';

class CreateSessionController extends GetxController {
  final group = Get.arguments as Group;
  bool checked = false;

  String currentDate = DateFormat('yyyy / MM / dd').format(DateTime.now());
  var checkedStudents = <Studen, bool>{};

  bool isChecked(Studen student) {
    return checkedStudents[student] ?? false;
  }

  void setChecked(Studen student, bool value) {
    checkedStudents[student] = value;
    if (isChecked(student)) {
      student.absence++;
    } else {
      student.absence--;
    }
    updateStudent(student);
    update();
  }

  void updateStudent(Studen student) {
    final index = group.students!.indexOf(student);
    if (index != -1) {
      group.students![index] = student;
      FirebaseFirestore.instance.collection('groups').doc(group.id).update({
        'students': group.students!.map((s) => s.toJson()).toList(),
        'current_session': group.currentSession! + 1,
      });
    }
  }
}
