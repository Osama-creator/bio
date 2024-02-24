import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'config/theme/light_theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kReleaseMode == true) {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://b2f48562e650a6d493f10f2b05d74e93@o4505935676964864.ingest.sentry.io/4505935678734336';
        options.tracesSampleRate = 0.01;
      },
      appRunner: () => runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Mr Bio",
          textDirection: TextDirection.rtl,
          initialRoute: AppPages.INITIAL,
          theme: getThemDataLight(),
          getPages: AppPages.routes,
        ),
      ),
    );
  } else {
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
}
