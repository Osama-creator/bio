import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/question_model.dart';
import '../../../routes/app_pages.dart';

class StudentExamController extends GetxController {
  late PageController pageController;
  final exam = Get.arguments;

  int qNumber = 1;
  List<Question> quistionList() {
    return exam.questions;
  }

  int qIndex() {
    int n = pageController.hasClients ? pageController.page?.toInt() ?? 0 : 0;
    update();
    return n;
  }

  void selectChoice(String value) {
    final currentQuestion = quistionList()[pageController.page!.toInt()];
    currentQuestion.userChoice = value;
    update();
  }

  bool hasNoAnswer() {
    late bool qDidnotAnswerd;
    for (var qAnswer in quistionList()) {
      if (qAnswer.userChoice == null) {
        return qDidnotAnswerd = true;
      } else {
        return qDidnotAnswerd = false;
      }
    }
    return qDidnotAnswerd;
  }

  Future<void> uploadMark() async {
    Mark studentmark = Mark(
      examName: exam.name,
      grade: "الثالث الثانوي",
      id: const Uuid().v1(),
      studentMark: finalMark(),
      studentName: "اسامه",
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');
      final data = jsonDecode(userData!);
      CollectionReference markesCollection = FirebaseFirestore.instance
          .collection('grades')
          .doc(data['grade'])
          .collection('exams')
          .doc('GFE3Z1J8bRLyG056cgpb')
          .collection('markes');
      markesCollection.add(studentmark.toJson());
      update();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void goToNextPage(int index) {
    if (qNumber < quistionList().length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      qNumber++;
      update();
    } else {
      if (hasNoAnswer()) {
        Get.snackbar('تحذير', "يوجد اسئله لم يتم الجواب عليها");
      } else {
        uploadMark();
        Get.offAndToNamed(Routes.STUDENT_EXAM_PREVIEW,
            arguments: [quistionList(), finalMark()]);
      }
    }

    update();
  }

  void goToPrevPage(int index) {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    qNumber > 1 ? qNumber-- : null;
    update();
  }

  int finalMark() {
    int mark = 0;
    for (int i = 0; i < quistionList().length; i++) {
      if (quistionList()[i].userChoice == quistionList()[i].rightAnswer) {
        mark++;
      }
    }

    return mark;
  }

  @override
  void onInit() {
    pageController = PageController();

    super.onInit();
  }
}
