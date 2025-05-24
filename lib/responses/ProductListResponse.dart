class ProductListResponse {
  int? id;
  String? brand;
  String? bird;
  String? stage;
  String? productId;
  String? materialType;
  double? weight;
  String? unit;
  String? remark;
  String? materialText;
  int? status;
  String? productFullName;

  ProductListResponse(
      {this.id,
        this.brand,
        this.bird,
        this.stage,
        this.productId,
        this.materialType,
        this.weight,
        this.unit,
        this.remark,
        this.materialText,
        this.status,this.productFullName});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    bird = json['bird'];
    stage = json['stage'];
    productId = json['productId'];
    materialType = json['materialType'];
    weight = json['weight'];
    unit = json['unit'];
    remark = json['remark'];
    materialText = json['materialText'];
    status = json['status'];
    productFullName = json['brand']+" "+json['bird']+" "+json['stage']+" "+json['materialType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['bird'] = this.bird;
    data['stage'] = this.stage;
    data['productId'] = this.productId;
    data['materialType'] = this.materialType;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['remark'] = this.remark;
    data['materialText'] = this.materialText;
    data['status'] = this.status;
    data['productFullName'] = this.productFullName;
    return data;
  }
}
