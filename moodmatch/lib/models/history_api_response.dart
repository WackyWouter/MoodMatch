import 'package:moodmatch/models/api_response.dart';
import 'package:moodmatch/models/notification_history_list.dart';

class HistoryApiResponse extends ApiResponse {
  final NotificationHistoryList notificationList;

  HistoryApiResponse({status, message, this.notificationList})
      : super(status: status, message: message);

  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return HistoryApiResponse(
        status: apiResponse.status,
        message: apiResponse.message,
        notificationList: json.containsKey('notifications')
            ? NotificationHistoryList.fromJson(json['notifications'])
            : []);
  }
}
