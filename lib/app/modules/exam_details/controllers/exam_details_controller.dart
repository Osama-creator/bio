import 'dart:developer';
import 'dart:io';

import 'package:bio/app/data/models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  void showEditQuestionSheet(int index) async {
    // Get the current question data
    Question question = exam.questions[index];

    // Create controllers for the text fields
    TextEditingController questionController =
        TextEditingController(text: question.question);
    TextEditingController rightAnswerController =
        TextEditingController(text: question.rightAnswer);
    TextEditingController wrongAnswer1Controller =
        TextEditingController(text: question.wrongAnswers![0]);
    TextEditingController wrongAnswer2Controller =
        TextEditingController(text: question.wrongAnswers![1]);
    TextEditingController wrongAnswer3Controller =
        TextEditingController(text: question.wrongAnswers![2]);

    // Create a variable to track the image file
    File? image;
    bool? result = await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Edit Question'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add an image picker and a button to delete the current image
                      if (question.image != null)
                        Column(
                          children: [
                            Image.network(
                              question.image!,
                              height: 200,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    // Open the image picker to select a new image
                                    File? pickedImage = await pickImage();
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                      });
                                    }
                                  },
                                  child: const Text('Change Image'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Remove the current image
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  child: const Text('Delete Image'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (question.image == null)
                        ElevatedButton(
                          onPressed: () async {
                            // Open the image picker to select an image
                            File? pickedImage = await pickImage();
                            if (pickedImage != null) {
                              setState(() {
                                image = pickedImage;
                              });
                            }
                          },
                          child: const Text('Add Image'),
                        ),
                      const SizedBox(height: 16),
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
                    onPressed: () async {
                      // Upload the new image, if there is one
                      String? imageUrl;
                      if (image != null) {
                        Reference reference = FirebaseStorage.instance
                            .ref()
                            .child(const Uuid().v1());
                        final UploadTask uploadTask = reference.putFile(image!);
                        await uploadTask.whenComplete(() async {
                          imageUrl = await reference.getDownloadURL();
                        });
                      }

                      // Update the question data
                      Question updatedQuestion = Question(
                        id: question.id,
                        question: questionController.text,
                        rightAnswer: rightAnswerController.text,
                        wrongAnswers: [
                          wrongAnswer1Controller.text,
                          wrongAnswer2Controller.text,
                          wrongAnswer3Controller.text,
                        ],
                        image: imageUrl,
                      );

                      exam.questions[index] = updatedQuestion;

                      updateQuestionInFirebase(index, updatedQuestion);

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        });
  }

// markes for student  done
//  and teacher  done
// end exam for student done
// sign in handling done
// screens connecting done
// log out
// edit exam for teacher done 0.5

// ui beatufing
// error handling
// student profile
// clean & orgs code

}
