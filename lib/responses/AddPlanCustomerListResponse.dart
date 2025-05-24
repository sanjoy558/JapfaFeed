
class AddPlanCustomerListResponse {
  int? id;
  String? firstName;
  bool? checked=false;


  AddPlanCustomerListResponse({this.id, this.firstName, this.checked});

  AddPlanCustomerListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['checked'] = this.checked;
    return data;
  }

}