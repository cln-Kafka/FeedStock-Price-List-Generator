import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:feed_price_generator/models/product_list.dart';
import 'package:flutter/services.dart';

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

  // Simplified method that recreates the design using Canvas directly
  static Future<Uint8List> svgToPngBytes(String svgContent, ProductList productList) async {
    const double width = 800;
    const double height = 1200;
    const double headerHeight = 200;
    const double rowHeight = 80;
    const double tableStartY = 250;

    try {
      // Create a picture recorder
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);

      // Background
      canvas.drawColor(const ui.Color(0xFFFCFAF7), ui.BlendMode.src);

      // Header
      final ui.Paint headerPaint = ui.Paint()..color = const ui.Color(0xFFF49E0A);
      canvas.drawRect(ui.Rect.fromLTWH(0, 0, width, headerHeight), headerPaint);

      // Logo placeholder (circle)
      final ui.Paint logoPaint = ui.Paint()
        ..color = const ui.Color(0x4DFFFFFF) // 30% opacity white
        ..style = ui.PaintingStyle.fill;
      canvas.drawCircle(const ui.Offset(100, 100), 50, logoPaint);

      // Table header background
      final ui.Paint tableHeaderPaint = ui.Paint()..color = const ui.Color(0xFFF5F0E8);
      canvas.drawRect(ui.Rect.fromLTWH(50, tableStartY, width - 100, 60), tableHeaderPaint);

      // Table header border
      final ui.Paint borderPaint = ui.Paint()
        ..color = const ui.Color(0xFF9E7D47)
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(ui.Rect.fromLTWH(50, tableStartY, width - 100, 60), borderPaint);

      // Product rows
      for (int i = 0; i < productList.products.length; i++) {
        final rowY = tableStartY + 60 + (i * rowHeight);
        
        // Row background
        final ui.Paint rowPaint = ui.Paint()
          ..color = i % 2 == 0 ? const ui.Color(0xFFFFFFFF) : const ui.Color(0xFFF5F0E8);
        canvas.drawRect(ui.Rect.fromLTWH(50, rowY, width - 100, rowHeight), rowPaint);

        // Row border
        final ui.Paint rowBorderPaint = ui.Paint()
          ..color = const ui.Color(0xFF9E7D47)
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawRect(ui.Rect.fromLTWH(50, rowY, width - 100, rowHeight), rowBorderPaint);
      }

      // Note: Text rendering in Flutter Canvas requires more complex setup with TextPainter
      // For now, this creates the basic structure. You might want to use a widget-based approach
      // for text rendering if you need the Arabic text to display properly.

      // Convert to image
      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        return byteData.buffer.asUint8List();
      } else {
        throw Exception('Failed to generate image');
      }
    } catch (e) {
      throw Exception('Error generating PNG: $e');
    }
  }

  // Alternative: Widget-based approach (recommended for complex layouts with text)
  static Future<Uint8List> generatePriceListImage(ProductList productList) async {
    // This approach would create a Flutter widget that renders your price list
    // and then convert that widget to an image using RepaintBoundary
    // This is more reliable for Arabic text and complex layouts
    
    // You would need to create a Widget that matches your SVG design
    // Then use something like this:
    /*
    final RenderRepaintBoundary boundary = globalKey.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
    */
    
    throw UnimplementedError('Implement widget-based rendering for better text support');
  }
}