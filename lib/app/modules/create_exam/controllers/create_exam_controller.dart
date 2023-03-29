import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../helpers/pick.dart';

class CreateExamController extends GetxController {
  TextEditingController examNameController = TextEditingController();
  final List<QuestionC> questions = [];
  void addQuestion() {
    questions.add(QuestionC());
    update();
  }

  Future<void> createExam() async {}
}

class QuestionC {
  TextEditingController questionC = TextEditingController();
  TextEditingController rightAnswerC = TextEditingController();
  TextEditingController wrongAnswer1C = TextEditingController();
  TextEditingController wrongAnswer3C = TextEditingController();
  TextEditingController wrongAnswer2C = TextEditingController();
  late String imageString;
  late bool imageUploaded;
  File? image;
  Future<void> pickFile() async {
    final tempImage = await Pick.imageFromGallery();
    if (tempImage != null) {
      image = tempImage;
      Reference reference =
          FirebaseStorage.instance.ref().child(const Uuid().v1());
      final UploadTask uploadTask = reference.putFile(image!);
      uploadTask.whenComplete(
        () async {
          imageString = await uploadTask.snapshot.ref.getDownloadURL();
          imageUploaded = true;
          log(imageUploaded.toString());
        },
      );
    }
  }
}
