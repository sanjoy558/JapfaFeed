class NewCustomerEnquiryListResponse {
  int? id;
  String? firmName;
  String? customerName;
  String? mobileNumber;
  String? state;
  String? district;
  String? tehsil;
  String? village;
  String? monthlyTotalFeedSales;
  String? feedBuyingFrom;
  String? monthlyFeedSales;
  String? topSellingSkuName;
  String? topSellingSkuPrice;
  String? topSellingSkuMonthlySales;
  String? companyName;
  String? monthlySales;
  String? feedBuyingType;
  String? paymentTerms;
  String? topSellingSku;
  String? topSkuSellingPriceBag;
  String? cashDiscount;
  String? monthlyTarget;
  String? monthlySchemePerBag;
  String? remark;
  String? customerType;
  String? login;
  String? status;
  String? fromDate;
  String? toDate;

  NewCustomerEnquiryListResponse(
      {this.id,
        this.firmName,
        this.customerName,
        this.mobileNumber,
        this.state,
        this.district,
        this.tehsil,
        this.village,
        this.monthlyTotalFeedSales,
        this.feedBuyingFrom,
        this.monthlyFeedSales,
        this.topSellingSkuName,
        this.topSellingSkuPrice,
        this.topSellingSkuMonthlySales,
        this.companyName,
        this.monthlySales,
        this.feedBuyingType,
        this.paymentTerms,
        this.topSellingSku,
        this.topSkuSellingPriceBag,
        this.cashDiscount,
        this.monthlyTarget,
        this.monthlySchemePerBag,
        this.remark,
        this.customerType,
        this.login,
        this.status,
        this.fromDate,
        this.toDate});

  NewCustomerEnquiryListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firmName = json['firm_name'];
    customerName = json['customer_name'];
    mobileNumber = json['mobile_number'];
    state = json['state'];
    district = json['district'];
    tehsil = json['tehsil'];
    village = json['village'];
    monthlyTotalFeedSales = json['monthly_total_feed_sales'];
    feedBuyingFrom = json['feed_buying_from'];
    monthlyFeedSales = json['monthly_feed_sales'];
    topSellingSkuName = json['top_selling_sku_name'];
    topSellingSkuPrice = json['top_selling_sku_price'];
    topSellingSkuMonthlySales = json['top_selling_sku_monthly_sales'];
    companyName = json['company_name'];
    monthlySales = json['monthly_sales'];
    feedBuyingType = json['feed_buying_type'];
    paymentTerms = json['payment_terms'];
    topSellingSku = json['top_selling_sku'];
    topSkuSellingPriceBag = json['top_sku_selling_price_bag'];
    cashDiscount = json['cash_discount'];
    monthlyTarget = json['monthly_target'];
    monthlySchemePerBag = json['monthly_scheme_per_bag'];
    remark = json['remark'];
    customerType = json['customer_type'];
    login = json['login'];
    status = json['status']==null?"N/A":json['status'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firm_name'] = this.firmName;
    data['customer_name'] = this.customerName;
    data['mobile_number'] = this.mobileNumber;
    data['state'] = this.state;
    data['district'] = this.district;
    data['tehsil'] = this.tehsil;
    data['village'] = this.village;
    data['monthly_total_feed_sales'] = this.monthlyTotalFeedSales;
    data['feed_buying_from'] = this.feedBuyingFrom;
    data['monthly_feed_sales'] = this.monthlyFeedSales;
    data['top_selling_sku_name'] = this.topSellingSkuName;
    data['top_selling_sku_price'] = this.topSellingSkuPrice;
    data['top_selling_sku_monthly_sales'] = this.topSellingSkuMonthlySales;
    data['company_name'] = this.companyName;
    data['monthly_sales'] = this.monthlySales;
    data['feed_buying_type'] = this.feedBuyingType;
    data['payment_terms'] = this.paymentTerms;
    data['top_selling_sku'] = this.topSellingSku;
    data['top_sku_selling_price_bag'] = this.topSkuSellingPriceBag;
    data['cash_discount'] = this.cashDiscount;
    data['monthly_target'] = this.monthlyTarget;
    data['monthly_scheme_per_bag'] = this.monthlySchemePerBag;
    data['remark'] = this.remark;
    data['customer_type'] = this.customerType;
    data['login'] = this.login;
    data['status'] = this.status;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
