class FeedBackFlagResponse {
  Null? data;
  String? message;
  bool? success;
  int? status;

  FeedBackFlagResponse(
      {this.data, this.message, this.success, this.status});

  FeedBackFlagResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}
