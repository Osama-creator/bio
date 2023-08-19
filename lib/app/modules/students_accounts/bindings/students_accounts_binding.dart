import 'package:get/get.dart';

import '../controllers/students_accounts_controller.dart';

class StudentsAccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentsAccountsController>(
      () => StudentsAccountsController(),
    );
  }
}
