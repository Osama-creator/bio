import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/exams_page_controller.dart';

class ExamsPageView extends GetView<ExamsPageController> {
  const ExamsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamsPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ExamsPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
