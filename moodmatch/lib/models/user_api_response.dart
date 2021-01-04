import 'package:moodmatch/models/api_response.dart';

class UserApiResponse extends ApiResponse {
  final String matcherUuid;

  UserApiResponse({status, error, this.matcherUuid})
      : super(status: status, error: error);

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return UserApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        matcherUuid:
            json.containsKey('matcher_uuid') ? json['matcher_uuid'] : '');
  }
}
