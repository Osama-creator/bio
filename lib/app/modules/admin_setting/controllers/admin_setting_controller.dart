import 'dart:developer';

import 'package:bio/app/services/user_accounts.dart';
import 'package:get/get.dart';

class AdminSettingController extends GetxController {
  bool isLoading = false;
  final userAccountsService = UserAccounts();

  Future<void> resetWPoints() async {
    try {
      isLoading = true;
      update();
      userAccountsService.resetPointsToZero('w_points');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> resetAllPointsToZero() async {
    try {
      isLoading = true;
      update();
      userAccountsService.resetPointsToZero('marks');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> resetAllPoints() async {
    try {
      isLoading = true;
      update();
      userAccountsService.resetUsersMark();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
