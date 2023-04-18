import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_exam_controller.dart';

class StudentExamView extends GetView<StudentExamController> {
  const StudentExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentExamView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudentExamView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
