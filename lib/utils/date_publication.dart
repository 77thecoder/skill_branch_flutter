import 'package:intl/intl.dart';

class DatePublicaton {
  static String datePublicationToString(DateTime createdAt) {
    final DateTime currentDate = new DateTime.now();
    Duration d = currentDate.difference(createdAt);
    String publication = '';

    if (d.inHours < 1) {
      publication = 'менее часа назад';
    } else if (d.inDays >= 1 || (d.inDays == 0 && currentDate.day > createdAt.day)) {
      var newFormat = DateFormat('dd MMM yyyy');
      publication = newFormat.format(createdAt);
    } else {
      publication = 'сегодня';
    }

    return publication;
  }
}
