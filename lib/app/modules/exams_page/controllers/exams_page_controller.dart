import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/data/models/question_model.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ExamsPageController extends GetxController {
  final args = Get.arguments as GradeItem;
  bool isLoading = false;
  var examList = <Exam>[];
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot exams = await FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('exams')
          .get();
      examList.clear();
      for (var exam in exams.docs) {
        List<dynamic> questionDataList = exam['questions'];
        List<Question> questionList = [];

        for (var questionData in questionDataList) {
          List<dynamic> wrongAnswers = questionData['wrong_answer'];
          questionList.add(Question(
              question: questionData['question'],
              id: questionData['id'],
              rightAnswer: questionData['right_answer'],
              image: questionData['image'],
              wrongAnswers: [wrongAnswers[0], wrongAnswers[1], wrongAnswers[2]]
                ..shuffle()));
        }

        examList.add(Exam(
          name: exam['name'],
          date: (exam['date'] as Timestamp).toDate(),
          id: exam.id,
          isActive: exam['is_active'],
          questions: questionList,
        ));
      }

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

  Future<void> deleteGroup(String examId) async {
    try {
      await FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('exams')
          .doc(examId)
          .delete();
      examList.removeWhere((exam) => exam.id == examId);
      update();
      Get.snackbar('تم بنجاح', 'تم حذف الإمتحان بنجاح',
          backgroundColor: AppColors.grey);
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
