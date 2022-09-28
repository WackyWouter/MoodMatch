import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/fcm_response.dart';

class PushNotificationSend {
  static String latestError;

//  TODO make notifications always show even when app is closed
//  TODO make notification show up as banner when it first arrives on phone
  //TO do this i need to create a notification channel https://rechor.medium.com/creating-notification-channels-in-flutter-android-e81e26b33bec

  // Mood = 1 for horny, mood = 0 for not horny
  Future<FcmResponse> createNotification(
      int mood, String partnerDeviceId) async {
    Map<String, dynamic> body = {
      "to": partnerDeviceId,
      "collapse_key": "New Message",
      "priority": "high",
      "notification": {
        "title": kAppNameNotifications,
        "body": mood == 1 ? kPartnerMood : kPartnerNotMood,
      },
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "status": "done"}
    };
    Map<String, String> headers = {
      'Authorization': 'key=' + kServerKey,
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(
      kNotificationUrl,
      headers: headers,
      body: jsonEncode(body),
    );

    int statusCode = response.statusCode;
    FcmResponse fcmResponse = FcmResponse.fromJson(jsonDecode(response.body));

    if (statusCode == 200) {
      return fcmResponse;
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }
}
