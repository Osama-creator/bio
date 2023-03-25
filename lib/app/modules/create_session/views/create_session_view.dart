import 'package:bio/app/views/list_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/divider.dart';
import '../controllers/create_session_controller.dart';

class CreateSessionView extends GetView<CreateSessionController> {
  const CreateSessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateSessionController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.currentDate),
              centerTitle: true,
            ),
            body: Column(
              children: [
                MyListTile(
                  title: "الحصه 2",
                  subTile: controller.args.sessions.toString(),
                ),
                const MyDivider(),
                Text(
                  "الطلاب",
                  style: context.textTheme.bodyText2!.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                const MyDivider(),
                const MyDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.args.students?.length ?? 0,
                    itemBuilder: (context, index) {
                      final student = controller.args.students![index];
                      return CheckboxListTile(
                        value: controller.isChecked(student),
                        onChanged: (value) =>
                            controller.setChecked(student, value ?? false),
                        title: Text(
                          student.name,
                          style: context.textTheme.bodyText1!
                              .copyWith(color: AppColors.black),
                        ),
                        activeColor: AppColors.black,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
