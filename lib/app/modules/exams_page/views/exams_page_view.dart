import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/exams_page_controller.dart';

class ExamsPageView extends GetView<ExamsPageController> {
  const ExamsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamsPageController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('الإمتحانات'),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder(
                    future: controller.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      {
                        return ListView.builder(
                          itemCount: controller.examList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.navigateExamPage(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Card(
                                  elevation: 10,
                                  color: AppColors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Text(controller.examList[index].name),
                                        const Spacer(),
                                        Switch(
                                          value: controller
                                              .examList[index].isActive,
                                          activeColor: AppColors.primary,
                                          inactiveThumbColor: AppColors.white,
                                          inactiveTrackColor: Colors.white,
                                          onChanged: (newValue) {
                                            controller.updateExamActivation(
                                                controller.examList[index].id,
                                                newValue);
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.deleteGroup(
                                                controller.examList[index].id);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes
                                                      .STUDENT_MARKES_FOR_TEACHER,
                                                  arguments: [
                                                    controller.examList[index],
                                                    controller.args
                                                  ]);
                                            },
                                            icon: const Icon(
                                              Icons.group,
                                              color: AppColors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                controller.navigateToCreateExam();
              },
              backgroundColor: AppColors.primary,
              label: Text(
                "إضافة إمتحان جديد",
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
            ),
          );
        });
  }
}
