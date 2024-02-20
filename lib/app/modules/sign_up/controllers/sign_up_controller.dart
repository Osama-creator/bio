import 'dart:developer';
import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/routes/app_pages.dart';
import 'package:bio/app/services/auth_service.dart';
import 'package:bio/app/services/utils_service.dart';
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
  Rx<bool> isTeacher = false.obs;
  bool isLoading = false;
  final utilsService = UtilsService();
  final authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    getGrades();
  }

  Future<void> getGrades() async {
    try {
      gradeList = await utilsService.getGradesFromApi();
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
      isLoading = true;
      update();
      Student student = Student(
        name: nameC.text.trim(),
        grade: selectedGrade.value!.name,
        password: passwordC.text,
        email: emailC.text,
        isConfirmed: false,
        marks: 0,
        wPoints: 0,
        gradeId: selectedGrade.value!.id,
      );
      await authService.signUp(student, emailC.text, passwordC.text);
      isLoading = false;
      update();
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'كلمه السر ضعيفه');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'هذا الحساب موجود بالفعل');
      }
    } catch (e) {
      isLoading = false;
      update();
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
