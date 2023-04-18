import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await prefs.remove('userData');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
