import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageShareService {
  static Future<bool> shareImage({
    required Uint8List imageBytes,
    required String date,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/price_list_${date.replaceAll('/', '_')}.png',
      );
      await tempFile.writeAsBytes(imageBytes);

      final params = ShareParams(
        text: 'قائمة أسعار الأعلاف - $date',
        subject: 'أسعار الأعلاف',
        files: [XFile(tempFile.path)],
      );

      final result = await SharePlus.instance.share(params);
      return result.status == ShareResultStatus.success;
    } catch (e) {
      return false;
    }
  }
}
