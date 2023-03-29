// import 'dart:io';
// import 'package:core/ui/views/image_picked_dialog.dart';
// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

//
// import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;
//
// import 'package:core/core.dart';
//
// /// facade for picking objects
abstract class Pick {
//   /// * pick single image
//   static Future<File?> image(BuildContext context) async {
//     return (await multiImages(context, maxCount: 1)?.firstOrNull());
//   }
//
//   /// * pick multiple images
//   static Future<List<File>?> multiImages(
//       BuildContext context, {
//         int maxCount = 9,
//       }) async {
//     final result = await AssetPicker.pickAssets(
//       context,
//       maxAssets: maxCount,
//       requestType: RequestType.image,
//       textDelegate: Lang.current.languageCode == 'ar' ? ArabicTextDelegate() : EnglishTextDelegate(),
//     );
//     if (result != null && result.isNotEmpty) {
//       final _files = <File>[];
//       for (final asset in result) {
//         final _assetFile = await asset.file;
//         if (_assetFile != null) {
//           _files.add(_assetFile);
//         }
//       }
//       return _files;
//     }
//   }
//
//   /// * pick location from place picker
//   static Future<LocationResult?> locationFromMap(
//       BuildContext context, {
//         LatLng initialCenter = const LatLng(45.521563, -122.677433),
//       }) async {
//     return showLocationPicker(
//       context,
//       Config.mapsKey,
//       initialCenter: initialCenter,
//       automaticallyAnimateToCurrentLocation: true,
//       //mapStylePath: 'assets/mapStyle.json',
//       myLocationButtonEnabled: true,
//       requiredGPS: true,
//       layersButtonEnabled: true,
//       countries: ['sa', 'NG'],
//       resultCardAlignment: Alignment.bottomCenter,
//       desiredAccuracy: LocationAccuracy.best,
//     );
//   }
//
//   /// * open the camera and return the taken pic
//   static Future<File?> imageFromCamera(BuildContext context) async {
//     final xFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 20);
//     if (xFile != null) {
//       return File(xFile.path);
//     }
//   }
//
  static Future<File?> imageFromGallery() async {
    final xFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  }

  static Future<List<XFile>?> imagesFromGallery() async {
    return ImagePicker().pickMultiImage(imageQuality: 20);
  }

//
//   /// * show dialog then open the camera or the gallery based on
//   /// * the user storage
//   static Future<File?> singleCameraOrAssets(BuildContext context) async {
//     final source = await ImageSourceDialog.show(context);
//     switch (source) {
//       case ImageSource.camera:
//         return imageFromCamera(context);
//       case ImageSource.gallery:
//         return imageFromGallery(context);
//       default:
//         return null;
//     }
//   }
  /// return user location
  /// ask for the permission
  Future<LocationData> getLocation() async {
    final location = Location();
    bool serviceEnabled = false;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw 'enable location service';
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw 'missing permission';
      }
    }

    return location.getLocation();
  }
}
