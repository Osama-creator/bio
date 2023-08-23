import 'package:get/get.dart';

import '../controllers/students_league_controller.dart';

class StudentsLeagueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentsLeagueController>(
      () => StudentsLeagueController(),
    );
  }
}
