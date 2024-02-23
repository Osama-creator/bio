// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'dart:developer';
import 'package:bio/app/mixins/exam_mixin.dart';
import 'package:bio/app/modules/home/controllers/home_controller.dart';
import 'package:bio/app/services/exam/students_exam.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class StudentExamController extends GetxController with ExamHelper {
  final examService = StdnExamService();
  final userDataService = UserDataService();
  Future<void> uploadMarkAndUpdateUserData() async {
    student = await userDataService.getUserFromLocal();
    final existingMarkSnapshot = await examService.getExistingMarkSnapshot(student!, exam);
    if (existingMarkSnapshot.docs.isNotEmpty) {
      Get.snackbar('Error', 'Mark already uploaded');
      return;
    } else {
      try {
        isLoading.value = true;
        final studentmark = createStudentMark(student!);
        examService.uploadMarkAndUpdateUserData(studentmark, student!.gradeId, exam.id);
        final userSnapshot = await examService.getUserSnapshot(student!.email);
        final documentId = userSnapshot.docs[0].id;
        final userPerformance = calculateUserPerformance(userSnapshot, studentmark);
        final currentNickname = userPerformance['currentNickname'];
        await examService.updateUserData(documentId, userPerformance);
        Get.find<HomeController>().getExamsData();
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
                  Get.offAllNamed(Routes.STUDENT_EXAM_PREVIEW, arguments: [quistionList(), finalMark(), exam]);
                  prefs.setString('exam_${exam.id}', "exam had been entered");
                },
                child: isLoading.value ? const CircularProgressIndicator() : const Text('نعم'),
              ),
            ),
          ],
        );
      },
    );
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
