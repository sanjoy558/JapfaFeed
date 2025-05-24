class UserModel {
  String? userId = "";
  String? login = "";
  String? firstName = "";
  String? lastName = "";
  String? userimage = "";
  String? designation = "";
  String? usertype = "";
  String? zone = "";
  String? authority = "";
  String? IS_LOGIN_FIRST = "";
  String? tokenid = "";
  String? permission = "";
  String? executiveId = "";
  String? executivelogin = "";
  String? executivefirstName = "";
  String? executiveemail = "";
  String? divisionid = "";
  String? divisionname = "";

  UserModel(
      {this.userId,
      this.login,
      this.firstName,
      this.lastName,
      this.userimage,
      this.designation,
      this.usertype,
      this.zone,
      this.authority,
      this.IS_LOGIN_FIRST,
      this.tokenid,
      this.permission,
      this.executiveId,
      this.executivelogin,
      this.executivefirstName,
      this.executiveemail,
      this.divisionid,
      this.divisionname});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userimage = json['userimage'];
    designation = json['designation'];
    usertype = json['usertype'];
    zone = json['zone'];
    authority = json['authority'];
    IS_LOGIN_FIRST = json['IS_LOGIN_FIRST'];
    tokenid = json['tokenid'];
    permission = json['permission'];
    executiveId = json['executiveId'];
    executivelogin = json['executivelogin'];
    executivefirstName = json['executivefirstName'];
    executiveemail = json['executiveemail'];
    divisionid = json['divisionid'];
    divisionname = json['divisionname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['login'] = login;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userimage'] = userimage;
    data['designation'] = designation;
    data['usertype'] = usertype;
    data['zone'] = zone;
    data['authority'] = authority;
    data['IS_LOGIN_FIRST'] = IS_LOGIN_FIRST;
    data['tokenid'] = tokenid;
    data['permission'] = permission;
    data['executiveId'] = executiveId;
    data['executivelogin'] = executivelogin;
    data['executivefirstName'] = executivefirstName;
    data['executiveemail'] = executiveemail;
    data['divisionid'] = divisionid;
    data['divisionname'] = divisionname;
    return data;
  }
}
