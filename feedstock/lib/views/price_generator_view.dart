import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/widgets/day_date_confirmation_alert.dart';
import 'package:feed_price_generator/widgets/product_card.dart';
import 'package:flutter/material.dart';

class PriceGeneratorView extends StatefulWidget {
  const PriceGeneratorView({super.key});

  static const String routeName = '/price-generator-view';

  @override
  State<PriceGeneratorView> createState() => _PriceGeneratorViewState();
}

class _PriceGeneratorViewState extends State<PriceGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "أسعار المنتجات"),
      body: Padding(
        padding: const EdgeInsets.all(kPrimaryPaddding),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: kProducts.length,
                itemBuilder: (context, index) {
                  final product = kProducts[index];
                  return ProductCard(productName: product.name);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    buttonText: "إنشاء قائمة الأسعار",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DayDateConfirmationAlert();
                        },
                      );
                    },
                    backgroundColor: kCTAColor,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      kSecondaryColor,
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(kFontColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/*
==================================================================
=============================== UI ===============================
==================================================================

            // Date and Day input fields
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'التاريخ',
                          border: OutlineInputBorder(),
                          hintText: 'مثال: 2025/06/17',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: dayController,
                        decoration: const InputDecoration(
                          labelText: 'اليوم',
                          border: OutlineInputBorder(),
                          hintText: 'مثال: الثلاثاء',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: kProducts.length,
                itemBuilder: (context, index) {
                  final product = kProducts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              if (product.has25kg) ...[
                                Expanded(
                                  child: TextField(
                                    controller:
                                        controllers[product.name]!['25kg'],
                                    decoration: const InputDecoration(
                                      labelText: 'سعر عبوة ٢٥ كيلو',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Expanded(
                                child: TextField(
                                  controller:
                                      controllers[product.name]!['50kg'],
                                  decoration: const InputDecoration(
                                    labelText: 'سعر عبوة ٥٠ كيلو',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: controllers[product.name]!['ton'],
                                  decoration: const InputDecoration(
                                    labelText: 'سعر الطن',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
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
*/

/*
=================================================================
============================= LOGIC =============================
=================================================================

Map<String, Map<String, TextEditingController>> controllers = {};
  TextEditingController dateController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    for (var product in kProducts) {
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
    dateController.dispose();
    dayController.dispose();
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
      const textStyle = TextStyle(
        color: Colors.brown,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

      // Draw date and day
      if (dateController.text.isNotEmpty) {
        _drawText(
          canvas,
          dateController.text,
          const Offset(kDateX, kDateY),
          textStyle,
        );
      }
      if (dayController.text.isNotEmpty) {
        _drawText(
          canvas,
          dayController.text,
          const Offset(kDayX, kDayY),
          textStyle,
        );
      }

      // Draw prices on the image
      for (int i = 0; i < kProducts.length; i++) {
        final product = kProducts[i];
        final y = kRowPositions[i];

        // Draw 25kg price (if product has it)
        if (product.has25kg &&
            controllers[product.name]!['25kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['25kg']!.text,
            Offset(kColumnPositions[0], y),
            textStyle,
          );
        }

        // Draw 50kg price
        if (controllers[product.name]!['50kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['50kg']!.text,
            Offset(kColumnPositions[1], y),
            textStyle,
          );
        }

        // Draw ton price
        if (controllers[product.name]!['ton']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['ton']!.text,
            Offset(kColumnPositions[2], y),
            textStyle,
          );
        }
      }

      // Convert to image
      final picture = recorder.endRecording();
      final img = await picture.toImage(
        templateImage.width,
        templateImage.height,
      );
      final ByteData? pngBytes = await img.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (pngBytes != null) {
        // Navigate to image display screen
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageDisplayView(imageBytes: pngBytes.buffer.asUint8List()),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في إنشاء الصورة: $e')));
    }
  }

  void _drawText(Canvas canvas, String text, Offset position, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }
*/
