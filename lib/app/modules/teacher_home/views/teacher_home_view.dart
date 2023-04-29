import 'package:flutter/material.dart';

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
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الإمتحانات'),
              Tab(text: 'الغياب'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GradesListView(),
            GroupsListView(),
          ],
        ),
      ),
    );
  }
}
