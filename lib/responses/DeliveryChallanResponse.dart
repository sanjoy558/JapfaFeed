class DeliveryChallanResponse {
  int? id;
  String? driverName;
  String? dcNumber;
  String? weight;
  String? material;
  String? vehicleNumber;
  String? quantity;
  String? driverNumber;
  String? crDate;
  String? crTime;
  String? pono;
  String? poNumber;
  Null? actQty;

  DeliveryChallanResponse(
      {this.id,
        this.driverName,
        this.dcNumber,
        this.weight,
        this.material,
        this.vehicleNumber,
        this.quantity,
        this.driverNumber,
        this.crDate,
        this.crTime,
        this.pono,
        this.poNumber,
        this.actQty});

  DeliveryChallanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverName = json['driverName'];
    dcNumber = json['dcNumber'];
    weight = json['weight'];
    material = json['material'];
    vehicleNumber = json['vehicleNumber'];
    quantity = json['quantity'];
    driverNumber = json['driverNumber'];
    crDate = json['cr_date'];
    crTime = json['cr_time'];
    pono = json['pono'];
    poNumber = json['poNumber'];
    actQty = json['actQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driverName'] = this.driverName;
    data['dcNumber'] = this.dcNumber;
    data['weight'] = this.weight;
    data['material'] = this.material;
    data['vehicleNumber'] = this.vehicleNumber;
    data['quantity'] = this.quantity;
    data['driverNumber'] = this.driverNumber;
    data['cr_date'] = this.crDate;
    data['cr_time'] = this.crTime;
    data['pono'] = this.pono;
    data['poNumber'] = this.poNumber;
    data['actQty'] = this.actQty;
    return data;
  }
}
