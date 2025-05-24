class UserDetailsResponse {
  int? id;
  String? login;
  String? firstName;
  String? email;
  bool? activated;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? type;

  String? designation;
  String? designation2;
  String? designation3;
  List<String>? authorities;
  String? phone;
  String? zone;
  String? deviceid;

  UserDetailsResponse(
      {this.id,
        this.login,
        this.firstName,
        this.email,
        this.activated,
        this.createdBy,
        this.createdDate,
        this.lastModifiedBy,
        this.lastModifiedDate,
        this.type,
        this.designation,
        this.designation2,
        this.designation3,
        this.authorities,
        this.phone,
        this.zone,
        this.deviceid
      });

  UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    email = json['email']==null?"na":json['email'];
    activated = json['activated'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    type = json['type'];
    designation = json['designation']==null?"na":json['designation'];
    designation2 = json['designation2']==null?"na":json['designation2'];
    designation3 = json['designation3']==null?"na":json['designation3'];
    authorities = json['authorities'].cast<String>();
    phone = json['phone']==null?"na":json['phone'];
    zone = json['zone'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['activated'] = this.activated;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['type'] = this.type;
    data['designation'] = this.designation;
    data['designation2'] = this.designation2;
    data['designation3'] = this.designation3;
    data['authorities'] = this.authorities;
    data['phone'] = this.phone;
    data['zone'] = this.zone;
    data['deviceid'] = this.deviceid;
    return data;
  }
}
