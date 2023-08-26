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
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            onChanged: controller.setSearchQuery,
                            decoration: const InputDecoration(
                              hintText: 'Search by name',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredStudents.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                color: controller
                                        .filteredStudents[index].isConfirmed
                                    ? AppColors.primary
                                    : AppColors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                          "الاسم :${controller.filteredStudents[index].name}"),
                                      const Divider(),
                                      Text(
                                          "الحساب :${controller.filteredStudents[index].email}"),
                                      const Divider(),
                                      Text(
                                          "الصف :${controller.filteredStudents[index].grade}"),
                                      const Divider(),
                                      Text(
                                          "كلمه المرور : ${controller.filteredStudents[index].password}"),
                                      if (!controller
                                          .filteredStudents[index].isConfirmed)
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.confirmUser(controller
                                                  .filteredStudents[index]);
                                            },
                                            child: controller.isLoading
                                                ? const CircularProgressIndicator()
                                                : const Text("تأكيد")),
                                      if (controller
                                          .filteredStudents[index].isConfirmed)
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.deconfirmUser(
                                                  controller
                                                      .filteredStudents[index]);
                                            },
                                            child: controller.isLoading
                                                ? const CircularProgressIndicator()
                                                : const Text("ايقاف الحساب"))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ));
        });
  }
}
