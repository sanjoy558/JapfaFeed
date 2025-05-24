class CustomerCummulativeDataResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  CustomerCummulativeDataResponse(
      {this.data, this.message, this.success, this.status});

  CustomerCummulativeDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? login;
  String? name;
  int? month;
  int? year;
  double? actual;
  double? target;

  Data(
      {this.id,
        this.login,
        this.name,
        this.month,
        this.year,
        this.actual,
        this.target});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    month = json['month'];
    year = json['year'];
    actual = json['actual'];
    target = json['target'];

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
    return data;
  }
}
