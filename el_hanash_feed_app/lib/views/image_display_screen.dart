import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageDisplayScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const ImageDisplayScreen({super.key, required this.imageBytes});

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
        tooltip: 'تعديل الأسعار',
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
