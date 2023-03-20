import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/groups_list_controller.dart';

class GroupsListView extends GetView<GroupsListController> {
  const GroupsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroupsListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GroupsListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
