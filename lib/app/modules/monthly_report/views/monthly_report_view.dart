import 'package:bio/app/views/divider.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/monthly_report_controller.dart';

class MonthlyReportView extends GetView<MonthlyReportController> {
  const MonthlyReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyReportController>(
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
                  controller.getStudentPrice().toString(),
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
                  controller.getStudentDis().toString(),
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
                        "صافي : ${(student.price! / int.tryParse(controller.args.sessions!)! * (controller.args.currentSession! - student.absence)).toString()}    | غياب ${student.absence}  | خصم ${controller.totalAfterdiscount(index)}",
                        style: context.textTheme.bodyText2!
                            .copyWith(color: AppColors.primary, fontSize: 14),
                      ),
                      leading: controller.args.currentSession.toString() ==
                              controller.args.sessions
                          ? Checkbox(onChanged: (value) {}, value: checked)
                          : null,
                    );
                  },
                ),
              )
            ]),
          );
        });
  }
}
