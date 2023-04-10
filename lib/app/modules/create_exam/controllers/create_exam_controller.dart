import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../helpers/pick.dart';
import '../../../data/models/exam_model.dart';
import '../../../data/models/grade_item_model.dart';
import '../../../data/models/question_model.dart';

class CreateExamController extends GetxController {
  final args = Get.arguments as GradeItem;
  TextEditingController examNameController = TextEditingController();
  final List<QuestionC> questions = [];
  bool isLoading = false;

  void addQuestion() {
    questions.add(QuestionC());
    update();
  }

  Future<void> createExam() async {
    isLoading = true;
    String examName = examNameController.text.trim();
    List<Question> examQuestions = [];
    List<Future> uploadTasks = []; // keep track of all the upload tasks

    for (var questionC in questions) {
      // pick the image file and start uploading it
      if (questionC.image != null) {
        Reference reference =
            FirebaseStorage.instance.ref().child(const Uuid().v1());
        final UploadTask uploadTask = reference.putFile(questionC.image!);
        uploadTasks.add(uploadTask.whenComplete(() async {
          questionC.imageString = await reference.getDownloadURL();
          questionC.imageUploaded = true;
          log(questionC.imageString);
        }));
      } else {
        questionC.imageUploaded = false;
      }
    }

    // wait for all the upload tasks to complete
    await Future.wait(uploadTasks);

    // create the Question objects with the imageString property
    for (var questionC in questions) {
      examQuestions.add(Question(
        question: questionC.questionC.text.trim(),
        rightAnswer: questionC.rightAnswerC.text.trim(),
        wrongAnswers: [
          questionC.wrongAnswer1C.text.trim(),
          questionC.wrongAnswer2C.text.trim(),
          questionC.wrongAnswer3C.text.trim(),
        ],
        image: questionC.imageString, // set the imageString property here
        id: const Uuid().v1(),
      ));
    }

    Exam newExam = Exam(
      name: examName,
      id: const Uuid().v1(),
      questions: examQuestions,
    );

    try {
      CollectionReference examCollection = FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('exams');

      await examCollection.add(newExam.toJson());
      isLoading = false;
      update();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }
}

class QuestionC {
  TextEditingController questionC = TextEditingController();
  TextEditingController rightAnswerC = TextEditingController();
  TextEditingController wrongAnswer1C = TextEditingController();
  TextEditingController wrongAnswer3C = TextEditingController();
  TextEditingController wrongAnswer2C = TextEditingController();
  String imageString = "";
  late bool imageUploaded;
  File? image;

  Future<void> pickFile() async {
    final tempImage = await Pick.imageFromGallery();
    if (tempImage != null) {
      image = tempImage;
    }
  }
}
