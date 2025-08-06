import 'package:flutter/material.dart';
import 'package:feed_price_generator/models/product.dart';

// Predefined Products
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
const double kSizedBoxMaxHeight = 16.0;
const double kSizedBoxMediumHeight = 12.0;
const double kSizedBoxMinHeight = 8.0;
const double kSizedBoxBaseWidth = 8.0;
const double kCardBorderRadius = 12.0;
const double kCardMargin = 16.0;

// Fonts
const String kFontFamily = 'SpaceGrotesk';
const kBaseFontSize = 16.0;

// In case of overlaying new prices on a template image [old approach]
const List<double> kRowPositions = [
  475,
  535,
  595,
  660,
  // (skipping the empty row)
  775,
  835,
  895,
  950,
];

// Column positions for 25kg, 50kg, ton
const List<double> kColumnPositions = [
  400, // 25kg
  550, // 50kg
  725, // Ton
];

// Positions for date and day
const double kDateX = 130;
const double kDateY = 210;
const double kDayX = 140;
const double kDayY = 240;
