class CustomerDataResponse {
  int? id;
  String? login;
  String? firstName;
  String? zone;
  String? email;
  String? phone;
  String? salesExecutiveCode;
  SalesExecutive? salesExecutive;
  CustomerDataResponse(
      {this.id,
        this.firstName,
        this.phone,
        this.zone,
        this.email,
        this.login,this.salesExecutiveCode,this.salesExecutive});

  CustomerDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    phone = json['phone'];
    zone = json['zone'];
    email = json['email'];
    salesExecutiveCode = json['salesExecutiveCode'];
    login = json['login'];
    salesExecutive = json['salesExecutive'] != null
        ? new SalesExecutive.fromJson(json['salesExecutive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['phone'] = this.phone;
    data['zone'] = this.zone;
    data['email'] = this.email;
    data['salesExecutiveCode'] = this.salesExecutiveCode;
    data['login'] = this.login;
    if (this.salesExecutive != null) {
      data['salesExecutive'] = this.salesExecutive!.toJson();
    }
    return data;
  }
}

class SalesExecutive {

  int? id;
  String? login;
  String? firstName;
  String? email;



  SalesExecutive(
      {
        this.id,
        this.login,
        this.firstName,
        this.email});

  SalesExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    return data;
  }
}
