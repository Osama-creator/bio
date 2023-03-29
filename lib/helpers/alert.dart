import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Alert {
  /// * show success alert
  static void success(Object msg, {String desc = ''}) {
    Get.snackbar(
      msg.toString(),
      desc,
      backgroundColor: Colors.yellow,
    );
  }

  /// * show error alert
  static void error(Object msg, {String desc = ''}) {
    Get.snackbar(
      msg.toString(),
      desc,
      backgroundColor: Colors.red,
    );
  }

  /// * show error alert
  // static void notValidForm() {
  //   return error(Tr.notValidForm.tr);
  // }
}
