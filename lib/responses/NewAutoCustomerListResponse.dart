class NewAutoCustomerListResponse {
  int? id;
  String? divisionId;
  String? customerName;
  String? remark;
  String? login;
  String? fromDate;
  String? toDate;

  NewAutoCustomerListResponse(
      {this.id,
        this.divisionId,
        this.customerName,
        this.remark,
        this.login,
        this.fromDate,
        this.toDate});

  NewAutoCustomerListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['divisionId'];
    customerName = json['customer_name'];
    remark = json['remark'];
    login = json['login'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['divisionId'] = this.divisionId;
    data['customer_name'] = this.customerName;
    data['remark'] = this.remark;
    data['login'] = this.login;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
