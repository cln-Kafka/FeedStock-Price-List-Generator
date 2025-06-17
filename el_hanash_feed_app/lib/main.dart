import 'package:feed_price_generator/views/price_generator_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Price Generator',
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Arial'),
      debugShowCheckedModeBanner: false,
      home: PriceGeneratorScreen(),
    );
  }
}
