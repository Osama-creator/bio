import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/modules/home/controllers/home_controller.dart';
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
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    final data = jsonDecode(userData!);

    // Check if the mark already exists
    final existingMarkSnapshot = await FirebaseFirestore.instance
        .collection('grades')
        .doc(data['grade_id'])
        .collection('exams')
        .doc(exam.id)
        .collection('markes')
        .where('email', isEqualTo: data['email'])
        .get();

    if (existingMarkSnapshot.docs.isNotEmpty) {
      Get.snackbar('Error', 'Mark already uploaded');
      return;
    } else {
      Mark studentmark = Mark(
          examName: exam.name,
          grade: data['grade'],
          id: const Uuid().v1(),
          studentMark: finalMark(),
          studentName: data['name'],
          email: data['email'],
          examMark: quistionList().length);

      try {
        CollectionReference markesCollection = FirebaseFirestore.instance
            .collection('grades')
            .doc(data['grade_id'])
            .collection('exams')
            .doc(exam.id)
            .collection('markes');
        final prefs = await SharedPreferences.getInstance();
        final userData = prefs.getString('userData');
        if (userData == null) {
          throw Exception("User data not found in SharedPreferences");
        }
        final userDataMap = jsonDecode(userData);
        final userEmail = userDataMap['email'];
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();
        final userMarks = userSnapshot.docs[0]['marks'] + finalMark();
        log(userMarks.toString());
        String documentId = userSnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update({'marks': userMarks});
        markesCollection.add(studentmark.toJson());
        Get.find<HomeController>().getData();
        update();
        Get.back();
      } catch (e) {
        Get.snackbar('Error', e.toString());
        log(e.toString());
      }
    }
  }

  void goToNextPage(int index) async {
    if (qNumber < quistionList().length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      qNumber++;
      update();
    } else {
      final prefs = await SharedPreferences.getInstance();
      if (hasNoAnswer()) {
        Get.snackbar('تحذير', "يوجد اسئله لم يتم الجواب عليها");
      } else {
        await uploadMark();
        Get.offAllNamed(Routes.STUDENT_EXAM_PREVIEW,
            arguments: [quistionList(), finalMark(), exam]);
        prefs.setString('exam_${exam.id}', "exam had been entered");
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
  void onInit() async {
    pageController = PageController();
    final prefs = await SharedPreferences.getInstance();
    final examInfo = prefs.getString('exam_${exam.id}');
    if (examInfo != null) {
      Get.offAndToNamed(Routes.STUDENT_MARKES, arguments: exam);
    }

    super.onInit();
  }
}
