import 'dart:developer';

import 'package:bio/app/data/models/video_model.dart';
import 'package:bio/app/views/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/grade_item_model.dart';

class AdminAddVideosController extends GetxController {
  final args = Get.arguments as GradeItem;
  TextEditingController vidTitleController = TextEditingController();
  TextEditingController vidUrlController = TextEditingController();
  bool isLoading = false;
  var videosList = <VideoModel>[];
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> createVid() async {
    try {
      isLoading = true;
      update();
      VideoModel video = VideoModel(
          id: const Uuid().v1(),
          title: vidTitleController.text,
          url: vidUrlController.text);
      CollectionReference videoCollection = FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('videos');

      await videoCollection.add(video.toMap());

      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void editVideo(int index) {
    VideoModel video = videosList[index];
    vidTitleController.text = video.title;
    vidUrlController.text = video.url;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFeild(
                  width: context.width,
                  controller: vidTitleController,
                  hintText: 'Edit video name',
                  labelText: "video Name",
                  onFieldSubmitted: (_) {
                    false;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFeild(
                  width: context.width,
                  controller: vidUrlController,
                  hintText: 'Edit video url',
                  labelText: "video url",
                  onFieldSubmitted: (_) {
                    false;
                  },
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: Text("Update", style: context.textTheme.displayLarge),
              onPressed: () {
                video.title = vidTitleController.text.trim();
                video.url = vidUrlController.text.trim();
                updateVideo(video);
                vidTitleController.clear();
                vidUrlController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteVid(int index) async {
    VideoModel vid = videosList[index];

    try {
      DocumentReference gradeRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('videos')
          .doc(vid.id);
      await gradeRef.delete();
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  Future<void> getData() async {
    isLoading = true;
    try {
      QuerySnapshot videos = await FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('videos')
          .get();
      videosList.clear();
      for (var category in videos.docs) {
        videosList.add(VideoModel(
          title: category['title'],
          url: category['url'],
          id: category.id,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateVideo(VideoModel video) async {
    isLoading = true;
    update();
    try {
      DocumentReference gradeRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(args.id)
          .collection('videos')
          .doc(video.id);
      await gradeRef.update({'title': video.title, 'url': video.url});
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
