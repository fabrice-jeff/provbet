import 'package:intl/intl.dart';
//
// DateTime dateTimeFormat(String dateString) {
//   DateTime dateTime =
//       DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateString, true);
//   return dateTime.toLocal(); // Convertit en heure locale si nécessaire
// }


DateTime dateTimeFormat(String dateString) {
  DateTime dateTime =
  DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateString, true);
  return dateTime.toLocal();
}
