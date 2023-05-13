import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/group_model.dart';
import '../../../data/models/student_model.dart';

class EditGroupController extends GetxController {
  final args = Get.arguments as Group;
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentPriceController = TextEditingController();

  RxList<Studen> students = RxList<Studen>([]);

  @override
  void onInit() {
    super.onInit();

    if (args.students != null) {
      students.addAll(args.students!);
    }
  }

  void addStudent() {
    String studentName = studentNameController.text.trim();
    int? studentPrice = int.tryParse(studentPriceController.text.trim());
    int? groupPrice = args.price;

    if (studentName.isNotEmpty) {
      students.add(
        Studen(
          name: studentName,
          id: UniqueKey().toString(),
          absence: 0,
          price: studentPrice ?? groupPrice!,
        ),
      );
      studentNameController.clear();
      studentPriceController.clear();
    }
    update();
  }

  void removeStudent(int index) {
    students.remove(students[index]);
    update();
  }

  Future<void> saveChanges() async {
    // Create a new Group object with the updated data
    Group updatedGroup = Group(
      name: args.name,
      id: args.id,
      price: args.price,
      sessions: args.sessions,
      students: students.toList(),
      currentSession: args.currentSession,
    );

    // Update the group data in Firestore
    CollectionReference groupCollection =
        FirebaseFirestore.instance.collection('groups');
    await groupCollection.doc(args.id).update(updatedGroup.toJson());

    // Clear the text fields and update the UI
    studentNameController.clear();
    studentPriceController.clear();
    students.clear();

    update();
    Get.back();
  }
}
