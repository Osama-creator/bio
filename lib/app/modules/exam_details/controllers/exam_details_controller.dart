import 'dart:developer';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/question_model.dart';

class ExamDetailsController extends GetxController {
  final args = Get.arguments as List;
  late Exam exam;
  @override
  void onInit() {
    exam = args[1];
    super.onInit();
  }

  void updateQuestionInFirebase(int index, Question newQuestion) async {
    try {
      // Get the reference to the exam document in Firebase
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      // Get the question data from the exam document
      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      // Update the question data with the new question
      questionDataList[index] = newQuestion.toJson();

      // Update the exam document in Firebase with the updated question data
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
    update();
  }

  // Future<File?> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   } else {
  //     return null;
  //   }
  // }

  void removeQuestion(int index) async {
    try {
      // Get the reference to the exam document in Firebase
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      // Get the question data from the exam document
      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      // Remove the question data from the question list
      questionDataList.removeAt(index);

      // Update the exam document in Firebase with the updated question data
      await examRef.update({'questions': questionDataList});
      Get.snackbar('تم', "تم الحذف بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void addQuestion(Question newQuestion) async {
    try {
      // Get the reference to the exam document in Firebase
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      // Get the question data from the exam document
      var examData = await examRef.get();
      var questionDataList = examData['questions'];

      // Add the new question data to the question list
      questionDataList.add(newQuestion.toJson());

      // Update the exam document in Firebase with the updated question data
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

    // Set up controllers with initial values if provided
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
                // Create a new Question object with the entered data
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

                // Call the appropriate function based on whether we're editing an existing question or adding a new one
                if (initialQuestion == null) {
                  addQuestion(newQuestion);
                } else {
                  editQuestion(index, newQuestion);
                }

                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
            if (!isNew!) ...[
              TextButton(
                onPressed: () {
                  removeQuestion(index);
                  update();
                  Navigator.pop(context, true);
                },
                child: const Text('delete'),
              ),
            ]
          ],
        );
      },
    );

    // If the dialog was closed by pressing the "Save" button, update the state
    if (result == true) {
      update();
    }
  }
}
