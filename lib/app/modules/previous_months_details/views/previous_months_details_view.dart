import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/divider.dart';
import '../controllers/previous_months_details_controller.dart';

class PreviousMonthsDetailsView
    extends GetView<PreviousMonthsDetailsController> {
  const PreviousMonthsDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviousMonthsDetailsController>(
        init: controller,
        builder: (controller) {
          bool checked = false;
          return Scaffold(
            appBar: AppBar(
              title: const Text("تقرير شهر"),
              centerTitle: true,
            ),
            body: Column(children: [
              ListTile(
                title: Text(
                  "الإجمالي قبل الخصم",
                  style: context.textTheme.headline2,
                ),
                trailing: Text(
                  controller.getStudentPrice().toInt().toString(),
                  style: context.textTheme.headline2,
                ),
              ),
              const MyDivider(),
              ListTile(
                title: Text(
                  "الخصم",
                  style: context.textTheme.headline2,
                ),
                trailing: Text(
                  controller.getStudentDis().toInt().toString(),
                  style: context.textTheme.headline2,
                ),
              ),
              const MyDivider(),
              ListTile(
                title: Text(
                  "الإجمالي بعد الخصم",
                  style: context.textTheme.headline2,
                ),
                trailing: Text(
                  (controller.getStudentPrice() - controller.getStudentDis())
                      .toInt()
                      .toString(),
                  style: context.textTheme.headline2,
                ),
              ),
              const MyDivider(),
              const MyDivider(),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.args.students?.length ?? 0,
                  itemBuilder: (context, index) {
                    final student = controller.args.students![index];
                    return ListTile(
                      title: Text(
                        student.name,
                        style: context.textTheme.bodyText1!
                            .copyWith(color: AppColors.black, fontSize: 18),
                      ),
                      trailing: Text(
                        "صافي : ${(student.price!)}    | غياب ${student.absence}  | خصم ${controller.totalAfterdiscount(index)}",
                        style: context.textTheme.bodyText2!
                            .copyWith(color: AppColors.primary, fontSize: 14),
                      ),
                    );
                  },
                ),
              )
            ]),
          );
        });
  }
}
