import 'package:bio/app/mixins/add_exist_questoins.dart';
import 'package:bio/app/modules/admin_add_videos/controllers/admin_add_videos_controller.dart';
import 'package:bio/app/modules/students_accounts/controllers/students_accounts_controller.dart';
import 'package:get/get.dart';

import '../controllers/exams_page_controller.dart';

class ExamsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MixinService>(() => MixinService());
    Get.lazyPut<ExamsPageController>(() => ExamsPageController());
    Get.lazyPut<AdminAddVideosController>(() => AdminAddVideosController());
    Get.lazyPut<StudentsAccountsController>(() => StudentsAccountsController());
  }
}
