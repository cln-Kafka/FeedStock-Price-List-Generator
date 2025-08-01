import 'package:feed_price_generator/constants.dart';
import 'package:feed_price_generator/views/home_view.dart';
import 'package:feed_price_generator/views/price_generator_view.dart';
import 'package:feed_price_generator/views/image_display_view.dart';
import 'package:feed_price_generator/cubits/product_list_cubit.dart';
import 'package:feed_price_generator/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const FeedStock(),
  );
}

class FeedStock extends StatelessWidget {
  const FeedStock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(),
      child: MaterialApp(
        title: 'أسعار الأعلاف',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: kFontFamily,
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kBackgroundColor,
            foregroundColor: kFontColor, // title and icon color
            elevation: 0, // flat app bar
          ),
        ),
        locale: const Locale('ar', 'EG'),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        routes: {
          HomeView.routeName: (context) => const HomeView(),
          PriceGeneratorView.routeName: (context) => const PriceGeneratorView(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ImageDisplayView.routeName) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ImageDisplayView(
                imageBytes: args['imageBytes'] as Uint8List,
                productList: args['productList'] as ProductList,
              ),
            );
          }
          return null;
        },
        initialRoute: HomeView.routeName,
      ),
    );
  }
}
