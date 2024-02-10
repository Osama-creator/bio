// ignore: file_names
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:bio/helpers/pick.dart';

class ImageHelper {
  static Future<File?> pickFile() async {
    return await Pick.imageFromGallery();
  }

  static Future<String> uploadPhoto(File image) async {
    final reference = FirebaseStorage.instance.ref().child(const Uuid().v1());
    final uploadTask = reference.putFile(image);
    await uploadTask.whenComplete(() async {
      final imageString = await reference.getDownloadURL();
      log(imageString);
      return imageString;
    });
    return "";
  }
}
