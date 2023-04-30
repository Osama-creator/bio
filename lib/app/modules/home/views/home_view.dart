import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../config/utils/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('الإمتحانات'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
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
                              child: Text(controller.examList[index].name),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        });
  }
}
