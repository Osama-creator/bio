import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPageController extends GetxController {
  final videoUrl = Get.arguments as String;
  late YoutubePlayerController videoC;
  @override
  void onInit() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    videoC = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          forceHD: true,
          enableCaption: true,
        ));
    super.onInit();
  }

  @override
  void onClose() {
    videoC.dispose();
    super.onClose();
  }
}
