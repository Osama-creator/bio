import 'dart:developer';

import 'package:bio/app/services/utils_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import 'package:intl/intl.dart';

import '../../../data/models/student_model.dart';

class CreateSessionController extends GetxController {
  final group = Get.arguments as Group;
  final utilesService = UtilsService();
  bool checked = false;
  @override
  void onInit() {
    log(group.id);
    icCurrentSessions();
    super.onInit();
  }

  void icCurrentSessions() {
    group.currentSession = group.currentSession! + 1;
    if (group.currentSession == int.parse(group.sessions!)) {
      // Create new collection in this group called "group previous months"
      utilesService.icCurrentSessionsApi(group: group);
      // Update group current session to 0 and students absence to 0
      group.currentSession = 0;
      for (final student in group.students!) {
        student.absence = 0;
      }
    }
    FirebaseFirestore.instance.collection('groups').doc(group.id).update({
      'current_session': group.currentSession,
      'students': group.students!.map((s) => s.toJson()).toList(),
    });
    update();
  }

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
      });
    }
  }
}
