import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/admin_setting_controller.dart';

class AdminSettingView extends GetView<AdminSettingController> {
  const AdminSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AdminSettingController>(
          init: controller,
          builder: (_) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () => controller.resetWPoints(),
                          child: const Card(
                            color: AppColors.primary,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(child: Text("بدء إسبوع جديد"))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => controller.resetAllPointsToZero(),
                          child: const Card(
                            color: AppColors.primary,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(child: Text("بدء ترم جديد"))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => controller.resetAllPoints(),
                          child: const Card(
                            color: AppColors.primary,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(child: Text("جمع النقاط"))),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
