class CustomersVisitorList {
  String? id;
  String? firstName;
  String? phone;
  String? addressLine1;
  String? addressLine2;
  String? zone;
  String? login;
  String? status;

  CustomersVisitorList(
      {this.id,
        this.firstName,
        this.phone,
        this.addressLine1,
        this.addressLine2,
        this.zone,
        this.login,
      this.status
      });

  CustomersVisitorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    phone = json['phone'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    zone = json['zone'];
    login = json['login'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['phone'] = this.phone;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['zone'] = this.zone;
    data['login'] = this.login;
    data['status'] = this.status;
    return data;
  }
}