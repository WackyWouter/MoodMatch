import 'package:moodmatch/models/api_response.dart';

class CheckMatchApiResponse extends ApiResponse {
  final int matchId;
  final bool matched;

  CheckMatchApiResponse({status, error, this.matchId, this.matched})
      : super(status: status, error: error);

  factory CheckMatchApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return CheckMatchApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        matched: json.containsKey('matched') ? json['matched'] : false,
        matchId: json.containsKey('match_id') ? json['match_id'] : 0);
  }
}
