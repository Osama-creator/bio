// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/data/models/mark.dart';
import 'package:bio/app/modules/home/controllers/home_controller.dart';
import 'package:bio/config/utils/colors.dart';
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

  Future<void> uploadMarkAndUpdateUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    final data = jsonDecode(userData!);
    final existingMarkSnapshot = await getExistingMarkSnapshot(data);
    if (existingMarkSnapshot.docs.isNotEmpty) {
      Get.snackbar('Error', 'Mark already uploaded');
      return;
    } else {
      try {
        isLoading.value = true;

        final studentmark = createStudentMark(data);
        final markesCollection = FirebaseFirestore.instance
            .collection('grades')
            .doc(data['grade_id'])
            .collection('exams')
            .doc(exam.id)
            .collection('markes');
        markesCollection.add(studentmark.toJson());
        final userSnapshot = await getUserSnapshot(data);
        final documentId = userSnapshot.docs[0].id;
        final userPerformance =
            calculateUserPerformance(userSnapshot, studentmark);
        final currentNickname = userPerformance['currentNickname'];
        if (currentNickname.isEmpty) {
          await updateUserData(documentId, userPerformance);
        }
        Get.find<HomeController>().getData();
      } catch (e, st) {
        log(st.toString());
      } finally {
        isLoading.value = true;
        Get.back();
      }
    }
  }

  Future<void> showConfirmationDialog(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تأكيد التسليم',
            style: TextStyle(color: AppColors.black),
          ),
          content: const Text('هل انت متأكد من إنهاء الاختبار؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('لا'),
            ),
            Obx(
              () => TextButton(
                onPressed: () async {
                  await uploadMarkAndUpdateUserData();
                  final prefs = await SharedPreferences.getInstance();
                  Get.offAllNamed(Routes.STUDENT_EXAM_PREVIEW,
                      arguments: [quistionList(), finalMark(), exam]);
                  prefs.setString('exam_${exam.id}', "exam had been entered");
                },
                child: isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('نعم'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<QuerySnapshot> getExistingMarkSnapshot(data) async {
    return await FirebaseFirestore.instance
        .collection('grades')
        .doc(data['grade_id'])
        .collection('exams')
        .doc(exam.id)
        .collection('markes')
        .where('email', isEqualTo: data['email'])
        .get();
  }

  Mark createStudentMark(data) {
    return Mark(
      examName: exam.name,
      grade: data['grade'],
      id: const Uuid().v1(),
      studentMark: finalMark(),
      studentName: data['name'],
      email: data['email'],
      examMark: quistionList().length,
    );
  }

  Future<QuerySnapshot> getUserSnapshot(data) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');

    if (userData == null) {
      throw Exception("User data not found in SharedPreferences");
    }
    final userDataMap = jsonDecode(userData);
    final userEmail = userDataMap['email'];
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  Map<String, dynamic> calculateUserPerformance(
      QuerySnapshot userSnapshot, Mark studentmark) {
    final userDoc = userSnapshot.docs[0];
    final userMarks = userDoc['marks'] + studentmark.studentMark;
    final userWPoints = userDoc['w_points'] + studentmark.studentMark;
    String userNickname = "";
    final userWrongAns = userDoc['wrong_answers'] +
        (quistionList().length - studentmark.studentMark);
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
        userNickname = "";
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

  Future<void> updateUserData(documentId, userPerformance) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({
      'marks': userPerformance['userMarks'],
      'w_points': userPerformance['userWPoints'],
      'wrong_answers': userPerformance['userWrongAns'],
      'right_answers': userPerformance['userRightAns'],
      'exam_count': userPerformance['userExamsCount'],
      'nickname': userPerformance['userNickname'],
    });
  }

  Future<void> goToNextPage(int index, BuildContext context) async {
    if (qNumber < quistionList().length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      qNumber++;
    } else {
      bool hasUnansweredQuestions = false;
      for (var element in quistionList()) {
        if (element.userChoice == null) {
          hasUnansweredQuestions = true;
          break;
        }
      }
      if (hasUnansweredQuestions) {
        Get.snackbar('تحذير', "يوجد أسئلة لم يتم الجواب عليها.");
      } else {
        await showConfirmationDialog(context);
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
