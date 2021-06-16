import 'package:intl/intl.dart';

dateFormat(DateTime date) {
  return DateFormat("dd-MM-yyyy HH:mm:ss").format(date);
}
