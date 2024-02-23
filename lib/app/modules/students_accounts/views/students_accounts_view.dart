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
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          controller.upadataingUsers
                              ? Text(
                                  '${controller.updatedUsersCount}/${controller.studentList.length} من الطلاب تم تحديث نقاطهم',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                                )
                              : const SizedBox()
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     controller.resetWPoints();
                          //   },
                          //   child: Card(
                          //     child: Padding(
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: context.width * 0.25, vertical: context.height * 0.015),
                          //       child: const Column(
                          //         children: [Text("بدء اسبوع جديد")],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          TextField(
                            onChanged: controller.setSearchQuery,
                            decoration: const InputDecoration(
                              hintText: 'ابحث',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredStudents.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                color:
                                    controller.filteredStudents[index].isConfirmed ? AppColors.primary : AppColors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text("الاسم :${controller.filteredStudents[index].name}"),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                controller.deleteUser(controller.filteredStudents[index]);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: AppColors.white,
                                              ))
                                        ],
                                      ),
                                      const Divider(),
                                      Text("الحساب :${controller.filteredStudents[index].email}"),
                                      const Divider(),
                                      Text("الصف :${controller.filteredStudents[index].grade}"),
                                      const Divider(),
                                      Text("كلمه المرور : ${controller.filteredStudents[index].password}"),
                                      const Divider(),
                                      Text("مجموع النقاط : ${controller.filteredStudents[index].marks}"),
                                      const Divider(),
                                      Text("مجموع الاسبوع : ${controller.filteredStudents[index].wPoints}"),
                                      if (!controller.filteredStudents[index].isConfirmed)
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.confirmUser(controller.filteredStudents[index]);
                                            },
                                            child: controller.isLoading
                                                ? const CircularProgressIndicator()
                                                : const Text("تأكيد")),
                                      if (controller.filteredStudents[index].isConfirmed)
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.deconfirmUser(controller.filteredStudents[index]);
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
