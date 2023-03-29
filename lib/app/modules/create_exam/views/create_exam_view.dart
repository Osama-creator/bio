import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_exam_controller.dart';

class CreateExamView extends GetView<CreateExamController> {
  const CreateExamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateExamView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateExamView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
