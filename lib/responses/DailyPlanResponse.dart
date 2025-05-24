class DailyPlanResponse {
  int? id;
  String? name;
  String? fromDate;
  String? toDate;
  String? createdOn;
  String? updatedOn;
  String? remark;
  List<DailyPlanCustomers>? customers;

  DailyPlanResponse(
      {this.id,
        this.name,
        this.fromDate,
        this.toDate,
        this.createdOn,
        this.updatedOn,
        this.remark,
        this.customers});

  DailyPlanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    remark = json['remark'];
    if (json['customers'] != null) {
      customers = <DailyPlanCustomers>[];
      json['customers'].forEach((v) {
        customers!.add(new DailyPlanCustomers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['remark'] = this.remark;
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyPlanCustomers {
  int? id;
  String? firstName;
  String? phone;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? pin;
  String? zone;
  String? email;
  String? state;
  String? district;
  String? salesDist;
  String? salesOffice;
  String? salesExecutiveName;
  String? salesExecutiveCode;
  String? salesCoordinatorName;
  String? salesCoordinatorCode;
  String? technicalSupportName;
  String? technicalSupportCode;
  String? salesManagerName;
  String? salesManagerCode;
  String? zonalManagerName;
  String? zonalManagerCode;
  String? nationalManagerName;
  String? nationalManagerCode;
  String? divisionalManagerName;
  String? divisionalManagerCode;
  String? login;
  String? status="Pending";

  DailyPlanCustomers(
      {this.id,
        this.firstName,
        this.phone,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.pin,
        this.zone,
        this.email,
        this.state,
        this.district,
        this.salesDist,
        this.salesOffice,
        this.salesExecutiveName,
        this.salesExecutiveCode,
        this.salesCoordinatorName,
        this.salesCoordinatorCode,
        this.technicalSupportName,
        this.technicalSupportCode,
        this.salesManagerName,
        this.salesManagerCode,
        this.zonalManagerName,
        this.zonalManagerCode,
        this.nationalManagerName,
        this.nationalManagerCode,
        this.divisionalManagerName,
        this.divisionalManagerCode,
        this.login});

  DailyPlanCustomers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    phone = json['phone'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    pin = json['pin'];
    zone = json['zone'];
    email = json['email'];
    state = json['state'];
    district = json['district'];
    salesDist = json['salesDist'];
    salesOffice = json['salesOffice'];
    salesExecutiveName = json['salesExecutiveName'];
    salesExecutiveCode = json['salesExecutiveCode'];
    salesCoordinatorName = json['salesCoordinatorName'];
    salesCoordinatorCode = json['salesCoordinatorCode'];
    technicalSupportName = json['technicalSupportName'];
    technicalSupportCode = json['technicalSupportCode'];
    salesManagerName = json['salesManagerName'];
    salesManagerCode = json['salesManagerCode'];
    zonalManagerName = json['zonalManagerName'];
    zonalManagerCode = json['zonalManagerCode'];
    nationalManagerName = json['nationalManagerName'];
    nationalManagerCode = json['nationalManagerCode'];
    divisionalManagerName = json['divisionalManagerName'];
    divisionalManagerCode = json['divisionalManagerCode'];

    login = json['login'];
    status = "Pending";
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
    data['zone'] = this.zone;
    data['email'] = this.email;
    data['state'] = this.state;
    data['district'] = this.district;
    data['salesDist'] = this.salesDist;
    data['salesOffice'] = this.salesOffice;
    data['salesExecutiveName'] = this.salesExecutiveName;
    data['salesExecutiveCode'] = this.salesExecutiveCode;
    data['salesCoordinatorName'] = this.salesCoordinatorName;
    data['salesCoordinatorCode'] = this.salesCoordinatorCode;
    data['technicalSupportName'] = this.technicalSupportName;
    data['technicalSupportCode'] = this.technicalSupportCode;
    data['salesManagerName'] = this.salesManagerName;
    data['salesManagerCode'] = this.salesManagerCode;
    data['zonalManagerName'] = this.zonalManagerName;
    data['zonalManagerCode'] = this.zonalManagerCode;
    data['nationalManagerName'] = this.nationalManagerName;
    data['nationalManagerCode'] = this.nationalManagerCode;
    data['divisionalManagerName'] = this.divisionalManagerName;
    data['divisionalManagerCode'] = this.divisionalManagerCode;

    data['login'] = this.login;
    data['status'] = this.status;
    return data;
  }
}

