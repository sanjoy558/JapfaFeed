class TempProductList {
  String? productid;
  String? headerId;
  String? brand;
  String? bird;
  String? material;
  String? modifiedOn;
  int? noOfBags;
  double? packageingWeight;
  String? stage;
  double? totalQuantity;

  TempProductList(
      {this.productid,
      this.headerId,
        this.brand,
        this.bird,
        this.material,
        this.modifiedOn,
        this.noOfBags,
        this.packageingWeight,
        this.stage,
        this.totalQuantity});

  String get getproductid {
    return productid!;
  }
  set setproductid(String productid1) {
    productid = productid1;
  }

  String get getHeaderId {
    return headerId!;
  }
  set setHeaderId(String headerid) {
    headerId = headerid;
  }

  int get getnoOfBags {
    return noOfBags!;
  }
  set setnoOfBags(int noBags) {
    noOfBags = noBags;
  }

  double get getpackageingWeight {
    return packageingWeight!;
  }
  set setpackageingWeight(double packageingWeight1) {
    packageingWeight = packageingWeight1;
  }


  double get gettotalQuantity {
    return totalQuantity!;
  }
  set settotalQuantity(double totalQuantity1) {
    totalQuantity = totalQuantity1;
  }

  String get getbrand {
    return brand!;
  }
  set setbrand(String brand1) {
    brand = brand1;
  }

  String get getbird {
    return bird!;
  }
  set setbird(String bird1) {
    bird = bird1;
  }

  String get getmaterial {
    return material!;
  }
  set setmaterial(String material1) {
    material = material1;
  }

  String get getmodifiedOn {
    return modifiedOn!;
  }
  set setmodifiedOn(String modifiedOn1) {
    modifiedOn = modifiedOn1;
  }


  String get getstage {
    return stage!;
  }
  set setstage(String stage1) {
    stage = stage1;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['headerId'] = this.headerId;
    data['brand'] = this.brand;
    data['bird'] = this.bird;
    data['material'] = this.material;
    data['modifiedOn'] = this.modifiedOn;
    data['noOfBags'] = this.noOfBags;
    data['packageingWeight'] = this.packageingWeight;
    data['stage'] = this.stage;
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}
