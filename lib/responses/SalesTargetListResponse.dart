class SalesTargetListResponse {
  List<SalesTargetData>? data;
  String? message;
  bool? success;
  int? status;
  Null? refNo;

  SalesTargetListResponse(
      {this.data, this.message, this.success, this.status, this.refNo});

  SalesTargetListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalesTargetData>[];
      json['data'].forEach((v) {
        data!.add(new SalesTargetData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
    refNo = json['refNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    data['refNo'] = this.refNo;
    return data;
  }
}

class SalesTargetData {
  int? id;
  String? salesExecutiveLogin;
  String? salesExecutiveName;
  String? month;
  String? year;
  String? target;

  SalesTargetData(
      {this.id,
        this.salesExecutiveLogin,
        this.salesExecutiveName,
        this.month,
        this.year,
        this.target});

  SalesTargetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesExecutiveLogin = json['salesExecutiveLogin'];
    salesExecutiveName = json['salesExecutiveName'];
    month = json['month'];
    year = json['year'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesExecutiveLogin'] = this.salesExecutiveLogin;
    data['salesExecutiveName'] = this.salesExecutiveName;
    data['month'] = this.month;
    data['year'] = this.year;
    data['target'] = this.target;
    return data;
  }
}
