import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';

class MainAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Basic theme properties
      brightness: Brightness.light,
      fontFamily: kFontFamily,
      scaffoldBackgroundColor: kBackgroundColor,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: kCTAColor,
        secondary: kSecondaryColor,
        surface: kBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: kFontColor,
        onSurface: kFontColor,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: kBackgroundColor,
        foregroundColor: kFontColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: kFontColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
        ),
        margin: const EdgeInsets.all(kCardMargin),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kCTAColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: kCTAColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          ),
          textStyle: const TextStyle(
            fontFamily: kFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kCTAColor,
          textStyle: const TextStyle(
            fontFamily: kFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kCTAColor,
          side: const BorderSide(color: kCTAColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: kFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme (for TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          borderSide: const BorderSide(color: kSecondaryColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          borderSide: const BorderSide(color: kSecondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          borderSide: const BorderSide(color: kCTAColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          color: kFontColor.withValues(alpha: 0.5),
        ),
        labelStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          color: kFontColor.withValues(alpha: 0.7),
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          color: kCTAColor,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Selection Theme (cursor/caret color)
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kCTAColor,
        selectionColor: kCTAColor,
        selectionHandleColor: kCTAColor,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: kFontColor,
        ),
        displayMedium: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: kFontColor,
        ),
        displaySmall: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        titleLarge: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        titleMedium: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: kFontColor,
        ),
        titleSmall: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: kFontColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kFontColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: kFontColor,
        ),
        bodySmall: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: kFontColor2,
        ),
        labelLarge: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: kFontColor,
        ),
        labelMedium: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: kFontColor,
        ),
        labelSmall: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: kFontColor2,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: kFontColor, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: kSecondaryColor,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: kCTAColor,
        unselectedItemColor: kFontColor2,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kCTAColor,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: CircleBorder(),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: kSecondaryColor,
        selectedColor: kCTAColor,
        disabledColor: kSecondaryColor.withValues(alpha: 0.5),
        labelStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return kFontColor2;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kCTAColor;
          }
          return kSecondaryColor;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kCTAColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: kFontColor2, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kCTAColor;
          }
          return kFontColor2;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: kCTAColor,
        inactiveTrackColor: kSecondaryColor,
        thumbColor: kCTAColor,
        overlayColor: kCTAColor.withValues(alpha: 0.2),
        valueIndicatorColor: kCTAColor,
        valueIndicatorTextStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: kCTAColor,
        linearTrackColor: kSecondaryColor,
        circularTrackColor: kSecondaryColor,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kFontColor,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kFontColor,
        ),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: kFontColor,
        contentTextStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kCardBorderRadius),
          ),
        ),
      ),

      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
        ),
        textStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kFontColor,
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: kFontColor,
          borderRadius: BorderRadius.circular(kButtonsBorderRadius),
        ),
        textStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  // Dark Theme (if needed in the future)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      // Add dark theme properties here when needed
    );
  }
}
