import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.imageBytes});

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
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
    );
  }
}
