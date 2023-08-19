import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/students_accounts_controller.dart';

class StudentsAccountsView extends GetView<StudentsAccountsController> {
  const StudentsAccountsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentsAccountsController>(
        init: controller,
        builder: (_) {
          return Scaffold(
              body: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.studentList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: controller.studentList[index].isConfirmed
                              ? AppColors.primary
                              : AppColors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    "الاسم :${controller.studentList[index].name}"),
                                const Divider(),
                                Text(
                                    "الحساب :${controller.studentList[index].email}"),
                                const Divider(),
                                Text(
                                    "الصف :${controller.studentList[index].grade}"),
                                const Divider(),
                                Text(
                                    "كلمه المرور : ${controller.studentList[index].password}"),
                                if (!controller.studentList[index].isConfirmed)
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.confirmUser(
                                            controller.studentList[index]);
                                      },
                                      child: controller.isLoading
                                          ? const CircularProgressIndicator()
                                          : const Text("تأكيد")),
                                if (controller.studentList[index].isConfirmed)
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.deconfirmUser(
                                            controller.studentList[index]);
                                      },
                                      child: controller.isLoading
                                          ? const CircularProgressIndicator()
                                          : const Text("ايقاف الحساب"))
                              ],
                            ),
                          ),
                        );
                      },
                    ));
        });
  }
}
