import 'package:bio/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../data/models/student_model.dart';

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

  Future<void> createGroup() async {
    // Get the entered data
    String groupName = groupNameController.text.trim();
    int? groupPrice = int.tryParse(groupPriceController.text.trim());
    String? groupSessionsNumber = groupSeminarsController.text.trim();
    List<Studen>? groupStudents = students.isNotEmpty
        ? students
            .toList()
            .map((e) => Studen(name: e, id: UniqueKey().toString(), absence: 0))
            .toList()
        : null;

    // Create a new Group object
    Group newGroup = Group(
      name: groupName,
      id: UniqueKey().toString(),
      price: groupPrice,
      sessions: groupSessionsNumber,
      students: groupStudents,
    );

    // Add the new Group object to the "group" collection in Firestore
    CollectionReference groupCollection =
        FirebaseFirestore.instance.collection('groups');
    await groupCollection.add(newGroup.toJson());

    // Clear the text fields and update the UI
    groupNameController.clear();
    groupPriceController.clear();
    groupSeminarsController.clear();
    students.clear();
    update();
    Get.offAndToNamed(Routes.GROUPS_LIST);
  }
}
