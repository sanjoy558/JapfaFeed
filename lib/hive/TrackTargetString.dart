

class TrackTargetString {
  String? customerId;
  int? id;
  String? status;

  TrackTargetString(
      {required this.customerId, required this.id, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'id': id,
      'status': status};
  }

  factory TrackTargetString.fromJson(Map<String, dynamic> map) {
    return TrackTargetString(
        customerId: map['customerId'],
        id: map['id'],
        status: map['status']);
  }
}
