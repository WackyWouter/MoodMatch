import 'package:moodmatch/models/api_response.dart';

class DeviceIdApiResponse extends ApiResponse {
  final String deviceId;

  DeviceIdApiResponse({status, error, this.deviceId})
      : super(status: status, error: error);

  factory DeviceIdApiResponse.fromJson(Map<String, dynamic> json) {
    final apiResponse = ApiResponse.fromJson(json);
    return DeviceIdApiResponse(
        status: apiResponse.status,
        error: apiResponse.error,
        deviceId: json.containsKey('device_id') ? json['device_id'] : '');
  }
}
