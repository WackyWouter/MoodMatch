import 'package:moodmatch/models/api_response.dart';

class MatchApiResponse extends ApiResponse {
  final int matchId;

  MatchApiResponse({status, message, this.matchId})
      : super(status: status, message: message);

  factory MatchApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return MatchApiResponse(
        status: apiResponse.status,
        message: apiResponse.message,
        matchId: json.containsKey('match') ? json['match'] : 0);
  }
}
