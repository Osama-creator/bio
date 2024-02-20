import 'dart:developer';
import 'dart:io';

import 'package:bio/app/services/exam/exam.dart';
import 'package:bio/helpers/Image_Picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewQuistionController extends GetxController {
  final args = Get.arguments as List;
  String imageString = "";
  late bool imageUploaded;
  File? image;
  bool isLoading = false;

  final examService = ExamService();
  TextEditingController questionController = TextEditingController();
  TextEditingController rightAnswerController = TextEditingController();
  TextEditingController wrongAnswer1Controller = TextEditingController();
  TextEditingController wrongAnswer2Controller = TextEditingController();
  TextEditingController wrongAnswer3Controller = TextEditingController();

  Future<void> pickFile() async {
    final tempImage = await ImageHelper.pickFile();
    if (tempImage != null) {
      image = tempImage;
      update();
    }
  }

  Future<void> addQuestion() async {
    try {
      isLoading = true;
      update();

      final examRef = FirebaseFirestore.instance.collection('grades').doc(args[0]).collection('exams').doc(args[1].id);

      await uploadPhotos();
      await examService.addQuestion(
        args,
        examRef,
        imageString,
        questionController.text.trim(),
        rightAnswerController.text.trim(),
        [
          wrongAnswer1Controller.text.trim(),
          wrongAnswer2Controller.text.trim(),
          wrongAnswer3Controller.text.trim(),
        ],
      );
      Get.back();
      Get.snackbar('تم', "تمت الإضافة بنجاح");
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> uploadPhotos() async {
    if (image != null) {
      imageString = await ImageHelper.uploadPhoto(image!);
      imageUploaded = true;
      update();
    } else {
      imageUploaded = false;
    }
  }
}
