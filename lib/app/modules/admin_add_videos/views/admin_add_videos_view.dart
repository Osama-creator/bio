import 'package:bio/app/views/text_field.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_videos_controller.dart';

class AdminAddVideosView extends GetView<AdminAddVideosController> {
  const AdminAddVideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminAddVideosController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.videosList.length,
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
                                Row(
                                  children: [
                                    Text(controller.videosList[index].title),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () =>
                                            controller.editVideo(index),
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: const Text(
                                                    "Do you want to delete this video?"),
                                                actions: [
                                                  ElevatedButton(
                                                    child: const Text("Delete"),
                                                    onPressed: () {
                                                      controller
                                                          .deleteVid(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text("Cancel"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                                Text(controller.videosList[index].url),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
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
                              controller: controller.vidTitleController,
                              hintText: 'أدخل إسم الفيديو',
                              labelText: "إسم الفيديو",
                              onFieldSubmitted: (_) {
                                false;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextFeild(
                              width: context.width,
                              controller: controller.vidUrlController,
                              hintText: 'أدخل رابط الفيديو',
                              labelText: "رابط الفيديو",
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
                          child: Text("إضافه",
                              style: context.textTheme.displayLarge),
                          onPressed: () {
                            controller.createVid();
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
                "إضافة فيديو جديد",
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
            ),
          );
        });
  }
}
