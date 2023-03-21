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
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'المجموعات',
                style: context.textTheme.headline6,
              ),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.groupList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 10,
                          color: AppColors.grey,
                          child: Column(
                            children: [
                              Text(controller.groupList[index].name),
                              const Text("15 طالب")
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.CREATE_GROUP);
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
