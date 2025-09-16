

import 'package:flutter/material.dart';


class AppRoutes {
  AppRoutes._(); 

  static const String home = '/';
  static const String petList = '/pets';
  static const String petForm = '/pet_form';
}


class AppNavigator {
  AppNavigator._();

  static Future<T?> pushToHome<T>(BuildContext context) {
    return Navigator.pushNamed<T>(context, AppRoutes.home);
  }

  static Future<T?> pushToPetList<T>(BuildContext context) {
    return Navigator.pushNamed<T>(context, AppRoutes.petList);
  }

  
  static Future<T?> pushToPetForm<T>(BuildContext context, {Object? pet}) {
    return Navigator.pushNamed<T>(
      context,
      AppRoutes.petForm,
      arguments: pet,
    );
  }
}