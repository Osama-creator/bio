import 'dart:convert';

import 'package:bio/app/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataService {
  static const String userDataKey = 'userData';

  Future<void> saveUserDataToLocal(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(userDataKey, jsonEncode(userData));
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserDataFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString(userDataKey);
      if (userDataString != null) {
        return jsonDecode(userDataString);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearUserDataLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(userDataKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<Student?> getUserFromLocal() async {
    try {
      final userData = await getUserDataFromLocal();
      if (userData != null) {
        return Student.fromJson(userData);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String userEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Update user data in Firestore
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
      if (userSnapshot.size == 0) {
        throw Exception("User data not found in Firestore");
      }
      // Update user data in SharedPreferences
      final userDoc = userSnapshot.docs.first;
      await prefs.setString('userData', jsonEncode(userDoc.data()));
    } catch (e) {
      rethrow;
    }
  }
}
