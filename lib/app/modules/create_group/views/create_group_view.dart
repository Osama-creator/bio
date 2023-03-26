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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('إنشاء المجموعة'),
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
                  controller: _.groupNameController,
                  hintText: 'أدخل إسم المجموعة',
                  labelText: "إسم المجموعة",
                ),
                SizedBox(
                  height: context.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyTextFeild(
                      width: context.width * 0.45,
                      controller: _.groupPriceController,
                      hintText: 'أدخل سعر الشهر ',
                      labelText: 'سعر الشهر ',
                    ),
                    MyTextFeild(
                      width: context.width * 0.45,
                      controller: _.groupSeminarsController,
                      hintText: 'أدخل عدد الحصص',
                      labelText: 'عدد الحصص',
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
                Expanded(
                  child: ListView.builder(
                    itemCount: _.students.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_.students[index].name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _.removeStudent(index),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MyTextFeild(
                                      width: context.width * 0.8,
                                      controller: _.studentNameController,
                                      hintText: 'أدخل إسم الطالب',
                                      labelText: "إسم الطالب",
                                      onFieldSubmitted: (_) {
                                        false;
                                      },
                                    ),
                                    MyTextFeild(
                                      width: context.width * 0.8,
                                      controller: _.studentPriceController,
                                      hintText: 'أدخل سعر الطالب (اختياري)',
                                      labelText: 'سعر الطالب (اختياري)',
                                    ),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.start,
                              actions: [
                                ElevatedButton(
                                  child: Text("إضافه",
                                      style: context.textTheme.headline1),
                                  onPressed: () {
                                    controller.addStudent();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'إضافه طالب',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    child: ElevatedButton(
                      onPressed: _.createGroup,
                      child: Text(
                        'إنشاء المجموعة',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
