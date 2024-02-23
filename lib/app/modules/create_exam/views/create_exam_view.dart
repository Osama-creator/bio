import 'package:bio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/utils/colors.dart';
import '../../../views/text_field.dart';
import '../controllers/create_exam_controller.dart';

class CreateExamView extends GetView<CreateExamController> {
  const CreateExamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExamController>(
      init: controller,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.mixinService.clearQuestionList();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('إنشاء إمتحان جديد'),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  controller.createExam();
                },
                icon: const Icon(
                  Icons.add_box_rounded,
                ),
              ),
            ),
            body: controller.isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          '${controller.uploadedQuestionCount}/${controller.mixinService.questionFromList.length} من الاسئله تم رفعه',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        MyTextFeild(
                          width: context.width * 0.8,
                          controller: controller.examNameController,
                          hintText: 'أدخل إسم الإمتحان',
                          labelText: "إسم الإمتحان",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
                          child: const Divider(),
                        ),
                        Center(
                          child: Text(
                            "الأسئله",
                            style: context.textTheme.titleLarge!
                                .copyWith(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
                          child: const Divider(
                            thickness: 1,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.mixinService.questionFromList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: AppColors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'بيانات السؤال ${index + 1}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 23, color: AppColors.primary),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              controller.mixinService
                                                  .removQuesion(controller.mixinService.questionFromList[index]);
                                              controller.update();
                                            },
                                            icon: const Icon(Icons.close)),
                                      ],
                                    ),
                                  ),
                                  MyTextFeild(
                                    controller: controller.mixinService.questionFromList[index].questionC,
                                    hintText: "السؤال",
                                    labelText: "السؤال",
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        color: const Color(0x1AD1EC43),
                                        width: context.width,
                                        height: context.height * 0.15,
                                        child: controller.mixinService.questionFromList[index].image == null &&
                                                controller.mixinService.questionFromList[index].imageString.isEmpty
                                            ? Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        controller.mixinService.questionFromList[index].pickFile,
                                                    icon: const Icon(
                                                      Icons.camera_alt_rounded,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => controller.getLastQuestionImage(index),
                                                    child: const Text(
                                                      "عرض الصوره السابقه",
                                                      style: TextStyle(color: AppColors.black),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : controller.mixinService.questionFromList[index].imageString.isNotEmpty
                                                ? SizedBox(
                                                    height: context.height * 0.2,
                                                    width: context.width * 0.8,
                                                    child: Image.network(
                                                      controller.mixinService.questionFromList[index].imageString,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )
                                                : Image.file(
                                                    controller.mixinService.questionFromList[index].image!,
                                                  ),
                                      ),
                                      if (controller.mixinService.questionFromList[index].image != null)
                                        Positioned(
                                          left: 0,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete_forever,
                                            ),
                                            onPressed: () {
                                              controller.mixinService.questionFromList[index].image = null;
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                  MyTextFeild(
                                    controller: controller.mixinService.questionFromList[index].rightAnswerC,
                                    hintText: "الإجابه الصحيحه",
                                    labelText: "الإجابه الصحيحه",
                                  ),
                                  MyTextFeild(
                                    controller: controller.mixinService.questionFromList[index].wrongAnswer1C,
                                    hintText: "الإجابه الخاطئه 1",
                                    labelText: "الإجابه الخاطئه 1",
                                  ),
                                  MyTextFeild(
                                    controller: controller.mixinService.questionFromList[index].wrongAnswer2C,
                                    hintText: "الإجابه الخاطئه 2",
                                    labelText: "الإجابه الخاطئه 2",
                                  ),
                                  MyTextFeild(
                                    controller: controller.mixinService.questionFromList[index].wrongAnswer3C,
                                    hintText: "الإجابه الخاطئه 3",
                                    labelText: "الإجابه الخاطئه 3",
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1, vertical: 10),
                          child: SizedBox(
                            height: context.height * 0.06,
                            child: ElevatedButton(
                              onPressed: () => controller.addQuestion(),
                              child: Text(
                                ' إضافه سؤال',
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1, vertical: 10),
                          child: SizedBox(
                            height: context.height * 0.06,
                            child: OutlinedButton(
                              onPressed: () => Get.toNamed(
                                Routes.EXAMS_PAGE,
                                arguments: [controller.args, true],
                              ),
                              child: Text(
                                ' أستيراد سؤال',
                                style: context.textTheme.titleLarge!.copyWith(fontSize: 18, color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
