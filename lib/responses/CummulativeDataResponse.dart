class CummulativeDataResponse {
  List<CummulativeDataModel>? data;
  String? message;
  bool? success;
  int? status;
  Null? refNo;

  CummulativeDataResponse(
      {this.data, this.message, this.success, this.status, this.refNo});

  CummulativeDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CummulativeDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CummulativeDataModel.fromJson(v));
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

class CummulativeDataModel {
  int? id;
  String? login;
  String? name;
  int? month;
  int? year;
  double? actual;
  double? target;
  double? diff;
  String? type;
  String? totalCustomer;

  CummulativeDataModel(
      {this.id,
        this.login,
        this.name,
        this.month,
        this.year,
        this.actual,
        this.target,
        this.diff,
        this.type,
        this.totalCustomer
      });

  CummulativeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    month = json['month'];
    year = json['year'];
    actual = json['actual'];
    target = json['target'];
    diff = json['diff'];
    type = json['type'];
    totalCustomer = json['totalCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['name'] = this.name;
    data['month'] = this.month;
    data['year'] = this.year;
    data['actual'] = this.actual;
    data['target'] = this.target;
    data['diff'] = this.diff;
    data['type'] = this.type;
    data['totalCustomer'] = this.totalCustomer;
    return data;
  }
}
