import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageDisplayScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const ImageDisplayScreen({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "معاينة قائمة المنتجات"),
      body: Padding(
        padding: const EdgeInsets.all(kPrimaryPaddding),
        child: Column(
          children: [
            Expanded(child: ImagePreview(imageBytes: imageBytes)),
            const SizedBox(height: kSizedBoxBaseHeight - 4),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "حفظ في المعرض",
                onPressed: () {},
                backgroundColor: kCTAColor,
              ),
            ),
            const SizedBox(height: kSizedBoxBaseHeight - 4),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "مشاركة",
                onPressed: () {},
              ),
            ),
            const SizedBox(height: kSizedBoxBaseHeight - 4),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "تعديل الأسعار",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
AlertDialog(
  title: const Text('كيفية الحفظ'),
  content: const Text(
    'لحفظ الصورة، قم بأخذ لقطة شاشة باستخدام أزرار الجهاز',
  ),
  actions: [
    TextButton(
      child: const Text('موافق'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  ],
);
*/