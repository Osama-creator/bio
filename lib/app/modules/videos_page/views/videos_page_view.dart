import 'package:bio/app/routes/app_pages.dart';
import 'package:bio/config/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/videos_page_controller.dart';

class VideosPageView extends GetView<VideosPageController> {
  const VideosPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideosPageController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.videoUrls.isEmpty
                  ? const Center(
                      child: Text(
                        "لايوجد فيديوهات حاليا",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.videoUrls.length,
                      itemBuilder: (context, index) {
                        final videoUrl = controller.videoUrls[index];
                        return InkWell(
                          onTap: () => Get.toNamed(Routes.VIDEO_PAGE,
                              arguments: videoUrl.url),
                          child: Card(
                            color: AppColors.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                videoUrl.title,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
