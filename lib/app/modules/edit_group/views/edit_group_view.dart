import 'package:bio/app/views/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/edit_group_controller.dart';

class EditGroupView extends GetView<EditGroupController> {
  const EditGroupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditGroupController>(
        init: EditGroupController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.args.name),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  _.saveChanges();
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      final student = controller.students[index];
                      return ListTile(
                          title: Text(
                            student.name,
                            style: context.textTheme.bodyText1!
                                .copyWith(color: AppColors.black),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _.removeStudent(index);
                            },
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddStudent(controller: _),
                ),
              ],
            ),
          );
        });
  }
}

class AddStudent extends StatelessWidget {
  const AddStudent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditGroupController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
      child: SizedBox(
        height: context.height * 0.07,
        width: context.width,
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
                          controller: controller.studentNameController,
                          hintText: 'أدخل إسم الطالب',
                          labelText: "إسم الطالب",
                          onFieldSubmitted: (_) {
                            false;
                          },
                        ),
                        MyTextFeild(
                          width: context.width * 0.8,
                          controller: controller.studentPriceController,
                          hintText: 'أدخل سعر الطالب (اختياري)',
                          labelText: 'سعر الطالب (اختياري)',
                        ),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.start,
                  actions: [
                    ElevatedButton(
                      child: Text("إضافه", style: context.textTheme.headline1),
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
    );
  }
}
