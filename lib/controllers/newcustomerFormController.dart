import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:japfa_feed_application/responses/CustomerPoAcceptCancelResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanNewCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/NewCustomerEnquiryListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/views/dailyPlanNewCustomerList_Screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';

class CustomerFormController extends GetxController {
  var displayLoading = false.obs;
  var division_name = "".obs;
  var division_id = "".obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";

  var screen_type="";
  var customertypelist = List<String>.empty().obs;

  final customer_firmname_name = TextEditingController();
  final customer_name = TextEditingController();
  final customer_mobile = TextEditingController();
  final customer_state = TextEditingController();
  final customer_district = TextEditingController();
  final customer_tehsil = TextEditingController();
  final customer_village = TextEditingController();
  final customer_monthly_total_feed_sale_mt = TextEditingController();
  final customer_feed_buying_from = TextEditingController();
  final customer_monthly_feed_sale = TextEditingController();
  final customer_top_selling_sku_name = TextEditingController();
  final customer_top_selling_sku_price_per_bag = TextEditingController();
  final customer_top_selling_sku_monthly_sale = TextEditingController();
  final customer_company_name = TextEditingController();
  final customer_monthly_sales_mt = TextEditingController();
  final customer_feed_buying_type = TextEditingController();
  final customer_payment_terms = TextEditingController();
  final customer_top_selling_sku = TextEditingController();
  final customer_top_sku_selling_price_50_kg_bag = TextEditingController();
  final customer_cah_discount = TextEditingController();
  final customer_monthly_target_mt = TextEditingController();
  final customer_monthly_scheem_rs_per_bag = TextEditingController();
  final customer_remark = TextEditingController();

  var selected_customertype_string = "Select Customer Type".obs;
  var customerListResponse=new DailyPlanNewCustomerListResponse().obs;
  var customerListResponse1=new NewCustomerEnquiryListResponse().obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      login = MainPresenter.getInstance().userModel.login!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);

      if (Get.arguments != null) {

        screen_type=Get.arguments['screen_type'];
        MainPresenter.getInstance().printLog("userid tushar1", screen_type);
        if(screen_type=="insert"){
          customerListResponse.value = Get.arguments['dataModel'];

          customer_name.text=customerListResponse.value.customerName!;
          customer_remark.text=customerListResponse.value.remark!;
          MainPresenter.getInstance().printLog("userid tushar1", customerListResponse.value.customerName);
        }else if(screen_type=="update"){

          customerListResponse1.value=Get.arguments['dataModel'];
          setDataTextField();
        }

      }



      customertypelist.clear();
      customertypelist.add('Farmer');
      customertypelist.add('Integrator');
      customertypelist.add('Customer');
      customertypelist.add('Dealer');
    }
  }

  void submitForm() {
    displayLoading.value = true;
    final body = jsonEncode({
      'cash_discount': customer_cah_discount.text,
      'company_name': customer_company_name.text,
      'customer_name': customer_name.text,
      'customer_type': selected_customertype_string.value,
      'district': customer_district.text,
      'feed_buying_from': customer_feed_buying_from.text,
      'feed_buying_type': customer_feed_buying_type.text,
      'firm_name': customer_firmname_name.text,
      'fromDate': screen_type=="insert"?customerListResponse.value.fromDate:customerListResponse1.value.fromDate,
      "id": screen_type=="insert"?customerListResponse.value.id:customerListResponse1.value.id,
      "login": login,
      'mobile_number': customer_mobile.text,
      'monthly_feed_sales': customer_monthly_feed_sale.text,
      'monthly_sales': customer_monthly_sales_mt.text,
      'monthly_scheme_per_bag': customer_monthly_scheem_rs_per_bag.text,
      'monthly_target': customer_monthly_target_mt.text,
      'monthly_total_feed_sales': customer_monthly_total_feed_sale_mt.text,
      'payment_terms': customer_payment_terms.text,
      'remark': customer_remark.text,
      'state': customer_state.text,
      'tehsil': customer_tehsil.text,
      'toDate': screen_type=="insert"?customerListResponse.value.toDate:customerListResponse1.value.toDate,
      'top_selling_sku': customer_top_selling_sku.text,
      'top_selling_sku_name': customer_top_selling_sku_name.text,
      'top_selling_sku_price': customer_top_selling_sku_price_per_bag.text,
      'top_selling_sku_monthly_sales':
          customer_top_selling_sku_monthly_sale.text,
      'top_sku_selling_price_bag':
          customer_top_sku_selling_price_50_kg_bag.text,
      'village': customer_village.text,
      'status':'visited'
    });
    ApiService()
        .executeRawPut('api/customer-enquiry', body, tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;

        if(screen_type=="insert"){
          MainPresenter.getInstance().showToast("Form Successfully Submited");
          Get.offAll(HomeScreen());
        }else if(screen_type=="update"){
          MainPresenter.getInstance().showToast("Form Successfully Updated");
          Get.back(result: "true");
        }

      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Login', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }

  Future<void> openAndCloseLoadingDialog(String title, String msg) async {
    Get.defaultDialog(title: title, content: Text("$msg"), actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'))
    ]);
  }

  void setSelectedTransportType(String value) {
    MainPresenter.getInstance()
        .printLog("TAG transport type", value.toString());
    selected_customertype_string.value = value.toString();
    refresh();
    /*getCustomerList(value.id.toString());*/
  }

  void setDataTextField() {
    selected_customertype_string.value=customerListResponse1.value.customerType.toString();
    customer_name.text=customerListResponse1.value.customerName!;
    customer_firmname_name.text=customerListResponse1.value.firmName!;
    customer_mobile.text=customerListResponse1.value.mobileNumber!;
    customer_state.text=customerListResponse1.value.state!;
    customer_district.text=customerListResponse1.value.district!;
    customer_tehsil.text=customerListResponse1.value.tehsil!;
    customer_village.text=customerListResponse1.value.village!;
    customer_monthly_total_feed_sale_mt.text=customerListResponse1.value.monthlyTotalFeedSales!;
    customer_feed_buying_from.text=customerListResponse1.value.feedBuyingFrom!;
    customer_monthly_feed_sale.text=customerListResponse1.value.monthlyFeedSales!;
    customer_top_selling_sku_name.text=customerListResponse1.value.topSellingSkuName!;
    customer_top_selling_sku_price_per_bag.text=customerListResponse1.value.topSellingSkuPrice!;
    customer_top_selling_sku_monthly_sale.text=customerListResponse1.value.topSellingSkuMonthlySales!;
    customer_company_name.text=customerListResponse1.value.companyName!;

    customer_monthly_sales_mt.text=customerListResponse1.value.monthlySales!;
    customer_feed_buying_type.text=customerListResponse1.value.feedBuyingType!;
    customer_payment_terms.text=customerListResponse1.value.paymentTerms!;
    customer_top_selling_sku.text=customerListResponse1.value.topSellingSku!;
    customer_top_sku_selling_price_50_kg_bag.text=customerListResponse1.value.topSkuSellingPriceBag!;
    customer_cah_discount.text=customerListResponse1.value.cashDiscount!;
    customer_monthly_target_mt.text=customerListResponse1.value.monthlyTarget!;
    customer_monthly_scheem_rs_per_bag.text=customerListResponse1.value.monthlySchemePerBag!;
    customer_remark.text=customerListResponse1.value.remark!;
  }
}
