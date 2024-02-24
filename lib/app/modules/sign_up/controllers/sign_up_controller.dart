import 'dart:developer';
import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/mixins/select_grade.dart';
import 'package:bio/app/routes/app_pages.dart';
import 'package:bio/app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController with SelectGrade {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  Rx<bool> isTeacher = false.obs;
  bool isLoading = false;
  final authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    getGrades();
  }

  Future<void> signUp() async {
    try {
      isLoading = true;
      update();
      Student student = Student(
        name: nameC.text.trim(),
        grade: selectedGrade!.name,
        password: passwordC.text,
        email: emailC.text,
        isConfirmed: false,
        marks: 0,
        wPoints: 0,
        gradeId: selectedGrade!.id,
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
