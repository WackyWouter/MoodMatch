import 'package:moodmatch/models/api_response.dart';

class StatusApiResponse extends ApiResponse {
  final int you;
  final int partner;

  StatusApiResponse({status, message, this.you, this.partner})
      : super(status: status, message: message);

  factory StatusApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return StatusApiResponse(
        status: apiResponse.status,
        message: apiResponse.message,
        you: json.containsKey('you') ? json['you'] : 0,
        partner: json.containsKey('partner') ? json['partner'] : 0);
  }
}
