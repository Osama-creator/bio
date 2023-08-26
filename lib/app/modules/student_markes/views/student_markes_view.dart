import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_markes_controller.dart';

class StudentMarkesView extends GetView<StudentMarkesController> {
  const StudentMarkesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("درجات الطلاب"),
          centerTitle: true,
        ),
        body: GetBuilder<StudentMarkesController>(
          init: controller,
          builder: (_) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.marksList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 10,
                          color: AppColors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(controller
                                          .marksList[index].studentName),
                                      Text(
                                          "${controller.marksList[index].studentMark}/${controller.marksList[index].examMark}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
