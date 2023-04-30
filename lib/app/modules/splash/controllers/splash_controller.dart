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
          Get.toNamed(
            Routes.HOME,
          );
        } else {
          Get.toNamed(
            Routes.TEACHER_HOME,
          );
        }
      } else {
        Get.toNamed(
          Routes.SIGN_IN,
        );
      }
    });
  }
}
