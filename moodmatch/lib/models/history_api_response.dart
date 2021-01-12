import 'package:moodmatch/models/api_response.dart';
import 'package:moodmatch/models/notification_history_list.dart';

class HistoryApiResponse extends ApiResponse {
  final NotificationHistoryList notificationList;

  HistoryApiResponse({status, error, this.notificationList})
      : super(status: status, error: error);

  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return HistoryApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        notificationList: json.containsKey('notifications')
            ? NotificationHistoryList.fromJson(json['notifications'])
            : []);
  }
}
