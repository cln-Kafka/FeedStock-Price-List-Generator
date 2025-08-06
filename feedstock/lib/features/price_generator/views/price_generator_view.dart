import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/core/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/cubits/product_list_cubit.dart';
import 'package:feed_price_generator/features/price_generator/widgets/date_day_selector.dart';
import 'package:feed_price_generator/features/price_generator/widgets/action_buttons.dart';
import 'package:feed_price_generator/features/price_generator/widgets/product_list_section.dart';
import 'package:feed_price_generator/features/price_generator/services/price_generator_service.dart';
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
  DateTime _selectedDate = DateTime.now();
  final Map<String, ProductPrice> _productPrices = {};
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.existingProductList != null) {
      _selectedDate = PriceGeneratorService.parseDateFromString(
        widget.existingProductList!.date,
      );

      for (final productPrice in widget.existingProductList!.products) {
        _productPrices[productPrice.productName] = productPrice;
      }
    } else {
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
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
                  _selectedDate = DateTime.now();
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
    if (!PriceGeneratorService.validateProductPrices(_productPrices)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال أسعار المنتجات')),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    final productList = PriceGeneratorService.createProductList(
      id: widget.existingProductList?.id ?? const Uuid().v4(),
      selectedDate: _selectedDate,
      productPrices: _productPrices,
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
              // Date and Day selector
              DateDaySelector(
                selectedDate: _selectedDate,
                onDateChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),

              // Product list section
              ProductListSection(
                productPrices: _productPrices,
                onPriceChanged: _onPriceChanged,
              ),

              // Action buttons
              ActionButtons(
                isGenerating: _isGenerating,
                onGeneratePressed: _generatePriceList,
                onResetPressed: _resetAllFields,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
