import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../views/divider.dart';
import '../../../views/list_tile.dart';
import '../controllers/show_gruop_details_controller.dart';

class ShowGruopDetailsView extends GetView<ShowGruopDetailsController> {
  const ShowGruopDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowGruopDetailsController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.args.name),
              centerTitle: true,
            ),
            body: Column(
              children: [
                MyListTile(
                  title: "سعر الشهر",
                  subTile: controller.args.price.toString(),
                ),
                const MyDivider(),
                MyListTile(
                  title: "عدد الحصص",
                  subTile: controller.args.sessions.toString(),
                ),
                const MyDivider(),
                Text(
                  "الطلاب",
                  style: context.textTheme.bodyText2!.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
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
                              .copyWith(color: AppColors.black),
                        ),
                        trailing: Text(
                          "غياب: ${student.absence.toString()}",
                          style: context.textTheme.bodyText2!
                              .copyWith(color: AppColors.grey),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Text(student.name);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.navigate();
                      },
                      child: Text(
                        'إبدأ حصه',
                        style: context.textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
