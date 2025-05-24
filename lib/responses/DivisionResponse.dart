class DivisionResponse {
  int? id;
  String? divisionId;
  String? divisionName;
  bool? isActive;

  DivisionResponse(
      {this.id, this.divisionId, this.divisionName, this.isActive});

  DivisionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['divisionId'];
    divisionName = json['divisionName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['divisionId'] = this.divisionId;
    data['divisionName'] = this.divisionName;
    data['isActive'] = this.isActive;
    return data;
  }
}
