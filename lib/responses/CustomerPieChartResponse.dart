class CustomerPieChartResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;
  Null? refNo;

  CustomerPieChartResponse(
      {this.data, this.message, this.success, this.status, this.refNo});

  CustomerPieChartResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? customerId;
  int? execId;
  double? totalTarget;
  double? achieveTarget;
  double? pendingTarget;
  int? month;
  int? year;

  Data(
      {this.id,
        this.customerId,
        this.execId,
        this.totalTarget,
        this.achieveTarget,
        this.pendingTarget,
        this.month,
        this.year});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    execId = json['execId'];
    totalTarget = json['totalTarget'];
    achieveTarget = json['achieveTarget'];
    pendingTarget = json['pendingTarget'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['execId'] = this.execId;
    data['totalTarget'] = this.totalTarget;
    data['achieveTarget'] = this.achieveTarget;
    data['pendingTarget'] = this.pendingTarget;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}
