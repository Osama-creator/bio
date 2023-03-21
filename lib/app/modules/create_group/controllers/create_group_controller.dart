import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController groupPriceController = TextEditingController();
  TextEditingController groupSeminarsController = TextEditingController();

  RxList<String> students = RxList<String>([]);

  void addStudent() {
    String studentName = studentNameController.text.trim();
    if (studentName.isNotEmpty) {
      students.add(studentName);
      studentNameController.clear();
    }
    update();
  }

  void removeStudent(int index) {
    students.remove(students[index]);
    update();
  }
}
