import 'dart:ui' as ui;
import 'package:feed_price_generator/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SvgGeneratorService {
  static Future<Uint8List> generatePriceListImage(
    ProductList productList,
  ) async {
    // Create a GlobalKey to capture the widget
    final GlobalKey key = GlobalKey();

    // Create the widget with the key
    final Widget priceListWidget = RepaintBoundary(
      key: key,
      child: _PriceListWidget(productList: productList),
    );

    // We need to render this widget in a context
    // For now, let's use a simpler approach with Canvas
    return _generateImageWithCanvas(productList);
  }

  static Future<Uint8List> _generateImageWithCanvas(
    ProductList productList,
  ) async {
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
      final ui.Paint headerPaint = ui.Paint()
        ..color = const ui.Color(0xFFF49E0A);
      canvas.drawRect(ui.Rect.fromLTWH(0, 0, width, headerHeight), headerPaint);

      // Logo placeholder (circle)
      final ui.Paint logoPaint = ui.Paint()
        ..color =
            const ui.Color(0x4DFFFFFF) // 30% opacity white
        ..style = ui.PaintingStyle.fill;
      canvas.drawCircle(const ui.Offset(100, 100), 50, logoPaint);

      // Title text
      final ui.ParagraphBuilder titleBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 32,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      titleBuilder.pushStyle(ui.TextStyle(color: const ui.Color(0xFFFFFFFF)));
      titleBuilder.addText('الحنش لتجارة الأعلاف');
      final ui.Paragraph titleParagraph = titleBuilder.build();
      titleParagraph.layout(ui.ParagraphConstraints(width: width));
      canvas.drawParagraph(titleParagraph, ui.Offset(0, 50));

      // Subtitle text
      final ui.ParagraphBuilder subtitleBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontSize: 24, textAlign: ui.TextAlign.center),
      );
      subtitleBuilder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFFFFFFFF)),
      );
      subtitleBuilder.addText('قائمة الأسعار');
      final ui.Paragraph subtitleParagraph = subtitleBuilder.build();
      subtitleParagraph.layout(ui.ParagraphConstraints(width: width));
      canvas.drawParagraph(subtitleParagraph, ui.Offset(0, 90));

      // Date text
      final ui.ParagraphBuilder dateBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontSize: 18, textAlign: ui.TextAlign.end),
      );
      dateBuilder.pushStyle(ui.TextStyle(color: const ui.Color(0xFFFFFFFF)));
      dateBuilder.addText('التاريخ: ${productList.date}');
      final ui.Paragraph dateParagraph = dateBuilder.build();
      dateParagraph.layout(ui.ParagraphConstraints(width: 200));
      canvas.drawParagraph(dateParagraph, ui.Offset(600, 140));

      // Day text
      final ui.ParagraphBuilder dayBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontSize: 18, textAlign: ui.TextAlign.end),
      );
      dayBuilder.pushStyle(ui.TextStyle(color: const ui.Color(0xFFFFFFFF)));
      dayBuilder.addText('اليوم: ${productList.day}');
      final ui.Paragraph dayParagraph = dayBuilder.build();
      dayParagraph.layout(ui.ParagraphConstraints(width: 200));
      canvas.drawParagraph(dayParagraph, ui.Offset(600, 165));

      // Table header background
      final ui.Paint tableHeaderPaint = ui.Paint()
        ..color = const ui.Color(0xFFF5F0E8);
      canvas.drawRect(
        ui.Rect.fromLTWH(50, tableStartY, width - 100, 60),
        tableHeaderPaint,
      );

      // Table header border
      final ui.Paint borderPaint = ui.Paint()
        ..color = const ui.Color(0xFF9E7D47)
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(
        ui.Rect.fromLTWH(50, tableStartY, width - 100, 60),
        borderPaint,
      );

      // Table header text
      final ui.ParagraphBuilder headerProductBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 16,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      headerProductBuilder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFF1C170D)),
      );
      headerProductBuilder.addText('المنتج');
      final ui.Paragraph headerProductParagraph = headerProductBuilder.build();
      headerProductParagraph.layout(ui.ParagraphConstraints(width: 200));
      canvas.drawParagraph(
        headerProductParagraph,
        ui.Offset(100, tableStartY + 20),
      );

      final ui.ParagraphBuilder header25Builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 16,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      header25Builder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFF1C170D)),
      );
      header25Builder.addText('25 كجم');
      final ui.Paragraph header25Paragraph = header25Builder.build();
      header25Paragraph.layout(ui.ParagraphConstraints(width: 100));
      canvas.drawParagraph(header25Paragraph, ui.Offset(300, tableStartY + 20));

      final ui.ParagraphBuilder header50Builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 16,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      header50Builder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFF1C170D)),
      );
      header50Builder.addText('50 كجم');
      final ui.Paragraph header50Paragraph = header50Builder.build();
      header50Paragraph.layout(ui.ParagraphConstraints(width: 100));
      canvas.drawParagraph(header50Paragraph, ui.Offset(450, tableStartY + 20));

      final ui.ParagraphBuilder headerTonBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 16,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      headerTonBuilder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFF1C170D)),
      );
      headerTonBuilder.addText('الطن');
      final ui.Paragraph headerTonParagraph = headerTonBuilder.build();
      headerTonParagraph.layout(ui.ParagraphConstraints(width: 100));
      canvas.drawParagraph(
        headerTonParagraph,
        ui.Offset(600, tableStartY + 20),
      );

      final ui.ParagraphBuilder headerPriceBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 16,
          fontWeight: ui.FontWeight.bold,
          textAlign: ui.TextAlign.center,
        ),
      );
      headerPriceBuilder.pushStyle(
        ui.TextStyle(color: const ui.Color(0xFF1C170D)),
      );
      headerPriceBuilder.addText('السعر');
      final ui.Paragraph headerPriceParagraph = headerPriceBuilder.build();
      headerPriceParagraph.layout(ui.ParagraphConstraints(width: 100));
      canvas.drawParagraph(
        headerPriceParagraph,
        ui.Offset(750, tableStartY + 20),
      );

      // Product rows
      for (int i = 0; i < productList.products.length; i++) {
        final product = productList.products[i];
        final rowY = tableStartY + 60 + (i * rowHeight);

        // Row background
        final ui.Paint rowPaint = ui.Paint()
          ..color = i % 2 == 0
              ? const ui.Color(0xFFFFFFFF)
              : const ui.Color(0xFFF5F0E8);
        canvas.drawRect(
          ui.Rect.fromLTWH(50, rowY, width - 100, rowHeight),
          rowPaint,
        );

        // Row border
        final ui.Paint rowBorderPaint = ui.Paint()
          ..color = const ui.Color(0xFF9E7D47)
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawRect(
          ui.Rect.fromLTWH(50, rowY, width - 100, rowHeight),
          rowBorderPaint,
        );

        // Product name text
        final ui.ParagraphBuilder productNameBuilder = ui.ParagraphBuilder(
          ui.ParagraphStyle(fontSize: 14, textAlign: ui.TextAlign.center),
        );
        productNameBuilder.pushStyle(
          ui.TextStyle(color: const ui.Color(0xFF1C170D)),
        );
        productNameBuilder.addText(product.productName);
        final ui.Paragraph productNameParagraph = productNameBuilder.build();
        productNameParagraph.layout(ui.ParagraphConstraints(width: 200));
        canvas.drawParagraph(productNameParagraph, ui.Offset(100, rowY + 20));

        // 25kg price text
        final ui.ParagraphBuilder price25Builder = ui.ParagraphBuilder(
          ui.ParagraphStyle(fontSize: 14, textAlign: ui.TextAlign.center),
        );
        price25Builder.pushStyle(
          ui.TextStyle(
            color: product.price25kg != null
                ? const ui.Color(0xFF1C170D)
                : const ui.Color(0xFF9E7D47),
          ),
        );
        price25Builder.addText(
          product.price25kg != null
              ? product.price25kg!.toStringAsFixed(0)
              : '-',
        );
        final ui.Paragraph price25Paragraph = price25Builder.build();
        price25Paragraph.layout(ui.ParagraphConstraints(width: 100));
        canvas.drawParagraph(price25Paragraph, ui.Offset(300, rowY + 20));

        // 50kg price text
        final ui.ParagraphBuilder price50Builder = ui.ParagraphBuilder(
          ui.ParagraphStyle(fontSize: 14, textAlign: ui.TextAlign.center),
        );
        price50Builder.pushStyle(
          ui.TextStyle(color: const ui.Color(0xFF1C170D)),
        );
        price50Builder.addText(product.price50kg.toStringAsFixed(0));
        final ui.Paragraph price50Paragraph = price50Builder.build();
        price50Paragraph.layout(ui.ParagraphConstraints(width: 100));
        canvas.drawParagraph(price50Paragraph, ui.Offset(450, rowY + 20));

        // Ton price text
        final ui.ParagraphBuilder priceTonBuilder = ui.ParagraphBuilder(
          ui.ParagraphStyle(fontSize: 14, textAlign: ui.TextAlign.center),
        );
        priceTonBuilder.pushStyle(
          ui.TextStyle(color: const ui.Color(0xFF1C170D)),
        );
        priceTonBuilder.addText(product.priceTon.toStringAsFixed(0));
        final ui.Paragraph priceTonParagraph = priceTonBuilder.build();
        priceTonParagraph.layout(ui.ParagraphConstraints(width: 100));
        canvas.drawParagraph(priceTonParagraph, ui.Offset(600, rowY + 20));

        // Currency text
        final ui.ParagraphBuilder currencyBuilder = ui.ParagraphBuilder(
          ui.ParagraphStyle(fontSize: 14, textAlign: ui.TextAlign.center),
        );
        currencyBuilder.pushStyle(
          ui.TextStyle(color: const ui.Color(0xFF1C170D)),
        );
        currencyBuilder.addText('ج.م');
        final ui.Paragraph currencyParagraph = currencyBuilder.build();
        currencyParagraph.layout(ui.ParagraphConstraints(width: 100));
        canvas.drawParagraph(currencyParagraph, ui.Offset(750, rowY + 20));
      }

      // Convert to image
      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(
        width.toInt(),
        height.toInt(),
      );
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        return byteData.buffer.asUint8List();
      } else {
        throw Exception('Failed to generate image');
      }
    } catch (e) {
      throw Exception('Error generating PNG: $e');
    }
  }
}

