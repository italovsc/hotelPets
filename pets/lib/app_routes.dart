// lib/app_routes.dart

import 'package:flutter/material.dart';

/// Nomes das rotas usadas pela aplicação.
/// Use: Navigator.pushNamed(context, AppRoutes.petForm, arguments: pet);
class AppRoutes {
  AppRoutes._(); // evita instanciação

  static const String home = '/';
  static const String petList = '/pets';
  static const String petForm = '/pet_form';
}

/// Helper simples para navegação com argumentos tipados (opcional).
/// Exemplo:
///   AppNavigator.pushToPetForm(context, pet);
class AppNavigator {
  AppNavigator._();

  static Future<T?> pushToHome<T>(BuildContext context) {
    return Navigator.pushNamed<T>(context, AppRoutes.home);
  }

  static Future<T?> pushToPetList<T>(BuildContext context) {
    return Navigator.pushNamed<T>(context, AppRoutes.petList);
  }

  /// Se passar [pet] como argumento, a tela de formulário deve entender que é edição.
  static Future<T?> pushToPetForm<T>(BuildContext context, {Object? pet}) {
    return Navigator.pushNamed<T>(
      context,
      AppRoutes.petForm,
      arguments: pet,
    );
  }
}
