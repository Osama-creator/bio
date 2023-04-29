import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class TeacherHomeController extends GetxController {
  Future<void> checkUserSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('userToken');
    if (userToken == null) {
      Get.offAllNamed(
        Routes.SIGN_IN,
      );
    }
  }

  @override
  void onInit() {
    checkUserSignIn();
    super.onInit();
  }
}
