class TempProductList1 {

  int? headerId;
  String? brand;
  String? bird;
  String? material;
  String? modifiedOn;
  int? noOfBags;
  double? packageingWeight;
  String? stage;
  double? totalQuantity;
  String? productId;

  TempProductList1(
      {
      this.headerId,
        this.brand,
        this.bird,
        this.material,
        this.modifiedOn,
        this.noOfBags,
        this.packageingWeight,
        this.stage,
        this.totalQuantity,
      this.productId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerId'] = this.headerId;
    data['brand'] = this.brand;
    data['bird'] = this.bird;
    data['material'] = this.material;
    data['modifiedOn'] = this.modifiedOn;
    data['noOfBags'] = this.noOfBags;
    data['packageingWeight'] = this.packageingWeight;
    data['stage'] = this.stage;
    data['totalQuantity'] = this.totalQuantity;
    data['productId'] = this.productId;
    return data;
  }
}
