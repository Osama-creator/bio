import 'dart:developer';

import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradesListController extends GetxController {
  bool isLoading = false;
  TextEditingController gradeNameCont = TextEditingController();
  var gradeList = <GradeItem>[];
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
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot grades =
          await FirebaseFirestore.instance.collection('grades').get();
      gradeList.clear();
      for (var category in grades.docs) {
        gradeList.add(GradeItem(
          name: category['name'],
          id: category['id'],
        ));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
