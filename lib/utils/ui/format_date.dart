import 'package:intl/intl.dart';

class FormatDate{

  String getFormatDate(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }
}