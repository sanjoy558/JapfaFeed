import 'dart:convert';

List<CustomerListResponse> customerListResponseFromJson(String str) => List<CustomerListResponse>.from(json.decode(str).map((x) => CustomerListResponse.fromJson(x)));

String customerListResponseToJson(List<CustomerListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerListResponse {
  int? id;
  String? firstName;
  String? phone;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? pin;
  String? email;
  String? zone;
  String? login;

  CustomerListResponse(
      {this.id,
        this.firstName,
        this.phone,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.pin,
        this.email,
        this.zone,
        this.login
      });

  CustomerListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    phone = json['phone'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    pin = json['pin'];
    email = json['email'];
    zone = json['zone'];
    login = json['login'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['phone'] = this.phone;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['city'] = this.city;
    data['pin'] = this.pin;
    data['email'] = this.email;
    data['zone'] = this.zone;
    data['login'] = this.login;
    return data;
  }
}

