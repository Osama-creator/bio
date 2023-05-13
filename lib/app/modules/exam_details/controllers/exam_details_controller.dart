import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/question_model.dart';

class ExamDetailsController extends GetxController {
  final args = Get.arguments as List;
  RxList<Question> questions = RxList<Question>([]);
  late Exam exam;
  @override
  void onInit() {
    exam = args[1];
    questions.addAll(args[1].questions!);
    super.onInit();
  }

  void updateQuestionInFirebase(int index, Question newQuestion) async {
    try {
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questionDataList[index] = newQuestion.toJson();

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تم التعديل بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void editQuestion(int index, Question newQuestion) {
    args[1].questions[index] = newQuestion;
    updateQuestionInFirebase(index, newQuestion);
    questions[index] = newQuestion; // update the question in the RxList
    update(); // rebuild the widget with the updated question
  }

  void removeQuestion(int index) async {
    try {
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questions.remove(questions[index]);
      update();
      questionDataList.removeAt(index);

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تم الحذف بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void addQuestion(Question newQuestion) async {
    try {
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      questions.add(newQuestion);
      update();
      questionDataList.add(newQuestion.toJson());

      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تمت الإضافة بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void showEditQuestionSheet(
      {Question? initialQuestion, bool? isNew, int? index}) async {
    Question question = exam.questions[index!];

    TextEditingController questionController =
        TextEditingController(text: initialQuestion?.question ?? '');
    TextEditingController rightAnswerController =
        TextEditingController(text: initialQuestion?.rightAnswer ?? '');
    TextEditingController wrongAnswer1Controller =
        TextEditingController(text: initialQuestion?.wrongAnswers?[0] ?? '');
    TextEditingController wrongAnswer2Controller =
        TextEditingController(text: initialQuestion?.wrongAnswers?[1] ?? '');
    TextEditingController wrongAnswer3Controller =
        TextEditingController(text: initialQuestion?.wrongAnswers?[2] ?? '');

    bool? result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                  ),
                ),
                TextField(
                  controller: rightAnswerController,
                  decoration: const InputDecoration(
                    labelText: 'Right Answer',
                  ),
                ),
                TextField(
                  controller: wrongAnswer1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 1',
                  ),
                ),
                TextField(
                  controller: wrongAnswer2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 2',
                  ),
                ),
                TextField(
                  controller: wrongAnswer3Controller,
                  decoration: const InputDecoration(
                    labelText: 'Wrong Answer 3',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Question newQuestion = Question(
                  id: question.id ?? const Uuid().v1(),
                  image: question.image ?? "",
                  question: questionController.text,
                  rightAnswer: rightAnswerController.text,
                  wrongAnswers: [
                    wrongAnswer1Controller.text,
                    wrongAnswer2Controller.text,
                    wrongAnswer3Controller.text,
                  ],
                );

                if (initialQuestion == null) {
                  addQuestion(newQuestion);
                } else {
                  editQuestion(index, newQuestion);
                }
                update();
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      update();
    }
  }
}
