import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grades_list_controller.dart';

class GradesListView extends GetView<GradesListController> {
  const GradesListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GradesListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GradesListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
