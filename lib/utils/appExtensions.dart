import 'package:intl/intl.dart';

extension StringExtensions on String {

  DateTime getDate() => DateTime.parse(this);

}

extension DateExtensions on DateTime {
  String getDMYDate() => DateFormat('d-m-Y').format(this);
}