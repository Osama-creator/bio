import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_quistion_controller.dart';

class EditQuistionView extends GetView<EditQuistionController> {
  const EditQuistionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditQuistionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditQuistionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
