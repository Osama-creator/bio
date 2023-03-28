import 'dart:developer';

import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradesListController extends GetxController {
  TextEditingController gradeNameCont = TextEditingController();
  Future<void> createGrade() async {
    String gradeName = gradeNameCont.text.trim();
    GradeItem newGroup = GradeItem(
      name: gradeName,
      id: UniqueKey().toString().trim(),
    );
    try {
      CollectionReference groupCollection =
          FirebaseFirestore.instance.collection('grades');
      await groupCollection.add(newGroup.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }
}
