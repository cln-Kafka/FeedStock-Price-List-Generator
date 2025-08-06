import 'package:feed_price_generator/features/image_preview/services/image_gallery_service.dart';
import 'package:feed_price_generator/features/image_preview/services/image_share_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/core/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/core/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/features/image_preview/widgets/image_preview.dart';
import 'package:feed_price_generator/features/price_generator/views/price_generator_view.dart';
import 'package:feed_price_generator/features/home/views/home_view.dart';
import 'package:feed_price_generator/core/utils/snack_bar.dart';

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
    setState(() => _isSaving = true);

    final success = await ImageGalleryService.saveToGallery(
      imageBytes: widget.imageBytes,
      date: widget.productList.date,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      showSnackBar(
        context,
        success 
          ? 'تم حفظ الصورة في المعرض بنجاح'
          : 'خطأ في حفظ الصورة أو تم رفض الإذن',
      );
    }
  }

  Future<void> _shareImage() async {
    final success = await ImageShareService.shareImage(
      imageBytes: widget.imageBytes,
      date: widget.productList.date,
    );

    if (mounted) {
      showSnackBar(
        context,
        success 
          ? 'تم مشاركة الصورة بنجاح'
          : 'خطأ في مشاركة الصورة',
      );
    }
  }

  void _editPrices() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceGeneratorView(
          existingProductList: widget.productList,
        ),
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
            Expanded(
              child: ImagePreview(imageBytes: widget.imageBytes),
            ),
            const SizedBox(height: kSizedBoxMediumHeight),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
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
          child: CustomElevatedButton(
            buttonText: "تم",
            onPressed: _finish,
          ),
        ),
      ],
    );
  }
}