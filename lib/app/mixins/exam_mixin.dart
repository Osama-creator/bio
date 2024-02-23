import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/data/models/question_model.dart';
import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

mixin ExamHelper on GetxController {
  late PageController pageController;
  final exam = Get.arguments;
  int qNumber = 1;
  Student? student;
  RxBool isLoading = false.obs;
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

  Mark createStudentMark(Student stdn) {
    return Mark(
      examName: exam.name,
      grade: stdn.grade,
      id: const Uuid().v1(),
      studentMark: finalMark(),
      studentName: stdn.name,
      email: stdn.email,
      examMark: quistionList().length,
    );
  }

  Map<String, dynamic> calculateUserPerformance(QuerySnapshot userSnapshot, Mark studentmark) {
    final userDoc = userSnapshot.docs[0];
    final userMarks = userDoc['marks'] + studentmark.studentMark;
    final userWPoints = userDoc['w_points'] + studentmark.studentMark;
    String userNickname = "";
    final userWrongAns = userDoc['wrong_answers'] + (quistionList().length - studentmark.studentMark);
    final userRightAns = userDoc['right_answers'] + studentmark.studentMark;
    final userExamsCount = userDoc['exam_count'] + 1;

    int totalQuestions = quistionList().length;
    int userMark = studentmark.studentMark;
    String currentNickname = userDoc.get('nickname');

    switch (totalQuestions - userMark) {
      case 0:
        userNickname = "النجم الساحق";
        break;
      case 1:
        userNickname = "المحارب الطموح";
        break;
      case 2:
        userNickname = "المثابر";
        break;
      default:
        userNickname = "المثابر";
    }

    return {
      'userMarks': userMarks,
      'userWPoints': userWPoints,
      'userNickname': userNickname,
      'userWrongAns': userWrongAns,
      'userRightAns': userRightAns,
      'userExamsCount': userExamsCount,
      'currentNickname': currentNickname,
    };
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
}
