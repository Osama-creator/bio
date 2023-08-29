import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_page_controller.dart';

class VideoPageView extends GetView<VideoPageController> {
  const VideoPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: controller.videoC),
          builder: (context, player) {
            return Container(
              child: player,
            );
          },
        ),
      ),
    );
  }
}
