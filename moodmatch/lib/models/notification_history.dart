import 'package:intl/intl.dart';

class NotificationHistory {
  final int id;
  final String user;
  final int mood;
  final String date;
  final String time;

  NotificationHistory(
      {this.id, this.user, this.mood, this.date, this.time = ''});

  factory NotificationHistory.fromJson(Map<String, dynamic> json) {
    return NotificationHistory(
        id: json['id'],
        user: json['user'],
        mood: json['mood'],
        date: DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(json['date'].toString())),
        time: DateFormat("HH:mm")
            .format(DateTime.parse(json['date'].toString())));
  }
}
