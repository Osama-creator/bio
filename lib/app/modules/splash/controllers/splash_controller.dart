import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/routes/app_pages.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final userDataService = UserDataService();
  Student? student;
  @override
  void onInit() {
    checkUserSignIn();
    super.onInit();
  }

  Future<void> checkUserSignIn() async {
    student = await userDataService.getUserFromLocal();
    Future.delayed(const Duration(seconds: 2), () {
      if (student != null) {
        if (student!.email == "admin.mo@gmail.com" && student!.password == "XUcr7HNBSY2g") {
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
