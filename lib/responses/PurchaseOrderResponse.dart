class PurchaseOrderResponse {
  int? id;
  String? transportArrangeBy;
  String? plant;
  String? sapId;
  List<Items>? items;
  String? paymentMethod;
  String? paymentRemark;
  String? createdOn;
  String? modifiedOn;
  String? status;
  String? zone;
  String? orderUUID;
  String? type;
  Customer? customer;
  SalesExecutive? exec;

  PurchaseOrderResponse(
      {this.id,
      this.transportArrangeBy,
      this.plant,
      this.sapId,
      this.items,
      this.paymentMethod,
      this.paymentRemark,
      this.createdOn,
      this.modifiedOn,
      this.status,
      this.zone,
      this.type,
      this.orderUUID,
      this.customer});

  PurchaseOrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transportArrangeBy = json['transportArrangeBy'];
    plant = json['plant'];
    sapId = json['sapId'];
    paymentMethod = json['paymentMethod'];
    paymentRemark = json['paymentRemark'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    status = json['status'];
    zone = json['zone'];
    type = json['type'];
    orderUUID = json['orderUUID'];

    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;

    exec = json['exec'] != null
        ? new SalesExecutive.fromJson(json['exec'])
        : null;

    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transportArrangeBy'] = this.transportArrangeBy;
    data['plant'] = this.plant;
    data['paymentRemark'] = this.paymentRemark;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['status'] = this.status;
    data['zone'] = this.zone;

    data['type'] = this.type;
    data['orderUUID'] = this.orderUUID;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.exec != null) {
      data['exec'] = this.exec!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? phone;
  String? addressLine1;
  String? addressLine2;

  Customer(
      {this.id,
      this.firstName,
      this.phone,
      this.addressLine1,
      this.addressLine2});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    phone = json['phone'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    /*data['lastName'] = this.lastName;*/
    data['phone'] = this.phone;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    return data;
  }
}

class SalesExecutive {
  String? firstName;

  SalesExecutive({this.firstName});

  SalesExecutive.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    return data;
  }
}

class TechnicalSupport {
  String? createdDate;
  int? id;
  String? login;
  String? firstName;
  Null? lastName;
  String? email;
  bool? activated;
  String? resetDate;
  String? designation;
  String? designation2;
  String? zone;
  String? type;
  Null? reportingTo;
  String? salesDist;
  String? salesOffice;
  String? salesManagerZpCd;
  String? rgnlNamagerZrCd;
  String? nSaleManagerZnCd;
  String? divHeadZhCd;
  String? designation3;
  Null? reportingToName;
  String? phone;

  TechnicalSupport(
      {this.createdDate,
      this.id,
      this.login,
      this.firstName,
      this.lastName,
      this.email,
      this.activated,
      this.resetDate,
      this.designation,
      this.designation2,
      this.zone,
      this.type,
      this.reportingTo,
      this.salesDist,
      this.salesOffice,
      this.salesManagerZpCd,
      this.rgnlNamagerZrCd,
      this.nSaleManagerZnCd,
      this.divHeadZhCd,
      this.designation3,
      this.reportingToName,
      this.phone});

  TechnicalSupport.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    activated = json['activated'];
    resetDate = json['resetDate'];
    designation = json['designation'];
    designation2 = json['designation2'];
    zone = json['zone'];
    type = json['type'];
    reportingTo = json['reportingTo'];
    salesDist = json['salesDist'];
    salesOffice = json['salesOffice'];
    salesManagerZpCd = json['salesManagerZpCd'];
    rgnlNamagerZrCd = json['rgnlNamagerZrCd'];
    nSaleManagerZnCd = json['nSaleManagerZnCd'];
    divHeadZhCd = json['divHeadZhCd'];
    designation3 = json['designation3'];
    reportingToName = json['reportingToName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['id'] = this.id;
    data['login'] = this.login;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['activated'] = this.activated;
    data['resetDate'] = this.resetDate;
    data['designation'] = this.designation;
    data['designation2'] = this.designation2;
    data['zone'] = this.zone;
    data['type'] = this.type;
    data['reportingTo'] = this.reportingTo;
    data['salesDist'] = this.salesDist;
    data['salesOffice'] = this.salesOffice;
    data['salesManagerZpCd'] = this.salesManagerZpCd;
    data['rgnlNamagerZrCd'] = this.rgnlNamagerZrCd;
    data['nSaleManagerZnCd'] = this.nSaleManagerZnCd;
    data['divHeadZhCd'] = this.divHeadZhCd;
    data['designation3'] = this.designation3;
    data['reportingToName'] = this.reportingToName;
    data['phone'] = this.phone;
    return data;
  }
}

