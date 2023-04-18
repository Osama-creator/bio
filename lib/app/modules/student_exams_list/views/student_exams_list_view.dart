import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_exams_list_controller.dart';

class StudentExamsListView extends GetView<StudentExamsListController> {
  const StudentExamsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentExamsListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudentExamsListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
