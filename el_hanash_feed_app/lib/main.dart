import 'package:device_preview/device_preview.dart';
import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/views/price_generator_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const FeedStock(),
    ),
  );
}

class FeedStock extends StatelessWidget {
  const FeedStock({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أسعار الأعلاف',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: kFontFamily,

        // Set Scaffold background color
        scaffoldBackgroundColor: kBackgroundColor,

        // Set AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          foregroundColor: kFontColor, // title and icon color
          elevation: 0, // flat app bar
        ),
      ),
      locale: const Locale('ar', 'EG'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const PriceGeneratorScreen(),
    );
  }
}
