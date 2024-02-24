import 'package:bio/app/mixins/add_exist_questoins.dart';
import 'package:bio/app/modules/admin_add_videos/controllers/admin_add_videos_controller.dart';
import 'package:bio/app/modules/students_accounts/controllers/students_accounts_controller.dart';
import 'package:get/get.dart';

import '../controllers/exams_page_controller.dart';

class ExamsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MixinService>(() => MixinService(), fenix: true);
    Get.lazyPut<ExamsPageController>(() => ExamsPageController(), fenix: true);
    Get.lazyPut<AdminAddVideosController>(() => AdminAddVideosController(), fenix: true);
    Get.lazyPut<StudentsAccountsController>(() => StudentsAccountsController(), fenix: true);
  }
}
