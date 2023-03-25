import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_session_controller.dart';

class CreateSessionView extends GetView<CreateSessionController> {
  const CreateSessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateSessionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateSessionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
