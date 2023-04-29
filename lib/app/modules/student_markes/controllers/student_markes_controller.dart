import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentMarkesController extends GetxController {
  final exam = Get.arguments;
  bool isLoading = false;
  var marksList = <Mark>[];
  Future<void> getData() async {
    isLoading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');
      final data = jsonDecode(userData!);

      QuerySnapshot marks = await FirebaseFirestore.instance
          .collection('grades')
          .doc(data['grade_id'])
          .collection('exams')
          .doc(exam.id)
          .collection('markes')
          .get();
      marksList.clear();
      for (var mark in marks.docs) {
        marksList.add(Mark(
            examName: mark['exam_name'],
            studentName: mark['student_name'],
            id: exam.id,
            grade: mark['grade'],
            studentMark: mark['student_mark'],
            examMark: mark['student_mark']));
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
