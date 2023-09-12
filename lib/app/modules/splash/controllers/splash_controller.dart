import 'dart:convert';

import 'package:bio/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkUserSignIn();
    super.onInit();
  }

  Future<void> checkUserSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    Future.delayed(const Duration(seconds: 2), () {
      if (userData != null) {
        final userDataMap = jsonDecode(userData);
        final userEmail = userDataMap['email'];
        final userPassword = userDataMap['password'];
        if (userEmail == "admin.mo@gmail.com" &&
            userPassword == "XUcr7HNBSY2g") {
          Get.offAllNamed(Routes.TEACHER_HOME);
        } else {
          Get.offAllNamed(
            Routes.HOME,
          );
        }
      } else {
        Get.offAndToNamed(Routes.SIGN_IN);
      }
    });
  }
}
