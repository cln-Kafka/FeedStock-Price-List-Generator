import 'dart:typed_data';
import 'dart:io';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageGalleryService {
  static Future<bool> saveToGallery({
    required Uint8List imageBytes,
    required String date,
  }) async {
    try {
      // Request permission
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) return false;

      // Save image
      await Gal.putImageBytes(
        imageBytes,
        album: 'FeedStock',
        name: 'price_list_${date.replaceAll('/', '_')}',
      );
      
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.photos.request();
      if (status.isPermanentlyDenied || status.isDenied) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }
}