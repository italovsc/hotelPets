
import 'package:intl/intl.dart';

String formatDateShort(DateTime date) {
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}


int daysBetween(DateTime start, DateTime end) {
  final s = DateTime(start.year, start.month, start.day);
  final e = DateTime(end.year, end.month, end.day);
  return e.difference(s).inDays;
}


int daysSince(DateTime start) {
  final today = DateTime.now();
  final s = DateTime(start.year, start.month, start.day);
  final diff = today.difference(s).inDays;
  return diff >= 0 ? diff : 0;
}