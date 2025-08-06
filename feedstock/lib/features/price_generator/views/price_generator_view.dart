import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/core/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/core/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/features/price_generator/widgets/product_price_input.dart';
import 'package:feed_price_generator/cubits/product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:feed_price_generator/models/product_price.dart';

class PriceGeneratorView extends StatefulWidget {
  final ProductList? existingProductList;

  const PriceGeneratorView({super.key, this.existingProductList});

  static const String routeName = '/price-generator-view';

  @override
  State<PriceGeneratorView> createState() => _PriceGeneratorViewState();
}

class _PriceGeneratorViewState extends State<PriceGeneratorView> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final Map<String, ProductPrice> _productPrices = {};
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.existingProductList != null) {
      _dateController.text = widget.existingProductList!.date;
      _dayController.text = widget.existingProductList!.day;

      for (final productPrice in widget.existingProductList!.products) {
        _productPrices[productPrice.productName] = productPrice;
      }
    } else {
      // Initialize with current date and day
      final now = DateTime.now();
      _dateController.text =
          '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}';

      // Get Arabic day name
      final days = [
        'الأحد',
        'الإثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
      ];
      _dayController.text = days[now.weekday % 7];
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  void _onPriceChanged(ProductPrice productPrice) {
    setState(() {
      _productPrices[productPrice.productName] = productPrice;
    });
  }

  void _resetAllFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد'),
          content: const Text('هل أنت متأكد من أنك تريد مسح جميع البيانات؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _productPrices.clear();
                  _dateController.clear();
                  _dayController.clear();
                  _initializeData();
                });
              },
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );
  }

  void _generatePriceList() {
    if (_dateController.text.isEmpty || _dayController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال التاريخ واليوم')),
      );
      return;
    }

    if (_productPrices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال أسعار المنتجات')),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    final productList = ProductList(
      id: widget.existingProductList?.id ?? const Uuid().v4(),
      date: _dateController.text,
      day: _dayController.text,
      products: _productPrices.values.toList(),
      createdAt: DateTime.now(),
    );

    context.read<ProductListCubit>().generateImage(productList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "أسعار المنتجات"),
      body: BlocListener<ProductListCubit, ProductListState>(
        listener: (context, state) {
          if (state is ImageGenerated) {
            setState(() {
              _isGenerating = false;
            });

            // Save the product list
            context.read<ProductListCubit>().saveProductList(state.productList);

            // Navigate to image display
            Navigator.pushNamed(
              context,
              '/image-display-view',
              arguments: {
                'imageBytes': state.imageBytes,
                'productList': state.productList,
              },
            );
          } else if (state is ImageGenerationError) {
            setState(() {
              _isGenerating = false;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: kPrimaryPaddding,
            right: kPrimaryPaddding,
            bottom: kPrimaryPaddding,
          ),
          child: Column(
            children: [
              // Date and Day input fields
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _dateController,
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
                          controller: _dayController,
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

              // Product price inputs
              Expanded(
                child: ListView.builder(
                  itemCount: kProducts.length,
                  itemBuilder: (context, index) {
                    final product = kProducts[index];
                    final initialPrice = _productPrices[product.name];

                    return ProductPriceInput(
                      product: product,
                      initialPrice: initialPrice,
                      onPriceChanged: _onPriceChanged,
                    );
                  },
                ),
              ),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      buttonText: _isGenerating
                          ? "جاري الإنشاء..."
                          : "إنشاء قائمة الأسعار",
                      onPressed: _isGenerating ? null : _generatePriceList,
                      backgroundColor: kCTAColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _resetAllFields,
                    icon: const Icon(Icons.delete),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        kSecondaryColor,
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        kFontColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
