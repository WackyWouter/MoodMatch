import 'package:moodmatch/models/api_response.dart';

class MatchApiResponse extends ApiResponse {
  final int matchId;

  MatchApiResponse({status, error, this.matchId})
      : super(status: status, error: error);

  factory MatchApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return MatchApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        matchId: json.containsKey('match') ? json['match'] : 0);
  }
}
