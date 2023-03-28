import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/text_field.dart';
import '../controllers/grades_list_controller.dart';

class GradesListView extends GetView<GradesListController> {
  const GradesListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GradesListController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('الصفوف'),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.gradeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            elevation: 10,
                            color: AppColors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(controller.gradeList[index].name),
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
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyTextFeild(
                              width: context.width,
                              controller: controller.gradeNameCont,
                              hintText: 'أدخل إسم الصف',
                              labelText: "إسم الصف",
                              onFieldSubmitted: (_) {
                                false;
                              },
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          child:
                              Text("إضافه", style: context.textTheme.headline1),
                          onPressed: () {
                            controller.createGrade();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: AppColors.primary,
              label: Text(
                "إضافة صف جديد",
                style: context.textTheme.bodyText1!.copyWith(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
            ),
          );
        });
  }
}
