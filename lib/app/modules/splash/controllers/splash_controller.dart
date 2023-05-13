import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkUserSignIn();
    super.onInit();
  }

  Future<void> checkUserSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('userToken');
    final userData = prefs.getString('userData');

    Future.delayed(const Duration(seconds: 2), () {
      if (userToken != null) {
        if (userData != null) {
          Get.offAndToNamed(
            Routes.HOME,
          );
        } else {
          Get.offAndToNamed(
            Routes.TEACHER_HOME,
          );
        }
      } else {
        Get.offAndToNamed(
          Routes.SIGN_IN,
        );
      }
    });
  }
}
