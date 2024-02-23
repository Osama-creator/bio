import 'dart:developer';
import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/services/exam/exam.dart';
import 'package:bio/app/services/exam/teacher_exam_side.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ExamsPageController extends GetxController {
  final args = Get.arguments as GradeItem;
  bool isLoading = false;
  var examList = <Exam>[];
  final examService = ExamService();
  final teacherExamService = TeacherExamService();
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    try {
      examList = await examService.getExams(args.id, true);
      examList.sort((a, b) => a.date.compareTo(b.date));
    } catch (e, st) {
      // Get.snackbar('Error', e.toString());
      log("stack : $st");
      log("stack : $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteExam(String examId) async {
    try {
      examList = await teacherExamService.deleteExam(examId: examId, gradeId: args.id);
      Get.snackbar('تم بنجاح', 'تم حذف الإمتحان بنجاح', backgroundColor: AppColors.grey);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  Future<void> updateExamActivation(String examId, bool isActive) async {
    try {
      await FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('exams')
          .doc(examId)
          .update({'is_active': isActive});

      final examIndex = examList.indexWhere((exam) => exam.id == examId);

      if (examIndex != -1) {
        examList[examIndex].isActive = isActive;

        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void navigateToCreateExam() {
    Get.toNamed(
      Routes.CREATE_EXAM,
      arguments: args,
    );
  }

  void navigateExamPage(int index) {
    Get.toNamed(
      Routes.EXAM_DETAILS,
      arguments: [args.id, examList[index]],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
