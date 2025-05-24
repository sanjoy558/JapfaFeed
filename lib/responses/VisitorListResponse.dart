class VisitorListResponse {
  String? createdDate;
  int? id;
  String? login;
  String? firstName;
  Null? lastName;
  String? phone;
  String? email;

  VisitorListResponse(
      {this.createdDate,
        this.id,
        this.login,
        this.firstName,
        this.lastName,
        this.phone,
        this.email
      });

  VisitorListResponse.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['id'] = this.id;
    data['login'] = this.login;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
