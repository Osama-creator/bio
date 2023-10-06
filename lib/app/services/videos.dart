import 'package:bio/app/data/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideosService {
  Future<void> createVideo(String gradeId, VideoModel video) async {
    try {
      CollectionReference videoCollection = FirebaseFirestore.instance
          .collection('grades')
          .doc(gradeId)
          .collection('videos');

      await videoCollection.add(video.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateVideo(String gradeId, VideoModel video) async {
    try {
      DocumentReference gradeRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(gradeId)
          .collection('videos')
          .doc(video.id);

      await gradeRef.update({'title': video.title, 'url': video.url});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteVideo(String gradeId, String videoId) async {
    try {
      DocumentReference gradeRef = FirebaseFirestore.instance
          .collection('grades')
          .doc(gradeId)
          .collection('videos')
          .doc(videoId);

      await gradeRef.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VideoModel>> getVideos(String gradeId) async {
    try {
      QuerySnapshot videos = await FirebaseFirestore.instance
          .collection('grades')
          .doc(gradeId)
          .collection('videos')
          .get();
      List<VideoModel> videosList = [];
      for (var category in videos.docs) {
        videosList.add(VideoModel(
          title: category['title'],
          url: category['url'],
          id: category.id,
        ));
      }
      return videosList;
    } catch (e) {
      rethrow;
    }
  }
}
