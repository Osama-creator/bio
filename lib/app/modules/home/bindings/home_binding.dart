import 'package:bio/app/modules/students_league/controllers/students_league_controller.dart';
import 'package:bio/app/modules/videos_page/controllers/videos_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<StudentsLeagueController>(() => StudentsLeagueController());
    Get.lazyPut<VideosPageController>(() => VideosPageController());
  }
}
