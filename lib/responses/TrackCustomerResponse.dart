class TrackCustomerResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  TrackCustomerResponse(
      {this.data, this.message, this.success, this.status});

  TrackCustomerResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? customerLogin;
  String? customerName;
  String? salesExecutiveLogin;
  String? salesExecutiveName;
  String? newCustomer;
  String? billedCustomer;
  String? unbilledCustomer;
  String? activeCustomer;
  String? lostCustomer;
  String? nopCustomer;
  String? createdOn;

  String? salesExecutiveCode;
  String? zbillCust;
  String? znewCust;
  String? zunBill;

  String? zactCust1;
  String? znopCust1;

  Data(
      {this.id,
        this.customerLogin,
        this.customerName,
        this.salesExecutiveLogin,
        this.salesExecutiveName,
        this.newCustomer,
        this.billedCustomer,
        this.unbilledCustomer,
        this.activeCustomer,
        this.lostCustomer,
        this.nopCustomer,
        this.createdOn,
        this.salesExecutiveCode,
        this.znewCust,
        this.zbillCust,
        this.zunBill,
        this.zactCust1,
        this.znopCust1

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerLogin = json['customerLogin'];
    customerName = json['customerName'];
    salesExecutiveLogin = json['salesExecutiveLogin'];
    salesExecutiveName = json['salesExecutiveName'];
    newCustomer = json['newCustomer'];
    billedCustomer = json['billedCustomer'];
    unbilledCustomer = json['unbilledCustomer'];
    activeCustomer = json['activeCustomer'];
    lostCustomer = json['lostCustomer'];
    nopCustomer = json['nopCustomer'];
    createdOn = json['createdOn'];

    salesExecutiveCode = json['salesExecutiveCode'];
    znewCust = json['znewCust'].toString();
    zbillCust = json['zbillCust'].toString();
    zunBill = json['zunBill'].toString();
    zactCust1 = json['zactCust1'].toString();
    znopCust1 = json['znopCust1'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerLogin'] = this.customerLogin;
    data['customerName'] = this.customerName;
    data['salesExecutiveLogin'] = this.salesExecutiveLogin;
    data['salesExecutiveName'] = this.salesExecutiveName;
    data['newCustomer'] = this.newCustomer;
    data['billedCustomer'] = this.billedCustomer;
    data['unbilledCustomer'] = this.unbilledCustomer;
    data['activeCustomer'] = this.activeCustomer;
    data['lostCustomer'] = this.lostCustomer;
    data['nopCustomer'] = this.nopCustomer;
    data['createdOn'] = this.createdOn;

    data['salesExecutiveCode'] = this.salesExecutiveCode;
    data['znewCust'] = this.znewCust;
    data['zbillCust'] = this.zbillCust;
    data['zunBill'] = this.zunBill;
    data['zactCust1'] = this.zactCust1;
    data['znopCust1'] = this.znopCust1;
    return data;
  }
}
