import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
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
                : ListView.builder(
                    itemCount: controller.examList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () => controller
                            .deleteGroup(controller.examList[index].id),
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
                              child: Text(controller.examList[index].name),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                controller.navigateToCreateExam();
              },
              backgroundColor: AppColors.primary,
              label: Text(
                "إضافة إمتحان جديد",
                style: context.textTheme.bodyText1!.copyWith(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
            ),
          );
        });
  }
}
