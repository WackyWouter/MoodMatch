import 'package:moodmatch/models/api_response.dart';
import 'package:moodmatch/models/notification_history.dart';

class HistoryApiResponse extends ApiResponse {
  List<NotificationHistory> notificationList;

  HistoryApiResponse({status, error, this.notificationList})
      : super(status: status, error: error);

  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);

    List<NotificationHistory> list;
    if (json['notifications'] != null) {
      list = new List<NotificationHistory>();
      json['notifications'].forEach((v) {
        list.add(new NotificationHistory.fromJson(v));
      });
    }
    return HistoryApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        notificationList: list);
  }
}
