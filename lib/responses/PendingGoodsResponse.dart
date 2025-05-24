class PendingGoodsResponses {
  int? id;
  String? driverName;
  String? weight;
  String? dcNumber;
  String? material;
  String? vehicleNumber;
  String? crDate;
  String? poNumber;
  String? quantity;
  String? driverNumber;
  String? crTime;
  String? pono;

  PendingGoodsResponses(
      {this.id,
        this.driverName,
        this.weight,
        this.dcNumber,
        this.material,
        this.vehicleNumber,
        this.crDate,
        this.poNumber,
        this.quantity,
        this.driverNumber,
        this.crTime,
      this.pono});

  PendingGoodsResponses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverName = json['driverName'];
    weight = json['weight'];
    dcNumber = json['dcNumber'];
    material = json['material'];
    vehicleNumber = json['vehicleNumber'];
    crDate = json['cr_date'];
    poNumber = json['poNumber'];
    quantity = json['quantity'];
    driverNumber = json['driverNumber'];
    crTime = json['cr_time'];
    pono = json['pono']==null?"N/A":json['pono'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driverName'] = this.driverName;
    data['weight'] = this.weight;
    data['dcNumber'] = this.dcNumber;
    data['material'] = this.material;
    data['vehicleNumber'] = this.vehicleNumber;
    data['cr_date'] = this.crDate;
    data['poNumber'] = this.poNumber;
    data['quantity'] = this.quantity;
    data['driverNumber'] = this.driverNumber;
    data['cr_time'] = this.crTime;
    data['pono'] = this.pono;
    return data;
  }
}
