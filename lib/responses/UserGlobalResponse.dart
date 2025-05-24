class UserGlobalResponse {
  UserAppData? data;
  String? message;
  bool? success;
  int? status;
  Null? refNo;

  UserGlobalResponse(
      {this.data, this.message, this.success, this.status, this.refNo});

  UserGlobalResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserAppData.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
    refNo = json['refNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    data['refNo'] = this.refNo;
    return data;
  }
}

class UserAppData {
  String? lock;
  String? version;

  UserAppData({this.lock, this.version});

  UserAppData.fromJson(Map<String, dynamic> json) {
    lock = json['lock'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lock'] = this.lock;
    data['version'] = this.version;
    return data;
  }
}


/*
{
"data": {
"lock": "false",
"version": "1.0"
},
"message": "Success",
"success": true,
"status": 200,
"refNo": null
}*/
