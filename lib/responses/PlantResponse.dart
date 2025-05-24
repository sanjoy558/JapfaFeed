class PlantResponse {
  int? id;
  String? name;
  String? code;
  String? plantCode;
  String? person;
  String? address;
  String? zip;
  String? district;

  PlantResponse(
      {this.id,
        this.name,
        this.code,
        this.plantCode,
        this.person,
        this.address,
        this.zip,
        this.district});

  PlantResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    plantCode = json['plantCode'];
    person = json['person'];
    address = json['address'];
    zip = json['zip'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['plantCode'] = this.plantCode;
    data['person'] = this.person;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['district'] = this.district;
    return data;
  }
}
