import 'dart:developer';

import 'package:bio/app/data/models/video_model.dart';
import 'package:bio/app/services/videos.dart';
import 'package:bio/app/views/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddVideosController extends GetxController {
  final args = Get.arguments as List;
  TextEditingController vidTitleController = TextEditingController();
  TextEditingController vidUrlController = TextEditingController();
  bool isLoading = false;
  var videosList = <VideoModel>[];
  final videosService = VideosService();
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> createVid() async {
    try {
      isLoading = true;
      update();
      String vidID = FirebaseFirestore.instance.collection('grades').doc(args.first.id).collection('videos').doc().id;
      VideoModel video = VideoModel(
        id: vidID,
        title: vidTitleController.text,
        url: vidUrlController.text,
      );
      await videosService.createVideo(args.first.id, video);
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
      await videosService.deleteVideo(args.first.id, vid.id);
      getData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
    }
  }

  Future<void> getData() async {
    isLoading = true;
    try {
      videosList.clear();
      videosList = await videosService.getVideos(args.first.id);
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
      videosService.updateVideo(args.first.id, video);
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
