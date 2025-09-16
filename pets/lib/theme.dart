
import 'package:flutter/material.dart';


const Color kPrimary = Color(0xFF4F1F1F); 
const Color kSurface = Color(0xFF3A1414); 
const Color kScaffoldBg = Color(0xFF2B0E0E); 
const Color kButton = Color(0xFF8F5F66); 
const Color kButtonOn = Color(0xFFF5EAEA); 
const Color kAccent = Color(0xFFB98B92); 
const Color kInputFill = Color(0xFF402020); 
const Color kHint = Color(0xFFBFA7A7); 
const Color kOnBackground = Color(0xFFF8EFEF); 

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

  
  fontFamily: 'Roboto', 
  textTheme: TextTheme(
    displayLarge: TextStyle( 
      fontSize: 38,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: kOnBackground,
      height: 1.05,
    ),
    headlineSmall: TextStyle( 
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

  
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kButton,
    foregroundColor: kButtonOn,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  
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

  
  cardTheme: CardTheme(
    color: kSurface,
    elevation: 6,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  
  dividerColor: Colors.white12,
  iconTheme: IconThemeData(color: kOnBackground),
);