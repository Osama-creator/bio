import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';

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

  Future<void> addGroup() async {
    String groupName = groupNameController.text;
    int groupPrice = int.tryParse(groupPriceController.text) ?? 0;
    int groupSeminars = int.tryParse(groupSeminarsController.text) ?? 0;

    if (groupName.isEmpty || groupPrice == 0 || groupSeminars == 0) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    List<Map<String, dynamic>> studentsData = [];

    // for (var student in students) {
    //   studentsData.add({
    //     'name': student.name,
    //     'id': student.id,
    //     'absence': student.absence,
    //   });
    // }

    Group group = Group(
      id: UniqueKey().toString(),
      name: groupName,
      price: groupPrice,
      sessions: groupSeminars.toString(),
      // students: studentsData,
    );

    try {
      await FirebaseFirestore.instance.collection('groups').add({
        'name': group.name,
        'price': group.price,
        'sessions': group.sessions,
        'students': studentsData,
      });
      Get.back();
      Get.snackbar('Success', 'Group created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
