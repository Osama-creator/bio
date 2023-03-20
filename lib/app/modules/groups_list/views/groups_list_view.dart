import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/groups_list_controller.dart';

class GroupsListView extends GetView<GroupsListController> {
  const GroupsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المجموعات',
          style: context.textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return SizedBox(
            height: context.height * 0.1,
            width: context.width * 0.8,
            child: Card(
              color: AppColors.grey,
              child: Column(
                children: const [Text("تالته ثانوي المنيا"), Text("15 طالب")],
              ),
            ),
          );
        },
      ),
    );
  }
}
