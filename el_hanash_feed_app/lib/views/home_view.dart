import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/views/price_generator_view.dart';
import 'package:feed_price_generator/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "الحنش لتجارة الأعلاف"),
      body: Padding(
        padding: const EdgeInsets.all(kPrimaryPaddding),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                buttonText: "إنشاء قائمة أسعار جديدة",
                onPressed: () {
                  Navigator.pushNamed(context, PriceGeneratorView.routeName);
                },
                backgroundColor: kCTAColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
