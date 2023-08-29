import 'dart:convert';

import 'package:bio/app/data/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideosPageController extends GetxController {
  bool isLoading = false;
  bool isConfirmed = false;
  List<VideoModel> videoUrls = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');

      if (userData == null) {
        throw Exception("User data not found in SharedPreferences");
      }

      final userDataMap = jsonDecode(userData);
      final userEmail = userDataMap['email'];

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.size == 0) {
        throw Exception("User data not found in Firestore");
      }

      final userDoc = userSnapshot.docs.first;
      await prefs.setString('userData', jsonEncode(userDoc.data()));

      isConfirmed = userDoc['confirmed'];

      final videosSnapshot = await FirebaseFirestore.instance
          .collection('grades')
          .doc(userDoc['grade_id'])
          .collection('videos')
          .get();

      videoUrls.clear();
      for (var videoDoc in videosSnapshot.docs) {
        final videoModel = VideoModel.fromJson(videoDoc.data());
        videoUrls.add(videoModel);
      }
      print(videoUrls.length);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
