import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanNewCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/dailyVisitFeedback.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class DailyPlanNewCustomerListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var routeid = "".obs;
  var division_name = "".obs;
  var division_id = "".obs;
  var login = "";
  var newCustomerVisitorList = List<DailyPlanNewCustomerListResponse>.empty().obs;


  late Future<void> _launched;

  var Data1=false.obs;
  var newCustomerVisitCount = 0.obs;
  var newCustomerVisitTotalCount = 0.obs;


  @override
  void onInit() {
    if (MainPresenter
        .getInstance()
        .userModel
        .userId != null) {
      userId = MainPresenter
          .getInstance()
          .userModel
          .userId!;
      login = MainPresenter
          .getInstance()
          .userModel
          .login!;
      firstname = MainPresenter
          .getInstance()
          .userModel
          .firstName!;
      tokenid = MainPresenter
          .getInstance()
          .userModel
          .tokenid!;
      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;
      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      getNewCustomerList();
    }
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

  void getNewCustomerList() {
    print("getNewCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/customer-enquiry-todays-division/${login}/${division_id}', tokenid!)
        .then((value) {
      http.Response response = value;
      Data1.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          newCustomerVisitorList.value.clear();
          final list = jsonDecode(response.body) as List<dynamic>;
          newCustomerVisitorList.value =
              list.map((e) => DailyPlanNewCustomerListResponse.fromJson(e)).toList();

          MainPresenter.getInstance()
              .printLog("customerVisitorslist1", newCustomerVisitorList.value.length);
          newCustomerVisitTotalCount.value=newCustomerVisitorList.length;
          newCustomerVisitCount.value=0;
          for (var item in newCustomerVisitorList.value) {
            print(item.status);
            if(item.status=="visited"){
              newCustomerVisitCount.value=newCustomerVisitCount.value+1;
            }
          }
        } else {
          displayLoading.value = false;
        }
      } else {
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
    });
  }

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void callCustomer(DailyPlanCustomers dataModel) {
    if (dataModel.phone != null && dataModel.phone!.length > 0)
      _launched = _launchedyoutube(
          'tel://${dataModel.phone!}');
    FutureBuilder<void>(future: _launched, builder: _launchStatus);
  }
  Future<void> _launchedyoutube(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{"my_header_key": "my_header_view"},
      );
    } else {
      throw "not launch $url";
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text("Error : ${snapshot})");
    } else {
      return const Text("");
    }
  }

  void gotToFeedBack(DailyPlanNewCustomerListResponse dataModel,String cancel_visit) async {

    if(cancel_visit=="cancel"){
      submitForm(dataModel);
    }else if(cancel_visit=="visit"){
      //print(await LocalDataBase.instance!.query(dataModel.id.toString()));
      if(await SharePrefsHelper.getBool(
          SharePrefsHelper.USER_START_JOURNEY_FLAG)){
        Get.to(NewCustomerFormScreen(), arguments: {
          'screen_type':'insert',
          'dataModel': dataModel
        });
      }else{
        MainPresenter.getInstance().showToastLong("Please Start Journey!!");
      }
    }

  }

  void submitForm(DailyPlanNewCustomerListResponse dataModel) {
    displayLoading.value = true;
    final body = jsonEncode({
      'cash_discount': "N/a",
      'company_name': "N/a",
      'customer_name': dataModel.customerName,
      'customer_type': "N/a",
      'district': "N/a",
      'feed_buying_from': "N/a",
      'feed_buying_type': "N/a",
      'firm_name': "N/a",
      'fromDate': dataModel.fromDate,
      "id": dataModel.id,
      "login": login,
      'mobile_number': "N/a",
      'monthly_feed_sales': "N/a",
      'monthly_sales': "N/a",
      'monthly_scheme_per_bag': "N/a",
      'monthly_target': "N/a",
      'monthly_total_feed_sales': "N/a",
      'payment_terms': "N/a",
      'remark': dataModel.remark,
      'state': "N/a",
      'tehsil': "N/a",
      'toDate': dataModel.toDate,
      'top_selling_sku': "N/a",
      'top_selling_sku_name': "N/a",
      'top_selling_sku_price': "N/a",
      'top_selling_sku_monthly_sales':"N/a",
      'top_sku_selling_price_bag':"N/a",
      'village': "N/a",
      'status':'canceled'
    });
    ApiService()
        .executeRawPut('api/customer-enquiry', body, tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        MainPresenter.getInstance().showToast("Visit canceled successfully");
        getNewCustomerList();
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
}
