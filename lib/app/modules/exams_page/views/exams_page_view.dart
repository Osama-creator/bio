import 'package:bio/app/modules/admin_add_videos/views/admin_add_videos_view.dart';
import 'package:bio/app/modules/exams_page/views/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/exams_page_controller.dart';

class ExamsPageView extends GetView<ExamsPageController> {
  const ExamsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamsPageController>(
        init: controller,
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('لوحه التحكم'),
                  centerTitle: true,
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'الإمتحانات'),
                      Tab(text: 'الفيديوهات'),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  ExamsBody(
                    controller: controller,
                  ),
                  const AdminAddVideosView()
                ])),
          );
        });
  }
}
