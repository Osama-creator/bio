import 'package:bio/app/data/models/video_model.dart';
import 'package:bio/app/services/user_local.dart';
import 'package:bio/app/services/videos.dart';
import 'package:get/get.dart';

class VideosPageController extends GetxController {
  bool isLoading = false;
  bool isConfirmed = false;
  var videosList = <VideoModel>[];
  final videosService = VideosService();
  final userDataService = UserDataService();

  @override
  void onInit() {
    getVidoesTitles();
    super.onInit();
  }

  Future<void> getVidoesTitles() async {
    try {
      isLoading = true;
      update();
      final student = await userDataService.getUserFromLocal();
      userDataService.updateUser(student!.email);
      videosList.clear();
      videosList = await videosService.getVideos(student.gradeId);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
