import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentMarkesForTeacherController extends GetxController {
  final args = Get.arguments as List<dynamic>;
  bool isLoading = false;
  var marksList = <Mark>[];
  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot marks = await FirebaseFirestore.instance
          .collection('grades')
          .doc(args[1]!.id)
          .collection('exams')
          .doc(args[0]!.id)
          .collection('markes')
          .get();
      marksList.clear();
      for (var mark in marks.docs) {
        marksList.add(Mark(
            examName: mark['exam_name'],
            studentName: mark['student_name'],
            grade: mark['grade'],
            studentMark: mark['student_mark'],
            examMark: mark['exam_mark']));
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
