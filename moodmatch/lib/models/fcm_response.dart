import 'package:moodmatch/models/fcm_results.dart';

class FcmResponse {
  int multicastId;
  int success;
  int failure;
  int canonicalIds;
  List<Results> results;

  FcmResponse(
      {this.multicastId,
      this.success,
      this.failure,
      this.canonicalIds,
      this.results});

  FcmResponse.fromJson(Map<String, dynamic> json) {
    multicastId = json['multicast_id'];
    success = json['success'];
    failure = json['failure'];
    canonicalIds = json['canonical_ids'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['multicast_id'] = this.multicastId;
    data['success'] = this.success;
    data['failure'] = this.failure;
    data['canonical_ids'] = this.canonicalIds;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
