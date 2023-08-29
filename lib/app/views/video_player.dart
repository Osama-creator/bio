import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );

    return Scaffold(
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: youtubePlayerController),
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
