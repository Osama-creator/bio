import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

mixin ImageUploadMixin {
  Future<void> uploadImage(
      {void Function()? afterUpload,
      required File? image,
      required String imageString,
      required bool imageUploaded,
      required GetxController controller}) async {
    try {
      if (image != null) {
        final reference =
            FirebaseStorage.instance.ref().child(const Uuid().v1());
        final uploadTask = reference.putFile(image);
        await uploadTask.whenComplete(() async {
          imageString = await reference.getDownloadURL();
          imageUploaded = true;
          log(imageString);
          afterUpload?.call();
          controller.update();
        });
      } else {
        imageUploaded = false;
      }
    } catch (e, st) {
      Get.snackbar('Error', e.toString());
      log(st.toString());
    }
  }
}
