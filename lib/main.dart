import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'config/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mr Bio",
      textDirection: TextDirection.rtl,
      initialRoute: AppPages.INITIAL,
      theme: getThemDataLight(),
      getPages: AppPages.routes,
    ),
  );
}
