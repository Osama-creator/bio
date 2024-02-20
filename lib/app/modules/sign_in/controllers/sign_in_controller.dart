import 'dart:convert';
import 'dart:developer';

import 'package:bio/app/services/auth_service.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:bio/helpers/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final authService = AuthService();
  final localDataService = UserDataService();
  Rx<bool> isTeacher = false.obs;
  bool loading = false;

  Future<void> login() async {
    try {
      loading = true;
      update();
      UserCredential userCredential = await authService.signInWithEmailAndPassword(emailC.text, passwordC.text);
      final userToken = userCredential.user!.uid;
      log(userToken);
      final userData = await authService.getUserData(userToken);

      if (userData.exists) {
        final data = userData.data()!;
        await localDataService.saveUserDataToPrefs(data as Map<String, dynamic>);
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
