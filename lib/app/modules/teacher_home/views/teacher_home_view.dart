import 'package:bio/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الصفحه الرئيسية'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Get.offAllNamed(Routes.SIGN_IN);
                  } catch (e) {
                    if (kDebugMode) {
                      print('Error while signing out: $e');
                    }
                  }
                },
                icon: const Icon(Icons.logout)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الإمتحانات'),
              Tab(text: 'الغياب'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const GradesListView(),
            GroupsListView(),
          ],
        ),
      ),
    );
  }
}
