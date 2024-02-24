import 'package:bio/app/modules/admin_setting/views/admin_setting_view.dart';
import 'package:bio/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../grades_list/views/grades_list_view.dart';
import '../../groups_list/views/groups_list_view.dart';

class TeacherHomeView extends StatefulWidget {
  const TeacherHomeView({super.key});

  @override
  _TeacherHomeViewState createState() => _TeacherHomeViewState();
}

class _TeacherHomeViewState extends State<TeacherHomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الصفحه الرئيسية'),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'signOut':
                    await FirebaseAuth.instance.signOut();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Get.offAllNamed(Routes.SIGN_IN);
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
              Tab(text: 'الحضور'),
              Tab(text: 'الإعدادات'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GradesListView(),
            GroupsListView(),
            AdminSettingView(),
          ],
        ),
      ),
    );
  }
}
