import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
