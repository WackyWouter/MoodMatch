import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moodmatch/models/api_response.dart';
import 'package:moodmatch/models/history_api_response.dart';
import 'package:moodmatch/models/status_api_response.dart';
import 'package:moodmatch/models/match_api_response.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/user_api_response.dart';

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

  static Future<MatchApiResponse> changePartner(
      String partnerUuid, String matcherUuid, bool alreadyMatched) async {
    Map<String, dynamic> body = {
      'action': alreadyMatched ? 'changePartner' : 'createMatch',
      'partner_uuid': partnerUuid,
      'matcher_uuid': matcherUuid,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    MatchApiResponse matchResponse =
        MatchApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return matchResponse;
      } else {
        latestError = matchResponse.error;
        return null;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }

  static Future<UserApiResponse> newUser(String deviceId) async {
    Map<String, dynamic> body = {
      'action': 'newUser',
      'device_id': deviceId,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    UserApiResponse matchResponse =
        UserApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return matchResponse;
      } else {
        latestError = matchResponse.error;
        return null;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }

  static Future<bool> updateDeviceId(String deviceId) async {
    Map<String, dynamic> body = {
      'action': 'newUser',
      'device_id': deviceId,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    ApiResponse matchResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return true;
      } else {
        latestError = matchResponse.error;
        return false;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }

  static Future<bool> resetPartner(String matchUuid) async {
    Map<String, dynamic> body = {
      'action': 'resetPartner',
      'matcher_uuid': matchUuid,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    ApiResponse matchResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return true;
      } else {
        latestError = matchResponse.error;
        return false;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }

  static Future<bool> addNotification(
      String matchUuid, int matchId, int mood) async {
    Map<String, dynamic> body = {
      'action': 'addNotification',
      'matcher_uuid': matchUuid,
      'match_id': matchId,
      'mood': mood,
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    ApiResponse matchResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return true;
      } else {
        latestError = matchResponse.error;
        return false;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }

  static Future<HistoryApiResponse> getHistory(
      String matchUuid, int matchId) async {
    Map<String, dynamic> body = {
      'action': 'history',
      'matcher_uuid': matchUuid,
      'match_id': matchId
    };
    String jsonBody = json.encode(body);
    http.Response response =
        await http.post(kUrl, headers: headers, body: jsonBody);

    int statusCode = response.statusCode;
    HistoryApiResponse matchResponse =
        HistoryApiResponse.fromJson(jsonDecode(response.body));
    if (statusCode == 200) {
      if (matchResponse.status == 'ok') {
        return matchResponse;
      } else {
        latestError = matchResponse.error;
        return null;
      }
    } else {
      latestError = statusCode.toString() + ' ' + response.reasonPhrase;
      return null;
    }
  }
}
