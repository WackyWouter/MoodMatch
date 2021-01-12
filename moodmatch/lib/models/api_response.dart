class ApiResponse {
  final String status;
  final String error;

  ApiResponse({this.status, this.error});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        status: json['status'],
        error: json.containsKey('error') ? json['error'] : null);
  }
}
