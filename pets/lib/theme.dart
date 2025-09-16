// lib/theme.dart
import 'package:flutter/material.dart';

/// Cores base usadas pelo app (ajuste se desejar)
const Color kPrimary = Color(0xFF4F1F1F); // vinho escuro
const Color kSurface = Color(0xFF3A1414); // cartão/área mais escura
const Color kScaffoldBg = Color(0xFF2B0E0E); // fundo geral
const Color kButton = Color(0xFF8F5F66); // botão rosado acinzentado
const Color kButtonOn = Color(0xFFF5EAEA); // texto no botão (claro)
const Color kAccent = Color(0xFFB98B92); // acento (opcional)
const Color kInputFill = Color(0xFF402020); // campo input
const Color kHint = Color(0xFFBFA7A7); // hint text
const Color kOnBackground = Color(0xFFF8EFEF); // texto principal

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimary,
  scaffoldBackgroundColor: kScaffoldBg,
  colorScheme: ColorScheme.dark(
    primary: kPrimary,
    secondary: kAccent,
    background: kScaffoldBg,
    surface: kSurface,
    onPrimary: kButtonOn,
    onBackground: kOnBackground,
    onSurface: kOnBackground,
  ),

  // Tipografia: ajuste fontFamily após incluir fonte no pubspec.yaml se quiser
  fontFamily: 'Roboto', // troque para sua fonte customizada (ex: 'Raleway', 'YourFont')
  textTheme: TextTheme(
    displayLarge: TextStyle( // usado para grandes títulos
      fontSize: 38,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: kOnBackground,
      height: 1.05,
    ),
    headlineSmall: TextStyle( // títulos menores
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kOnBackground,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kOnBackground,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      color: kOnBackground,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: kHint,
    ),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontStyle: FontStyle.italic,
      color: kOnBackground,
      fontWeight: FontWeight.w300,
    ),
    iconTheme: IconThemeData(color: kOnBackground),
  ),

  // Botões elevados (ex: botão "Cadastrar")
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButton,
      foregroundColor: kButtonOn,
      elevation: 4,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),

  // Floating action button (se usar)
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kButton,
    foregroundColor: kButtonOn,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // Input fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kInputFill,
    hintStyle: TextStyle(color: kHint),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    errorStyle: TextStyle(color: Colors.red[300]),
  ),

  // Cards usados na lista de pets
  cardTheme: CardTheme(
    color: kSurface,
    elevation: 6,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Divider, icon theme, etc
  dividerColor: Colors.white12,
  iconTheme: IconThemeData(color: kOnBackground),
);
