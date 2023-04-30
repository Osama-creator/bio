import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  Rx<bool> isTeacher = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkUserSignIn();
  }

  Future<void> checkUserSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('userToken');
    if (userToken != null) {
      final userData = prefs.getString('userData');
      if (userData != null) {
        final data = jsonDecode(userData);
        Get.offAllNamed(Routes.HOME, arguments: data);
      }
    }
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailC.text, password: passwordC.text);

      final prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('userToken');
      if (userToken != null && isTeacher == false) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(userToken)
            .get();
        if (userData.exists) {
          final data = userData.data()!;
          await prefs.setString(
              'userData',
              jsonEncode({
                'name': data['name'],
                'email': data['email'],
                'grade_id': data['grade_id'],
                'grade': data['grade'],
              }));
          Get.offAllNamed(Routes.HOME, arguments: data);
        }
      } else if (isTeacher.value && emailC.text == "mohammed@gmail.com") {
        Get.offAllNamed(Routes.TEACHER_HOME);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'هذا الحساب غير موجود');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'كلمة السر غير صحيحة');
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
