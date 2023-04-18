import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_exam_preview_controller.dart';

class StudentExamPreviewView extends GetView<StudentExamPreviewController> {
  const StudentExamPreviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentExamPreviewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StudentExamPreviewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
