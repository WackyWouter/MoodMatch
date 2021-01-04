import 'package:moodmatch/models/notification_history.dart';

class NotificationHistoryList {
  List<NotificationHistory> notificationList;

  NotificationHistoryList({this.notificationList});

  NotificationHistoryList.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notificationList = new List<NotificationHistory>();
      json['notifications'].forEach((v) {
        notificationList.add(new NotificationHistory.fromJson(v));
      });
    }
  }
}
