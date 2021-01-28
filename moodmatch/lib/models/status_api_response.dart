import 'package:moodmatch/models/api_response.dart';

class StatusApiResponse extends ApiResponse {
  final int you;
  final int partner;

  StatusApiResponse({status, error, this.you, this.partner})
      : super(status: status, error: error);

  factory StatusApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return StatusApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        you: json.containsKey('you') ? json['you'] : 2,
        partner: json.containsKey('partner') ? json['partner'] : 2);
  }
}
