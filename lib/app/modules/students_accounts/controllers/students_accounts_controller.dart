import 'dart:developer';
import 'package:bio/app/data/models/student_model.dart';
import 'package:bio/app/services/user_accounts.dart';
import 'package:get/get.dart';

class StudentsAccountsController extends GetxController {
  final args = Get.arguments as List;

  bool isLoading = false;
  List<Student> studentList = [];
  int updatedUsersCount = 0;
  String gradeId = '';
  final userAccountsService = UserAccounts();
  bool upadataingUsers = false;

  Future<void> getData() async {
    isLoading = true;
    update();
    try {
      gradeId = args[0].id;
      studentList = await userAccountsService.getAccounts(gradeId);
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  String searchQuery = '';

  void setSearchQuery(String query) {
    searchQuery = query;
    update();
  }

  List<Student> get filteredStudents {
    return studentList.where((student) {
      final lowerQuery = searchQuery.toLowerCase();
      final studentName = student.name.toLowerCase();
      return studentName.contains(lowerQuery);
    }).toList();
  }

  Future<void> confirmUser(Student student) async {
    try {
      isLoading = true;
      update();
      userAccountsService.manageUserAccount(student, true);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteUser(Student student) async {
    try {
      isLoading = true;
      update();
      studentList = await userAccountsService.deleteStudent(student);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> resetWPoints() async {
    try {
      isLoading = true;
      upadataingUsers = true;
      update();
      userAccountsService.resetPointsToZero('w_points');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      upadataingUsers = false;
      update();
    }
  }

  Future<void> deconfirmUser(Student student) async {
    try {
      isLoading = true;
      update();
      userAccountsService.manageUserAccount(student, false);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
