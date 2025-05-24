// To parse this JSON data, do
//
//     final customerListResponse = customerListResponseFromJson(jsonString);

import 'dart:convert';

List<CustomerListResponse> customerListResponseFromJson(String str) => List<CustomerListResponse>.from(json.decode(str).map((x) => CustomerListResponse.fromJson(x)));

String customerListResponseToJson(List<CustomerListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerListResponse {
  int id;
  String firstName;
  dynamic lastName;
  String phone;
  String addressLine1;
  String addressLine2;
  String city;
  String pin;
  Zone zone;
  String email;
  dynamic division;
  State state;
  String district;
  String salesDist;
  SalesOffice salesOffice;
  SalesExecutiveName salesExecutiveName;
  String salesExecutiveCode;
  Name salesCoordinatorName;
  DivisionalManagerCode salesCoordinatorCode;
  Name technicalSupportName;
  DivisionalManagerCode technicalSupportCode;
  Name salesManagerName;
  DivisionalManagerCode salesManagerCode;
  Name zonalManagerName;
  DivisionalManagerCode zonalManagerCode;
  Name nationalManagerName;
  DivisionalManagerCode nationalManagerCode;
  Name divisionalManagerName;
  DivisionalManagerCode divisionalManagerCode;
  SalesExecutive salesExecutive;
  SalesExecutive? salesCoordinator;
  SalesExecutive? technicalSupport;
  SalesExecutive user;
  String login;
  dynamic coordinate;

  CustomerListResponse({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.pin,
    required this.zone,
    required this.email,
    this.division,
    required this.state,
    required this.district,
    required this.salesDist,
    required this.salesOffice,
    required this.salesExecutiveName,
    required this.salesExecutiveCode,
    required this.salesCoordinatorName,
    required this.salesCoordinatorCode,
    required this.technicalSupportName,
    required this.technicalSupportCode,
    required this.salesManagerName,
    required this.salesManagerCode,
    required this.zonalManagerName,
    required this.zonalManagerCode,
    required this.nationalManagerName,
    required this.nationalManagerCode,
    required this.divisionalManagerName,
    required this.divisionalManagerCode,
    required this.salesExecutive,
    this.salesCoordinator,
    this.technicalSupport,
    required this.user,
    required this.login,
    this.coordinate,
  });

  factory CustomerListResponse.fromJson(Map<String, dynamic> json) => CustomerListResponse(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    pin: json["pin"],
    zone: zoneValues.map[json["zone"]]!,
    email: json["email"],
    division: json["division"],
    state: stateValues.map[json["state"]]!,
    district: json["district"],
    salesDist: json["salesDist"],
    salesOffice: salesOfficeValues.map[json["salesOffice"]]!,
    salesExecutiveName: salesExecutiveNameValues.map[json["salesExecutiveName"]]!,
    salesExecutiveCode: json["salesExecutiveCode"],
    salesCoordinatorName: nameValues.map[json["salesCoordinatorName"]]!,
    salesCoordinatorCode: divisionalManagerCodeValues.map[json["salesCoordinatorCode"]]!,
    technicalSupportName: nameValues.map[json["technicalSupportName"]]!,
    technicalSupportCode: divisionalManagerCodeValues.map[json["technicalSupportCode"]]!,
    salesManagerName: nameValues.map[json["salesManagerName"]]!,
    salesManagerCode: divisionalManagerCodeValues.map[json["salesManagerCode"]]!,
    zonalManagerName: nameValues.map[json["zonalManagerName"]]!,
    zonalManagerCode: divisionalManagerCodeValues.map[json["zonalManagerCode"]]!,
    nationalManagerName: nameValues.map[json["nationalManagerName"]]!,
    nationalManagerCode: divisionalManagerCodeValues.map[json["nationalManagerCode"]]!,
    divisionalManagerName: nameValues.map[json["divisionalManagerName"]]!,
    divisionalManagerCode: divisionalManagerCodeValues.map[json["divisionalManagerCode"]]!,
    salesExecutive: SalesExecutive.fromJson(json["salesExecutive"]),
    salesCoordinator: json["salesCoordinator"] == null ? null : SalesExecutive.fromJson(json["salesCoordinator"]),
    technicalSupport: json["technicalSupport"] == null ? null : SalesExecutive.fromJson(json["technicalSupport"]),
    user: SalesExecutive.fromJson(json["user"]),
    login: json["login"],
    coordinate: json["coordinate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "pin": pin,
    "zone": zoneValues.reverse[zone],
    "email": email,
    "division": division,
    "state": stateValues.reverse[state],
    "district": district,
    "salesDist": salesDist,
    "salesOffice": salesOfficeValues.reverse[salesOffice],
    "salesExecutiveName": salesExecutiveNameValues.reverse[salesExecutiveName],
    "salesExecutiveCode": salesExecutiveCode,
    "salesCoordinatorName": nameValues.reverse[salesCoordinatorName],
    "salesCoordinatorCode": divisionalManagerCodeValues.reverse[salesCoordinatorCode],
    "technicalSupportName": nameValues.reverse[technicalSupportName],
    "technicalSupportCode": divisionalManagerCodeValues.reverse[technicalSupportCode],
    "salesManagerName": nameValues.reverse[salesManagerName],
    "salesManagerCode": divisionalManagerCodeValues.reverse[salesManagerCode],
    "zonalManagerName": nameValues.reverse[zonalManagerName],
    "zonalManagerCode": divisionalManagerCodeValues.reverse[zonalManagerCode],
    "nationalManagerName": nameValues.reverse[nationalManagerName],
    "nationalManagerCode": divisionalManagerCodeValues.reverse[nationalManagerCode],
    "divisionalManagerName": nameValues.reverse[divisionalManagerName],
    "divisionalManagerCode": divisionalManagerCodeValues.reverse[divisionalManagerCode],
    "salesExecutive": salesExecutive.toJson(),
    "salesCoordinator": salesCoordinator?.toJson(),
    "technicalSupport": technicalSupport?.toJson(),
    "user": user.toJson(),
    "login": login,
    "coordinate": coordinate,
  };
}

enum DivisionalManagerCode { EMPTY, THE_0032000002, THE_0010001374, THE_0010004756, THE_0034000001, THE_0037000003, THE_0035000003, THE_0038000002 }

final divisionalManagerCodeValues = EnumValues({
  "": DivisionalManagerCode.EMPTY,
  "0010001374": DivisionalManagerCode.THE_0010001374,
  "0010004756": DivisionalManagerCode.THE_0010004756,
  "0032000002": DivisionalManagerCode.THE_0032000002,
  "0034000001": DivisionalManagerCode.THE_0034000001,
  "0035000003": DivisionalManagerCode.THE_0035000003,
  "0037000003": DivisionalManagerCode.THE_0037000003,
  "0038000002": DivisionalManagerCode.THE_0038000002
});

enum Name { EMPTY, AMIYA_NATH_SIR, SAI_POULTRY_FARM, VISHAL_POULTRY_FARM, SADHU_PANDA, AMIT_BALASAHEB_MEMANE, DR_PRAVIN_JADHAV, DR_ANIKET_SAMPATE }

final nameValues = EnumValues({
  "AMIT BALASAHEB MEMANE": Name.AMIT_BALASAHEB_MEMANE,
  "AMIYA NATH SIR": Name.AMIYA_NATH_SIR,
  "Dr ANIKET SAMPATE": Name.DR_ANIKET_SAMPATE,
  "Dr PRAVIN JADHAV": Name.DR_PRAVIN_JADHAV,
  "": Name.EMPTY,
  "SADHU PANDA": Name.SADHU_PANDA,
  "SAI Poultry Farm": Name.SAI_POULTRY_FARM,
  "VISHAL POULTRY FARM": Name.VISHAL_POULTRY_FARM
});

class SalesExecutive {
  DateTime? createdDate;
  int id;
  String login;
  String firstName;
  dynamic lastName;
  Email? email;
  bool activated;
  DateTime? resetDate;
  Designation? designation;
  dynamic designation2;
  Zone zone;
  Type type;
  dynamic reportingTo;
  String? salesDist;
  String? salesOffice;
  DivisionalManagerCode? salesManagerZpCd;
  DivisionalManagerCode? rgnlNamagerZrCd;
  DivisionalManagerCode? nSaleManagerZnCd;
  DivisionalManagerCode? divHeadZhCd;
  dynamic designation3;
  dynamic reportingToName;
  String? phone;

  SalesExecutive({
    this.createdDate,
    required this.id,
    required this.login,
    required this.firstName,
    this.lastName,
    this.email,
    required this.activated,
    this.resetDate,
    this.designation,
    this.designation2,
    required this.zone,
    required this.type,
    this.reportingTo,
    this.salesDist,
    this.salesOffice,
    this.salesManagerZpCd,
    this.rgnlNamagerZrCd,
    this.nSaleManagerZnCd,
    this.divHeadZhCd,
    this.designation3,
    this.reportingToName,
    this.phone,
  });

  factory SalesExecutive.fromJson(Map<String, dynamic> json) => SalesExecutive(
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    login: json["login"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: emailValues.map[json["email"]]!,
    activated: json["activated"],
    resetDate: json["resetDate"] == null ? null : DateTime.parse(json["resetDate"]),
    designation: designationValues.map[json["designation"]]!,
    designation2: json["designation2"],
    zone: zoneValues.map[json["zone"]]!,
    type: typeValues.map[json["type"]]!,
    reportingTo: json["reportingTo"],
    salesDist: json["salesDist"],
    salesOffice: json["salesOffice"],
    salesManagerZpCd: divisionalManagerCodeValues.map[json["salesManagerZpCd"]]!,
    rgnlNamagerZrCd: divisionalManagerCodeValues.map[json["rgnlNamagerZrCd"]]!,
    nSaleManagerZnCd: divisionalManagerCodeValues.map[json["nSaleManagerZnCd"]]!,
    divHeadZhCd: divisionalManagerCodeValues.map[json["divHeadZhCd"]]!,
    designation3: json["designation3"],
    reportingToName: json["reportingToName"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "login": login,
    "firstName": firstName,
    "lastName": lastName,
    "email": emailValues.reverse[email],
    "activated": activated,
    "resetDate": resetDate?.toIso8601String(),
    "designation": designationValues.reverse[designation],
    "designation2": designation2,
    "zone": zoneValues.reverse[zone],
    "type": typeValues.reverse[type],
    "reportingTo": reportingTo,
    "salesDist": salesDist,
    "salesOffice": salesOffice,
    "salesManagerZpCd": divisionalManagerCodeValues.reverse[salesManagerZpCd],
    "rgnlNamagerZrCd": divisionalManagerCodeValues.reverse[rgnlNamagerZrCd],
    "nSaleManagerZnCd": divisionalManagerCodeValues.reverse[nSaleManagerZnCd],
    "divHeadZhCd": divisionalManagerCodeValues.reverse[divHeadZhCd],
    "designation3": designation3,
    "reportingToName": reportingToName,
    "phone": phone,
  };
}

enum Designation { ZS, ZO, ZE }

final designationValues = EnumValues({
  "ZE": Designation.ZE,
  "ZO": Designation.ZO,
  "ZS": Designation.ZS
});

enum Email { THE_0037000003_JAPFA_COM, THE_0030000001_JAPFA_COM, ANIKET_SAMPATE_JAPFA_COM }

final emailValues = EnumValues({
  "aniket.sampate@japfa.com": Email.ANIKET_SAMPATE_JAPFA_COM,
  "0030000001@japfa.com": Email.THE_0030000001_JAPFA_COM,
  "0037000003@japfa.com": Email.THE_0037000003_JAPFA_COM
});

enum Type { EMPLOYEE, CUSTOMER }

final typeValues = EnumValues({
  "Customer": Type.CUSTOMER,
  "Employee": Type.EMPLOYEE
});

enum Zone { EMPTY, WEST, EAST_1 }

final zoneValues = EnumValues({
  "east-1": Zone.EAST_1,
  "": Zone.EMPTY,
  "west": Zone.WEST
});

enum SalesExecutiveName { NANA_MAGAR }

final salesExecutiveNameValues = EnumValues({
  "Nana Magar": SalesExecutiveName.NANA_MAGAR
});

enum SalesOffice { PUN }

final salesOfficeValues = EnumValues({
  "PUN": SalesOffice.PUN
});

enum State { MAHARASHTRA, EMPTY }

final stateValues = EnumValues({
  "": State.EMPTY,
  "Maharashtra": State.MAHARASHTRA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
