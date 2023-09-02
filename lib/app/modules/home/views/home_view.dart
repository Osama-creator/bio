import 'package:bio/app/modules/students_league/views/students_league_view.dart';
import 'package:bio/app/modules/videos_page/views/videos_page_view.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: controller,
      builder: (controller) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('الطالب'),
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
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'الإمتحانات'),
                    Tab(text: 'دوري الابطال'),
                    Tab(text: 'الشروحات'),
                  ],
                ),
              ),
              body: TabBarView(children: [
                controller.isLoading
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
                                        future: controller
                                            .isExamInfoAvailable(exam.id),
                                        builder: (context, snapshot) {
                                          final isExamInfoAvailable =
                                              snapshot.data ?? false;

                                          return InkWell(
                                            onTap: () {
                                              controller
                                                  .navigateExamPage(index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Card(
                                                elevation: 10,
                                                color: isExamInfoAvailable
                                                    ? AppColors.primary
                                                    : AppColors.grey,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          height:
                                                              context.height *
                                                                  0.1,
                                                          width: context.width *
                                                              0.3,
                                                          child: Image.asset(
                                                              'assets/images/exam.png'),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          exam.name,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
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
                const StudentsLeagueView(),
                const VideosPageView()
              ])),
        );
      },
    );
  }
}
