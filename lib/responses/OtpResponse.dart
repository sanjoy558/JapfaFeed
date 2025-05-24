class OtpResponse {
  Data? data;
  String? message;
  bool? success;
  int? status;

  OtpResponse({this.data, this.message, this.success, this.status});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? otp;
  String? login;

  Data({this.otp, this.login});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['login'] = this.login;
    return data;
  }
}
