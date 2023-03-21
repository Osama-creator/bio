import 'package:bio/app/data/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class GroupsListController extends GetxController {
  bool isLoading = false;
  var groupList = <Group>[];
  bool error = false;

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot categories =
          await FirebaseFirestore.instance.collection('groups').get();
      groupList.clear();
      for (var category in categories.docs) {
        groupList.add(Group(
          name: category['name'],
          id: category.id,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      error = true;
    } finally {
      isLoading = false;
      update();
    }
  }

  void navigate(int index) {
    Get.toNamed(
      Routes.SHOW_GRUOP_DETAILS,
      arguments: groupList[index],
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