class _PriceListWidget extends StatelessWidget {
  final ProductList productList;

  const _PriceListWidget({required this.productList});

  @override
  Widget build(BuildContext context) {
    const double width = 800;
    const double height = 1200;
    const double headerHeight = 200;
    const double rowHeight = 80;
    const double tableStartY = 250;

    return Container(
      width: width,
      height: height,
      color: const Color(0xFFFCFAF7), // Background color
      child: Stack(
        children: [
          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(
              color: const Color(0xFFF49E0A),
              child: Stack(
                children: [
                  // Logo placeholder
                  Positioned(
                    left: 50,
                    top: 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Title
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Text(
                          'الحنش لتجارة الأعلاف',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'قائمة الأسعار',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // Date and Day
                  Positioned(
                    top: 140,
                    right: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'التاريخ: ${productList.date}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'اليوم: ${productList.day}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Table
          Positioned(
            top: tableStartY,
            left: 50,
            right: 50,
            child: Column(
              children: [
                // Table header
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F0E8),
                    border: Border.all(
                      color: const Color(0xFF9E7D47),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: const Center(
                          child: Text(
                            'المنتج',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C170D),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: const Center(
                          child: Text(
                            '25 كجم',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C170D),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: const Center(
                          child: Text(
                            '50 كجم',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C170D),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: const Center(
                          child: Text(
                            'الطن',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C170D),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: const Center(
                          child: Text(
                            'السعر',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C170D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Product rows
                ...productList.products.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final product = entry.value;

                  return Container(
                    height: rowHeight,
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white
                          : const Color(0xFFF5F0E8),
                      border: Border.all(
                        color: const Color(0xFF9E7D47),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              product.productName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1C170D),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              product.price25kg != null
                                  ? product.price25kg!.toStringAsFixed(0)
                                  : '-',
                              style: TextStyle(
                                fontSize: 14,
                                color: product.price25kg != null
                                    ? const Color(0xFF1C170D)
                                    : const Color(0xFF9E7D47),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              product.price50kg.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1C170D),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              product.priceTon.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1C170D),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: const Center(
                            child: Text(
                              'ج.م',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1C170D),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Footer
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'للاستفسار: 123456789',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9E7D47),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
