import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/models/product_list.dart';
import 'package:feed_price_generator/features/price_generator/views/price_generator_view.dart';
import 'package:feed_price_generator/core/widgets/custom_app_bar.dart';
import 'package:feed_price_generator/core/widgets/custom_elevated_button.dart';
import 'package:feed_price_generator/features/home/widgets/cached_product_list_item.dart';
import 'package:feed_price_generator/cubits/product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Load cached product lists when the view is initialized
    context.read<ProductListCubit>().loadProductLists();
  }

  void _createNewPriceList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PriceGeneratorView()),
    );
  }

  void _editExistingPriceList(ProductList productList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PriceGeneratorView(existingProductList: productList),
      ),
    );
  }

  void _deletePriceList(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من أنك تريد حذف هذه القائمة؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProductListCubit>().deleteProductList(id);
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "الحنش لتجارة الأعلاف"),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(kPrimaryPaddding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    buttonText: "إنشاء قائمة أسعار جديدة",
                    onPressed: _createNewPriceList,
                    backgroundColor: kCTAColor,
                  ),
                ),
                const SizedBox(height: 24),

                if (state is ProductListLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is ProductListLoaded &&
                    state.productLists.isNotEmpty) ...[
                  const Text(
                    'القوائم المحفوظة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kFontColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.productLists.length,
                      itemBuilder: (context, index) {
                        final productList = state.productLists[index];
                        return CachedProductListItem(
                          productList: productList,
                          onEdit: () => _editExistingPriceList(productList),
                          onDelete: () => _deletePriceList(productList.id),
                        );
                      },
                    ),
                  ),
                ] else if (state is ProductListLoaded &&
                    state.productLists.isEmpty) ...[
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 64, color: kFontColor2),
                          SizedBox(height: 16),
                          Text(
                            'لا توجد قوائم محفوظة',
                            style: TextStyle(fontSize: 18, color: kFontColor2),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'قم بإنشاء قائمة أسعار جديدة لتظهر هنا',
                            style: TextStyle(fontSize: 14, color: kFontColor2),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else if (state is ProductListError) ...[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'خطأ في تحميل القوائم',
                            style: const TextStyle(
                              fontSize: 18,
                              color: kFontColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            style: const TextStyle(
                              fontSize: 14,
                              color: kFontColor2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          CustomElevatedButton(
                            buttonText: "إعادة المحاولة",
                            onPressed: () {
                              context
                                  .read<ProductListCubit>()
                                  .loadProductLists();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
