import 'dart:developer';
import 'dart:io';

import 'package:bio/app/data/models/question_model.dart';
import 'package:bio/helpers/pick.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EditQuistionController extends GetxController {
  final args = Get.arguments as List;

  TextEditingController questionController = TextEditingController();
  TextEditingController rightAnswerController = TextEditingController();
  TextEditingController wrongAnswer1Controller = TextEditingController();
  TextEditingController wrongAnswer2Controller = TextEditingController();
  TextEditingController wrongAnswer3Controller = TextEditingController();
  String imageString = "";
  late bool imageUploaded;
  late Question question;
  File? image;
  bool isLoading = false;
  Future<void> pickFile() async {
    final tempImage = await Pick.imageFromGallery();
    if (tempImage != null) {
      image = tempImage;
      imageString = "";
      update();
    }
  }

  void updateQuestionInFirebase() async {
    List<Future> uploadTasks = [];

    try {
      isLoading = true;
      var examRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args[0])
          .collection('exams')
          .doc(args[1].id);

      var examData = await examRef.get();
      var questionDataList = examData['questions'];
      if (image != null) {
        Reference reference =
            FirebaseStorage.instance.ref().child(const Uuid().v1());
        final UploadTask uploadTask = reference.putFile(image!);
        uploadTasks.add(uploadTask.whenComplete(() async {
          imageString = await reference.getDownloadURL();
          imageUploaded = true;
          update();
          log(imageString);
        }));
      } else {
        imageUploaded = false;
      }
      await Future.wait(uploadTasks);
      Question newQuestion = Question(
        question: questionController.text.trim(),
        rightAnswer: rightAnswerController.text.trim(),
        wrongAnswers: [
          wrongAnswer1Controller.text.trim(),
          wrongAnswer2Controller.text.trim(),
          wrongAnswer3Controller.text.trim(),
        ],
        image: imageString,
        id: const Uuid().v1(),
      );
      questionDataList[args[3]] = newQuestion.toJson();
      await examRef.update({'questions': questionDataList});
      Get.back();
      Get.snackbar('تم', "تم التعديل بنجاح");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    question = args[2];
    questionController.text = question.question!;
    rightAnswerController.text = question.rightAnswer;
    wrongAnswer1Controller.text = question.wrongAnswers![0];
    wrongAnswer2Controller.text = question.wrongAnswers![1];
    wrongAnswer3Controller.text = question.wrongAnswers![2];
    imageString = question.image!;
    // image = question.image;
    super.onInit();
  }
}
