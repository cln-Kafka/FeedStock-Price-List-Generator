import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أسعار الأعلاف',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Arial'),
      // Set RTL support
      locale: Locale('ar', 'EG'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: PriceGeneratorScreen(),
    );
  }
}

class Product {
  final String name;
  final bool has25kg;

  Product(this.name, this.has25kg);
}

class PriceGeneratorScreen extends StatefulWidget {
  @override
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
  TextEditingController dateController = TextEditingController();
  TextEditingController dayController = TextEditingController();

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
    controllers.values.forEach((productControllers) {
      productControllers.values.forEach((controller) => controller.dispose());
    });
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
      final textStyle = TextStyle(
        color: Colors.brown,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

      // Define positions for each product row (skipping the empty row)
      final List<double> rowPositions = [
        475,
        535,
        595,
        660,
        775,
        835,
        895,
        950,
      ];

      // Column positions for 25kg, 50kg, ton (adjusted for better spacing)
      final double col25kg = 400;
      final double col50kg = 550;
      final double colTon = 725;

      // Positions for date and day
      final double dateX = 130;
      final double dateY = 210;
      final double dayX = 140;
      final double dayY = 240;

      // Draw date and day
      if (dateController.text.isNotEmpty) {
        _drawText(canvas, dateController.text, Offset(dateX, dateY), textStyle);
      }
      if (dayController.text.isNotEmpty) {
        _drawText(canvas, dayController.text, Offset(dayX, dayY), textStyle);
      }

      // Draw prices on the image
      for (int i = 0; i < products.length; i++) {
        final product = products[i];
        final y = rowPositions[i];

        // Draw 25kg price (if product has it)
        if (product.has25kg &&
            controllers[product.name]!['25kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['25kg']!.text,
            Offset(col25kg, y),
            textStyle,
          );
        }

        // Draw 50kg price
        if (controllers[product.name]!['50kg']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['50kg']!.text,
            Offset(col50kg, y),
            textStyle,
          );
        }

        // Draw ton price
        if (controllers[product.name]!['ton']!.text.isNotEmpty) {
          _drawText(
            canvas,
            controllers[product.name]!['ton']!.text,
            Offset(colTon, y),
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
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageDisplayScreen(imageBytes: pngBytes.buffer.asUint8List()),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أدخل أسعار الأعلاف'),
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date and Day input fields
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'التاريخ',
                          border: OutlineInputBorder(),
                          hintText: 'مثال: 2025/06/17',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: dayController,
                        decoration: InputDecoration(
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
                                      labelText: 'سعر عبوة ٢٥ كيلو',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                              Expanded(
                                child: TextField(
                                  controller:
                                      controllers[product.name]!['50kg'],
                                  decoration: InputDecoration(
                                    labelText: 'سعر عبوة ٥٠ كيلو',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateImage,
              child: Text('إنشاء قائمة الأسعار'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDisplayScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const ImageDisplayScreen({Key? key, required this.imageBytes})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة الأسعار'),
        backgroundColor: Colors.brown[300],
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('كيفية الحفظ'),
                    content: Text(
                      'لحفظ الصورة، قم بأخذ لقطة شاشة باستخدام أزرار الجهاز',
                    ),
                    actions: [
                      TextButton(
                        child: Text('موافق'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: InteractiveViewer(
          panEnabled: true,
          scaleEnabled: true,
          minScale: 0.5,
          maxScale: 3.0,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Image.memory(imageBytes, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.brown[400],
        child: Icon(Icons.edit, color: Colors.white),
        tooltip: 'تعديل الأسعار',
      ),
    );
  }
}
