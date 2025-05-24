class LoginResponse {
  String? idToken;
  String? permission;

  LoginResponse({this.idToken, this.permission});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    idToken = json['id_token'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_token'] = this.idToken;
    data['permission'] = this.permission;
    return data;
  }
}
