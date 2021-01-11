import 'package:moodmatch/models/api_response.dart';

class UserApiResponse extends ApiResponse {
  final String matcherUuid;

  UserApiResponse({status, message, this.matcherUuid})
      : super(status: status, message: message);

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return UserApiResponse(
        status: apiResponse.status,
        message: apiResponse.message,
        matcherUuid:
            json.containsKey('matcher_uuid') ? json['matcher_uuid'] : '');
  }
}
