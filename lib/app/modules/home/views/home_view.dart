import 'package:bio/app/routes/app_pages.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Future<bool> isExamInfoAvailable(String examId) async {
    final prefs = await SharedPreferences.getInstance();
    final examInfo = prefs.getString('exam_$examId');
    return examInfo != null;
  }

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
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'signOut':
                      controller.signOut();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text('تسجيل الخروج'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : !controller.isConfirmed
                  ? const Center(
                      child: Text(
                        " لم يتم تأكيد حسابك بعد 🤨",
                        style: TextStyle(color: AppColors.black),
                      ),
                    )
                  : controller.examList.isEmpty
                      ? const Center(
                          child: Text(
                            "لا يوجد امتحانات حاليا ابسط يعم 😉",
                            style: TextStyle(color: AppColors.black),
                          ),
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(Routes.STUDENTS_LEAGUE),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.width * 0.3,
                                      vertical: 10),
                                  child: const Text(
                                    'Champions League',
                                    style: TextStyle(
                                        fontSize: 18, color: AppColors.primary),
                                  ),
                                ),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: controller.examList.length,
                              itemBuilder: (context, index) {
                                final exam = controller.examList[index];

                                return FutureBuilder<bool>(
                                  future: isExamInfoAvailable(exam.id),
                                  builder: (context, snapshot) {
                                    final isExamInfoAvailable =
                                        snapshot.data ?? false;

                                    return InkWell(
                                      onTap: () {
                                        controller.navigateExamPage(index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Card(
                                          elevation: 10,
                                          color: isExamInfoAvailable
                                              ? AppColors.primary
                                              : AppColors.grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height:
                                                        context.height * 0.1,
                                                    width: context.width * 0.3,
                                                    child: Image.asset(
                                                        'assets/images/exam.png'),
                                                  ),
                                                ),
                                                Text(
                                                  exam.name,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
        );
      },
    );
  }
}
