class CustomerPoAcceptCancelResponse {
  Null? data;
  String? message;
  bool? success;
  int? status;
  Null? refNo;

  CustomerPoAcceptCancelResponse(
      {this.data, this.message, this.success, this.status, this.refNo});

  CustomerPoAcceptCancelResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    success = json['success'];
    status = json['status'];
    refNo = json['refNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    data['refNo'] = this.refNo;
    return data;
  }
}
