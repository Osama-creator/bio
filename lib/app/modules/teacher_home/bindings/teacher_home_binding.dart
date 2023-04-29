import 'package:get/get.dart';

import '../controllers/teacher_home_controller.dart';
import '../../grades_list/controllers/grades_list_controller.dart';
import '../../groups_list/controllers/groups_list_controller.dart';

class TeacherHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherHomeController>(() => TeacherHomeController());
    Get.lazyPut<GradesListController>(() => GradesListController());
    Get.lazyPut<GroupsListController>(() => GroupsListController());
  }
}
