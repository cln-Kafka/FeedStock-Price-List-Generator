import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:feed_price_generator/models/product.dart';

class SvgGeneratorService {
  static String generatePriceListSvg(ProductList productList) {
    const double width = 800;
    const double height = 1200;
    const double headerHeight = 200;
    const double rowHeight = 80;
    const double tableStartY = 250;

    final List<String> svgElements = [
      // Background
      '<rect width="$width" height="$height" fill="#FCFAF7"/>',

      // Header
      '<rect x="0" y="0" width="$width" height="$headerHeight" fill="#F49E0A"/>',

      // Logo placeholder
      '<circle cx="100" cy="100" r="50" fill="#FFFFFF" opacity="0.3"/>',

      // Title
      '<text x="${width / 2}" y="80" text-anchor="middle" font-family="Arial, sans-serif" font-size="32" font-weight="bold" fill="#FFFFFF">الحنش لتجارة الأعلاف</text>',
      '<text x="${width / 2}" y="120" text-anchor="middle" font-family="Arial, sans-serif" font-size="24" fill="#FFFFFF">قائمة الأسعار</text>',

      // Date and Day
      '<text x="650" y="160" text-anchor="end" font-family="Arial, sans-serif" font-size="18" fill="#FFFFFF">التاريخ: ${productList.date}</text>',
      '<text x="650" y="185" text-anchor="end" font-family="Arial, sans-serif" font-size="18" fill="#FFFFFF">اليوم: ${productList.day}</text>',

      // Table header
      '<rect x="50" y="$tableStartY" width="${width - 100}" height="60" fill="#F5F0E8" stroke="#9E7D47" stroke-width="2"/>',
      '<text x="100" y="${tableStartY + 35}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#1C170D">المنتج</text>',
      '<text x="300" y="${tableStartY + 35}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#1C170D">25 كجم</text>',
      '<text x="450" y="${tableStartY + 35}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#1C170D">50 كجم</text>',
      '<text x="600" y="${tableStartY + 35}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#1C170D">الطن</text>',
      '<text x="750" y="${tableStartY + 35}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#1C170D">السعر</text>',
    ];

    // Product rows
    double currentY = tableStartY + 60;
    for (int i = 0; i < productList.products.length; i++) {
      final product = productList.products[i];
      final rowY = currentY + (i * rowHeight);

      // Row background
      svgElements.add(
        '<rect x="50" y="$rowY" width="${width - 100}" height="$rowHeight" fill="${i % 2 == 0 ? '#FFFFFF' : '#F5F0E8'}" stroke="#9E7D47" stroke-width="1"/>',
      );

      // Product name
      svgElements.add(
        '<text x="100" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#1C170D">${product.productName}</text>',
      );

      // 25kg price
      if (product.price25kg != null) {
        svgElements.add(
          '<text x="300" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#1C170D">${product.price25kg!.toStringAsFixed(0)}</text>',
        );
      } else {
        svgElements.add(
          '<text x="300" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#9E7D47">-</text>',
        );
      }

      // 50kg price
      svgElements.add(
        '<text x="450" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#1C170D">${product.price50kg.toStringAsFixed(0)}</text>',
      );

      // Ton price
      svgElements.add(
        '<text x="600" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#1C170D">${product.priceTon.toStringAsFixed(0)}</text>',
      );

      // Price column (empty for now, can be used for additional info)
      svgElements.add(
        '<text x="750" y="${rowY + 45}" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#1C170D">د.ك</text>',
      );
    }

    // Footer
    final footerY =
        tableStartY + 60 + (productList.products.length * rowHeight) + 50;
    svgElements.add(
      '<text x="${width / 2}" y="$footerY" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#9E7D47">للاستفسار: 123456789</text>',
    );

    final svgContent =
        '''
<?xml version="1.0" encoding="UTF-8"?>
<svg width="$width" height="$height" xmlns="http://www.w3.org/2000/svg">
  ${svgElements.join('\n  ')}
</svg>
''';

    return svgContent;
  }

  static Future<Uint8List> svgToPngBytes(String svgContent) async {
    // Create a simple colored image as a placeholder
    // This will be replaced with proper SVG to PNG conversion in the future

    const int width = 800;
    const int height = 1200;

    // Create a picture recorder
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);

    // Set background color
    canvas.drawColor(const ui.Color(0xFFFCFAF7), ui.BlendMode.src);

    // Draw header
    final ui.Paint headerPaint = ui.Paint()..color = const ui.Color(0xFFF49E0A);
    canvas.drawRect(ui.Rect.fromLTWH(0, 0, width.toDouble(), 200), headerPaint);

    // Draw a simple table placeholder
    final ui.Paint tablePaint = ui.Paint()
      ..color = const ui.Color(0xFFF5F0E8)
      ..style = ui.PaintingStyle.fill;

    canvas.drawRect(ui.Rect.fromLTWH(50, 250, width - 100, 400), tablePaint);

    // Draw table border
    final ui.Paint borderPaint = ui.Paint()
      ..color = const ui.Color(0xFF9E7D47)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(ui.Rect.fromLTWH(50, 250, width - 100, 400), borderPaint);

    // Draw some simple rectangles to represent content
    final ui.Paint contentPaint = ui.Paint()
      ..color = const ui.Color(0xFF1C170D)
      ..style = ui.PaintingStyle.fill;

    // Draw some placeholder rectangles for text
    for (int i = 0; i < 8; i++) {
      canvas.drawRect(
        ui.Rect.fromLTWH(100, 300 + (i * 50), 600, 30),
        contentPaint,
      );
    }

    // End recording and convert to image
    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(width, height);
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    if (byteData != null) {
      return byteData.buffer.asUint8List();
    } else {
      throw Exception('Failed to generate image');
    }
  }
}
