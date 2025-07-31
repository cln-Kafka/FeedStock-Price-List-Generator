import 'package:flutter/material.dart';
import 'package:feed_price_generator/models/product.dart';

List<Product> kProducts = [
  Product('سوبر بادي 23%', true),
  Product('سوبر نامي 21%', true),
  Product('سوبر ناهي 19%', true),
  Product('بادي نامي 21%', true),
  Product('علف مواشي حلاب 19%', false),
  Product('علف بتلو 21%', false),
  Product('علف مواشي سوبر 16%', false),
  Product('علف مواشي سوبر 14%', false),
];

// Colors
const kCTAColor = Color(0xFFF49E0A);
const kBackgroundColor = Color(0xFFFCFAF7);
const kSecondaryColor = Color(0xFFF5F0E8);
const kFontColor = Color(0xFF1C170D);
const kFontColor2 = Color(0xFF9E7D47);

// Dimensions
const double kPrimaryPaddding = 16.0;
const double kButtonsBorderRadius = 8.0;
const double kSizedBoxBaseHeight = 16.0;
const double kSizedBoxBaseWidth = 8.0;

// Fonts
const String kFontFamily = 'SpaceGrotesk';
const kBaseFontSize = 16.0;
