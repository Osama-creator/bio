import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/groups_list_controller.dart';

class GroupsListView extends GetView<GroupsListController> {
  const GroupsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupsListController>(
        init: GroupsListController(),
        builder: (controller) {
          return Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //     'المجموعات',
            //     style: context.textTheme.headline6,
            //   ),
            //   centerTitle: true,
            // ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.groupList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.navigate(index);
                        },
                        onLongPress: () => controller
                            .deleteGroup(controller.groupList[index].id),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            elevation: 10,
                            color: AppColors.grey,
                            child: Column(
                              children: [
                                Text(controller.groupList[index].name),
                                Text(
                                    "${controller.groupList[index].students!.length} طالب")
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                  heroTag: "create group",
                  onPressed: () {
                    Get.offAndToNamed(Routes.CREATE_GROUP);
                  },
                  backgroundColor: AppColors.primary,
                  label: Text(
                    "إضافة مجموعه",
                    style: context.textTheme.bodyText1!.copyWith(fontSize: 16),
                  ),
                  icon: const Icon(Icons.add),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: FloatingActionButton(
                //     heroTag: "refresh",
                //     onPressed: () {
                //       controller.getData();
                //     },
                //     backgroundColor: AppColors.primary,
                //     child: const Icon(Icons.refresh),
                //   ),
                // ),
              ],
            ),
          );
        });
  }
}
