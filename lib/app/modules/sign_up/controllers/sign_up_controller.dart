import 'dart:developer';

import 'package:bio/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/grade_item_model.dart';

class SignUpController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  var gradeList = <GradeItem>[];
  var selectedGrade = Rx<GradeItem?>(null);
  @override
  void onInit() {
    super.onInit();
    getGrades();
  }

  Future<void> getGrades() async {
    try {
      QuerySnapshot grades =
          await FirebaseFirestore.instance.collection('grades').get();
      gradeList.clear();
      for (var category in grades.docs) {
        gradeList.add(GradeItem(
          name: category['name'],
          id: category.id,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  void showGradeSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: gradeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final grade = gradeList[index];
                    return ListTile(
                      title: Text(grade.name),
                      onTap: () {
                        selectedGrade.value = grade;
                        Get.back();
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('إغلاق'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailC.text, password: passwordC.text);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameC.text,
        'email': emailC.text,
        'grade': selectedGrade.value!
            .name, // assuming gradeList is not empty and selectedGrade has been set
      });

      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'كلمه السر ضعيفه');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'هذا الحساب موجود بالفعل');
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
