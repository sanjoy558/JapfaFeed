
class CustomFeedbackInsertResponse {
  /*String? endingKm;
  Customers? customers;*/
  String? customersVisited;
  /*String? endTime;
  int? noOfPoints;
  String? startingKm;
  String? pointsTravelled;
  String? remark;
  String? routId;
  String? startTime;
  String? superVisorId;
  Target? target;
  String? vehicleNumber;
  String? date;
  Visitor? visitor;*/



  CustomFeedbackInsertResponse(
   /* this.endingKm
    , this.customers
    , */this.customersVisited
    /*, this.endTime
    , this.noOfPoints
    , this.startingKm
    , this.pointsTravelled
    , this.remark
    , this.routId
    , this.startTime
    , this.superVisorId
    , this.target
    , this.vehicleNumber
    , this.date
    , this.visitor*/

  );

  CustomFeedbackInsertResponse.fromJson(Map<String, dynamic> json) {
   /* endingKm = json['endingKm'];
    customers = json['customers'];*/
    customersVisited = json['customersVisited'];
    /*endTime = json['endTime'];
    noOfPoints = json['noOfPoints'];
    startingKm = json['startingKm'];
    pointsTravelled = json['pointsTravelled'];
    remark = json['remark'];
    routId = json['routId'];
    startTime = json['startTime'];
    superVisorId = json['superVisorId'];
    target = json['target'];
    vehicleNumber = json['vehicleNumber'];
    date = json['date'];
    visitor = json['visitor'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    /*data['endingKm'] = this.endingKm;
    data['customers'] = this.customers;*/
    data['customersVisited'] = this.customersVisited;
    /*data['endTime'] = this.endTime;
    data['noOfPoints'] = this.noOfPoints;
    data['startingKm'] = this.startingKm;
    data['pointsTravelled'] = this.pointsTravelled;
    data['remark'] = this.remark;
    data['routId'] = this.routId;
    data['startTime'] = this.startTime;
    data['superVisorId'] = this.superVisorId;
    data['target'] = this.target;
    data['vehicleNumber'] = this.vehicleNumber;
    data['datedate'] = this.date;
    data['visitor'] = this.visitor;*/
    return data;
  }

}

class Customers {
  int? id;

  Customers(this.id);
  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }

}

class Target {
  int? id;
  String? login;
}

class Visitor {
  int? id;
  String? login;
}