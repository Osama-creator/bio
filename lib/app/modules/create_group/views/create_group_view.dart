import 'package:bio/app/views/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.height * 0.01,
                ),
                MyTextFeild(
                  width: context.width * 0.8,
                  controller: _.groubNameController,
                  hintText: 'أدخل إسم المجموعه',
                  labelText: "إسم المجموعه",
                ),
                SizedBox(
                  height: context.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyTextFeild(
                      width: context.width * 0.45,
                      controller: _.groubPriceController,
                      hintText: 'أدخل سعر الشهر ',
                      labelText: 'سعر الشهر ',
                    ),
                    MyTextFeild(
                      width: context.width * 0.45,
                      controller: _.groubSemenarsController,
                      hintText: 'أدخل عدد الحصص',
                      labelText: ' عدد الحصص',
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: const Divider(),
                ),
                Center(
                  child: Text(
                    "الطلاب",
                    style: context.textTheme.headline6!.copyWith(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.1),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                MyTextFeild(
                  width: context.width * 0.8,
                  controller: _.groubNameController,
                  hintText: 'أدخل إسم الطالب',
                  labelText: "إسم الطالب",
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
