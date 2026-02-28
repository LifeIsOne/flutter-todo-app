import 'package:flutter/material.dart';

/* ✅라이트 모드 */
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // 아이콘 색상
  primary: Color(0xFF5D86DB),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF2E81F6),
  onSecondary: Color(0xFFFFFFFF),
  tertiary: Color(0xFF97BD41),
  onTertiary: Color(0xFFFFFFFF),
  error: Color(0xFFFF4B6E),
  onError: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outline: Color(0xFFE0E3E7),
  outlineVariant: Color(0xFFF1F3F5),
  surface: Color(0xFFF7F9FC),
  surfaceTint: Color(0xFF1A1C18),
  onSurface: Color(0xFF1A1C18),
);
/* ✅다크 모드 */
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF90CAF9),
  onPrimary: Colors.black,
  secondary: Color(0xFFCE93D8),
  onSecondary: Colors.black,
  tertiary: Color(0xFF80CBC4),
  onTertiary: Colors.black,
  error: Color(0xFFEF9A9A),
  onError: Colors.black,
  // 텍스트
  surface: Color(0xFF1D1D1D),
  // ListTile, Card
  onSurface: Color(0xFFE0E0E0),
  shadow: Colors.black,
  outline: Color(0xFF3A3A3A),
  outlineVariant: Color(0xFF4A4A4A),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,

  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
    ),
  ),

  cardColor: lightColorScheme.surface,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.onPrimary,
      ),
      // text color
      elevation: WidgetStateProperty.all<double>(5.0),
      // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  cardColor: darkColorScheme.surface,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        darkColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        darkColorScheme.onPrimary,
      ),
    ),
  ),
);
