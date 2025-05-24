class TrackTargetStatusResponse {
  int? id;
  String? customerId;
  String? status;

  TrackTargetStatusResponse({this.id, this.customerId, this.status});

  TrackTargetStatusResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['status'] = this.status;
    return data;
  }
}