class User {
  Null? createdDate;
  int? id;
  String? login;
  String? firstName;
  String? lastName;
  String? email;
  bool? activated;
  String? resetDate;
  String? designation;
  String? designation2;
  String? zone;
  String? type;
  String? reportingTo;
  String? salesDist;
  String? salesOffice;
  String? salesManagerZpCd;
  String? rgnlNamagerZrCd;
  String? nSaleManagerZnCd;
  String? divHeadZhCd;
  String? designation3;
  String? reportingToName;
  String? phone;

  User(
      {this.createdDate,
      this.id,
      this.login,
      this.firstName,
      this.lastName,
      this.email,
      this.activated,
      this.resetDate,
      this.designation,
      this.designation2,
      this.zone,
      this.type,
      this.reportingTo,
      this.salesDist,
      this.salesOffice,
      this.salesManagerZpCd,
      this.rgnlNamagerZrCd,
      this.nSaleManagerZnCd,
      this.divHeadZhCd,
      this.designation3,
      this.reportingToName,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    activated = json['activated'];
    resetDate = json['resetDate'];
    designation = json['designation'];
    designation2 = json['designation2'];
    zone = json['zone'];
    type = json['type'];
    reportingTo = json['reportingTo'];
    salesDist = json['salesDist'];
    salesOffice = json['salesOffice'];
    salesManagerZpCd = json['salesManagerZpCd'];
    rgnlNamagerZrCd = json['rgnlNamagerZrCd'];
    nSaleManagerZnCd = json['nSaleManagerZnCd'];
    divHeadZhCd = json['divHeadZhCd'];
    designation3 = json['designation3'];
    reportingToName = json['reportingToName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['id'] = this.id;
    data['login'] = this.login;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['activated'] = this.activated;
    data['resetDate'] = this.resetDate;
    data['designation'] = this.designation;
    data['designation2'] = this.designation2;
    data['zone'] = this.zone;
    data['type'] = this.type;
    data['reportingTo'] = this.reportingTo;
    data['salesDist'] = this.salesDist;
    data['salesOffice'] = this.salesOffice;
    data['salesManagerZpCd'] = this.salesManagerZpCd;
    data['rgnlNamagerZrCd'] = this.rgnlNamagerZrCd;
    data['nSaleManagerZnCd'] = this.nSaleManagerZnCd;
    data['divHeadZhCd'] = this.divHeadZhCd;
    data['designation3'] = this.designation3;
    data['reportingToName'] = this.reportingToName;
    data['phone'] = this.phone;
    return data;
  }
}

class Items {
  int? id;
  String? headerId;
  String? brand;
  double? totalQuantity;
  int? noOfBags;
  String? price;
  String? modifiedOn;
  String? bird;
  String? stage;
  double? packageingWeight;
  String? material;
  String? remark;
  String? unitPrice;
  String? status;
  String? zone;
  String? productId;

  Items(
      {this.id,
      this.headerId,
      this.brand,
      this.totalQuantity,
      this.noOfBags,
      this.price,
      this.modifiedOn,
      this.bird,
      this.stage,
      this.packageingWeight,
      this.material,
      this.remark,
      this.unitPrice,
      this.status,
      this.zone,
      this.productId});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headerId = json['headerId'];
    brand = json['brand'];
    totalQuantity = json['totalQuantity'] == null ? 0.0 : json['totalQuantity'];
    noOfBags = json['noOfBags'];
    price = json['price'] ?? "";
    modifiedOn = json['modifiedOn'];
    bird = json['bird'];
    stage = json['stage'];
    packageingWeight =
        json['packageingWeight'] == null ? 0.0 : json['packageingWeight'];
    material = json['material'];
    remark = json['remark'];
    unitPrice = json['unitPrice'];
    status = json['status'];
    zone = json['zone'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headerId'] = this.headerId;
    data['brand'] = this.brand;
    data['totalQuantity'] = this.totalQuantity;
    data['noOfBags'] = this.noOfBags;
    data['price'] = this.price;
    data['modifiedOn'] = this.modifiedOn;
    data['bird'] = this.bird;
    data['stage'] = this.stage;
    data['packageingWeight'] = this.packageingWeight;
    data['material'] = this.material;
    data['remark'] = this.remark;
    data['unitPrice'] = this.unitPrice;
    data['status'] = this.status;
    data['zone'] = this.zone;
    data['productId'] = this.productId;
    return data;
  }
}
