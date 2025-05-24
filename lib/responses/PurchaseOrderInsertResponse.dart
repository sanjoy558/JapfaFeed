class PurchaseOrderInsertResponse {
  List<String>? success;
  List<String>? failed;

  PurchaseOrderInsertResponse({this.success, this.failed});

  PurchaseOrderInsertResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].cast<String>();
    failed = json['failed'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['failed'] = this.failed;
    return data;
  }
}
