import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:feed_price_generator/models/product.dart';
import 'package:flutter/material.dart';

class PriceGeneratorScreen extends StatefulWidget {
  const PriceGeneratorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceGeneratorScreenState createState() => _PriceGeneratorScreenState();
}

class _PriceGeneratorScreenState extends State<PriceGeneratorScreen> {
  final List<Product> products = [
    Product('سوبر بادي 23%', true),
    Product('سوبر نامي 21%', true),
    Product('سوبر ناهي 19%', true),
    Product('بادي نامي 21%', true),
    Product('علف مواشي حلاب 19%', false),
    Product('علف بتلو 21%', false),
    Product('علف مواشي سوبر 16%', false),
    Product('علف مواشي سوبر 14%', false),
  ];

  Map<String, Map<String, TextEditingController>> controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    for (var product in products) {
      controllers[product.name] = {};
      if (product.has25kg) {
        controllers[product.name]!['25kg'] = TextEditingController();
      }
      controllers[product.name]!['50kg'] = TextEditingController();
      controllers[product.name]!['ton'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var productControllers in controllers.values) {
      for (var controller in productControllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Future<void> generateImage() async {
    try {
      // Load the template image from assets
      final ByteData data = await rootBundle.load(
        'assets/images/template.jpeg',
      );
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image templateImage = frameInfo.image;

      // Create a canvas to draw on
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw the template image
      canvas.drawImage(templateImage, Offset.zero, Paint());

      // Set up text style for prices
      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

      final List<double> rowPositions = [
        485,
        525,
        565,
        605,
        645,
        685,
        725,
        765,
      ];
      final double col25kg = 680;
      final double col50kg = 580;
      final double colTon = 480;

      // Draw prices
      for (int i = 0; i < products.length; i++) {
        final product = products[i];
        final y = rowPositions[i];

        if (product.has25kg &&
            controllers[product.name]!['25kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['25kg']!.text,
            Offset(col25kg, y),
            textStyle,
          );
        }

        if (controllers[product.name]!['50kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['50kg']!.text,
            Offset(col50kg, y),
            textStyle,
          );
        }

        if (controllers[product.name]!['ton']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['ton']!.text,
            Offset(colTon, y),
            textStyle,
          );
        }
      }

      final picture = recorder.endRecording();
      final img = await picture.toImage(
        templateImage.width,
        templateImage.height,
      );
      final ByteData? pngBytes = await img.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (pngBytes != null) {
        await _saveImage(pngBytes.buffer.asUint8List());
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ تم حفظ الصورة في مجلد التطبيق')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ خطأ أثناء إنشاء الصورة: $e')));
    }
  }

  void _drawText(Canvas canvas, String text, Offset position, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl, // Right to left for Arabic
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  Future<void> _saveImage(Uint8List bytes) async {
    final directory = await getExternalStorageDirectory();
    final String path =
        '${directory!.path}/feed_prices_${DateTime.now().millisecondsSinceEpoch}.png';
    final File file = File(path);
    await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الحنش لتجارة الأعلاف'),
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              if (product.has25kg) ...[
                                Expanded(
                                  child: TextField(
                                    controller:
                                        controllers[product.name]!['25kg'],
                                    decoration: InputDecoration(
                                      labelText: 'سعر عبوة 25 كيلو جرام',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                              Expanded(
                                child: TextField(
                                  controller:
                                      controllers[product.name]!['50kg'],
                                  decoration: InputDecoration(
                                    labelText: 'سعر عبوة 50 كيلو جرام',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: controllers[product.name]!['ton'],
                                  decoration: InputDecoration(
                                    labelText: 'سعر الطن',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('أنشئ الصورة'),
            ),
          ],
        ),
      ),
    );
  }
}
