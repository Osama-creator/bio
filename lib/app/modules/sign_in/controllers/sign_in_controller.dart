import 'dart:convert';
import 'dart:developer';

import 'package:bio/helpers/alert.dart';
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
  bool loading = false;

  Future<void> login() async {
    try {
      loading = true;
      update();
      UserCredential userCredential = await signInWithEmailAndPassword();
      final userToken = userCredential.user!.uid;
      log(userToken);
      final userData = await getUserData(userToken);

      if (userData.exists) {
        final data = userData.data()!;
        await saveUserDataToPrefs(data as Map<String, dynamic>);
        navigateToHome();
      } else {
        showLoginError();
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } catch (e) {
      handleGenericError(e);
    }
  }

  Future<UserCredential> signInWithEmailAndPassword() async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserData(String userToken) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(userToken)
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserDataToPrefs(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'userData',
        jsonEncode({
          'name': userData['name'],
          'email': userData['email'],
          'password': userData['password'],
          'grade_id': userData['grade_id'] ?? "",
          'grade': userData['grade'] ?? "",
          'marks': userData['marks'] ?? 0,
          'w_points': userData['w_points'] ?? 0,
          'confirmed': userData['confirmed'] ?? false,
        }),
      );
    } catch (e) {
      rethrow;
    }
  }

  void navigateToHome() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    loading = false;
    update();
    if (userData != null) {
      final userDataMap = jsonDecode(userData);
      final userEmail = userDataMap['email'];
      final userPassword = userDataMap['password'];
      if (userEmail == "admin.mo@gmail.com" && userPassword == "XUcr7HNBSY2g") {
        log(userEmail);
        Get.offAllNamed(Routes.TEACHER_HOME);
      } else {
        log(userEmail);
        Get.offAllNamed(
          Routes.HOME,
        );
      }
    } else {
      Get.offAndToNamed(Routes.SIGN_IN);
    }
  }

  void showLoginError() {
    loading = false;
    update();
    Alert.error("هناك مشكلة في تسجيل الدخول");
  }

  void handleFirebaseAuthError(FirebaseAuthException e) {
    loading = false;
    update();
    if (e.code == 'user-not-found') {
      Get.snackbar('Error', 'هذا الحساب غير موجود');
    } else if (e.code == 'wrong-password') {
      Get.snackbar('Error', 'كلمة السر غير صحيحة');
    }
  }

  void handleGenericError(dynamic e) {
    loading = false;
    update();
    log(e.toString());
    Get.snackbar('Error', e.toString());
  }
}
