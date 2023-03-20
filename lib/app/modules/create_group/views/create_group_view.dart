import 'package:bio/app/views/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_group_controller.dart';

class CreateGroupView extends GetView<CreateGroupController> {
  const CreateGroupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء المجموعه'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<CreateGroupController>(
          init: CreateGroupController(),
          builder: (_) {
            return Column(
              children: [
                MyTextFeild(
                  controller: _.groubNameController,
                  hintText: 'أدخل إسم المجموعه',
                  labelText: "إسم المجموعه",
                ),
              ],
            );
          }),
    );
  }
}
