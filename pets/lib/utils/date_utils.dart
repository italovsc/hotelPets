// lib/utils/date_utils.dart
import 'package:intl/intl.dart';

String formatDateShort(DateTime date) {
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

/// Retorna a quantidade de dias entre start e end como inteiro (end - start).
/// Usa apenas as partes de data (ano, mês, dia) para evitar problemas com horas.
int daysBetween(DateTime start, DateTime end) {
  final s = DateTime(start.year, start.month, start.day);
  final e = DateTime(end.year, end.month, end.day);
  return e.difference(s).inDays;
}

/// Retorna quantos dias se passaram desde a data passada até hoje (>=0).
int daysSince(DateTime start) {
  final today = DateTime.now();
  final s = DateTime(start.year, start.month, start.day);
  final diff = today.difference(s).inDays;
  return diff >= 0 ? diff : 0;
}
