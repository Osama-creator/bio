import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/data/models/question_model.dart';
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
          id: exam.id,
          questions: questionList,
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

  void navigateToCreateExam() {
    Get.toNamed(
      Routes.CREATE_EXAM,
      arguments: args,
    );
  }

  void navigateExamPage(int index) {
    Get.toNamed(
      Routes.EXAM_DETAILS,
      arguments: examList[index],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
