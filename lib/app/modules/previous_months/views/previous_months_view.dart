import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/utils/colors.dart';
import '../controllers/previous_months_controller.dart';

class PreviousMonthsView extends GetView<PreviousMonthsController> {
  const PreviousMonthsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviousMonthsController>(
        init: PreviousMonthsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'الشهور الفائته',
                style: context.textTheme.headline6,
              ),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.groupList.isEmpty
                    ? Center(
                        child: Text(
                          " لا يوجد شهور ماضيه بعد ...",
                          style: context.textTheme.headline6!
                              .copyWith(color: AppColors.primary),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.groupList.length,
                        itemBuilder: (context, index) {
                          String formattedDate = DateFormat('yyyy / MM').format(
                              controller.groupList[index].date.toDate());
                          return InkWell(
                            onTap: () {
                              controller.navigate(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Card(
                                elevation: 10,
                                color: AppColors.grey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Text(formattedDate),
                                        Text(
                                            "${controller.groupList[index].students!.length} طالب")
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        controller.deleteGroupMonth(controller
                                            .groupList[index].groupId);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
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
