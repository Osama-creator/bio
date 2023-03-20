import 'package:get/get.dart';

import '../controllers/groups_list_controller.dart';

class GroupsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsListController>(
      () => GroupsListController(),
    );
  }
}
