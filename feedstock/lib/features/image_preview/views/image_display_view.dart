import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/core/utils/snack_bar.dart';
import 'package:feed_price_generator/features/home/views/home_view.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/core/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/core/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/features/image_preview/widgets/image_preview.dart';
import 'package:feed_price_generator/features/price_generator/views/price_generator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'dart:io';
import 'dart:typed_data';

class ImageDisplayView extends StatefulWidget {
  final Uint8List imageBytes;
  final ProductList productList;
  static const String routeName = '/image-display-view';

  const ImageDisplayView({
    super.key,
    required this.imageBytes,
    required this.productList,
  });

  @override
  State<ImageDisplayView> createState() => _ImageDisplayViewState();
}

class _ImageDisplayViewState extends State<ImageDisplayView> {
  bool _isSaving = false;

  Future<void> _saveToGallery() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // Request appropriate permission based on Android version
      PermissionStatus status;

      // For Android 13+ (API 33+), use photos permission
      // For older versions, use storage permission
      if (Platform.isAndroid) {
        // Try photos permission first (Android 13+)
        status = await Permission.photos.request();

        // If photos permission is not available (older Android), fall back to storage
        if (status.isPermanentlyDenied || status.isDenied) {
          status = await Permission.storage.request();
        }
      } else {
        // For non-Android platforms, use storage permission
        status = await Permission.storage.request();
      }

      if (!status.isGranted) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'يجب منح إذن التخزين لحفظ الصورة!');
        return;
      }

      // Save image to gallery using gal package
      await Gal.putImageBytes(
        widget.imageBytes,
        album: 'FeedStock',
        name: 'price_list_${widget.productList.date.replaceAll('/', '_')}',
      );

      // ignore: use_build_context_synchronously
      showSnackBar(context, 'تم حفظ الصورة في المعرض بنجاح');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'خطأ في حفظ الصورة: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _shareImage() async {
    try {
      // Create a temporary file for sharing
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/price_list_${widget.productList.date.replaceAll('/', '_')}.png',
      );
      await tempFile.writeAsBytes(widget.imageBytes);

      // Share the image using the latest share_plus API
      final params = ShareParams(
        text: 'قائمة أسعار الأعلاف - ${widget.productList.date}',
        subject: 'أسعار الأعلاف',
        files: [XFile(tempFile.path)],
      );

      final result = await SharePlus.instance.share(params);

      if (result.status == ShareResultStatus.success) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'تم مشاركة الصورة بنجاح');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'خطأ في مشاركة الصورة: $e');
    }
  }

  void _editPrices() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PriceGeneratorView(existingProductList: widget.productList),
      ),
    );
  }

  void _finish() {
    Navigator.pushNamed(context, HomeView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "معاينة قائمة المنتجات"),
      body: Padding(
        padding: const EdgeInsets.all(kPrimaryPaddding),
        child: Column(
          children: [
            Expanded(child: ImagePreview(imageBytes: widget.imageBytes)),
            const SizedBox(height: kSizedBoxMediumHeight),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: _isSaving ? "جاري الحفظ..." : "حفظ في المعرض",
                onPressed: _isSaving ? null : _saveToGallery,
                backgroundColor: kCTAColor,
              ),
            ),
            const SizedBox(height: kSizedBoxMediumHeight),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "مشاركة",
                onPressed: _shareImage,
              ),
            ),
            const SizedBox(height: kSizedBoxMediumHeight),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "تعديل الأسعار",
                onPressed: _editPrices,
              ),
            ),
            const SizedBox(height: kSizedBoxMediumHeight),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(buttonText: "تم", onPressed: _finish),
            ),
          ],
        ),
      ),
    );
  }
}
