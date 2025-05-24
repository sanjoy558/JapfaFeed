class DailyPlanVisitedListResponse {
  int? id;
  String? customerId;
  String? status;

  DailyPlanVisitedListResponse({this.id, this.customerId, this.status});

  DailyPlanVisitedListResponse.fromJson(Map<String, dynamic> json) {
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
