import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moodmatch/models/status_api_response.dart';
import 'package:moodmatch/constant.dart';

class Api {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  static String latestError;

  static Future<StatusApiResponse> getStatus(
      int matchId, String matcherUuid) async {
    Map<String, dynamic> body = {
      'action': 'currentStatus',
      'match_id': matchId,
      'matcher_uuid': matcherUuid,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    StatusApiResponse statusResponse =
        StatusApiResponse.fromJson(jsonDecode(response.body));

    if (statusCode == 200) {
      if (statusResponse.status == 'ok') {
        return statusResponse;
      } else {
        latestError = statusResponse.error;
        return null;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }
}