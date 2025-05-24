import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/SalesTargetListResponse.dart';
import 'package:japfa_feed_application/responses/TrackCustomerResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/trackCustomerList_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class TrackCustomerController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";
  var division_name="".obs;
  var division_id="".obs;
  var customerList = List<CustomerListResponse>.empty().obs;
  var salestargetlist = List<SalesTargetData>.empty().obs;
  var salestargetlistData1=false.obs;
  CustomerListResponse? customerListResponse;

  late Future<void> _launched;

  var newCustomer="".obs;
  var billedCustomer="".obs;
  var unbilledCustomer="".obs;
  var activeCustomer="".obs;
  var lostCustomer="".obs;
  var nopCustomer="".obs;
  var currentIntYear=2024.obs;
  var currentIntMonth=1.obs;

  var zactCust1="".obs;
  var znewCust="".obs;
  var zbillCust="".obs;
  var zunBill="".obs;
  var currentMonthActiveCustomer="".obs;
  var totalcust="".obs;
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
      firstname = MainPresenter
          .getInstance()
          .userModel
          .firstName!;
      tokenid = MainPresenter
          .getInstance()
          .userModel
          .tokenid!;
      login = MainPresenter
          .getInstance()
          .userModel
          .login!;

      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;

      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      getCustomerList();
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

  void getCustomerList() {
    print("track customer : ${tokenid}");
    print("track customer : ${login}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/customer/order-status-division/${login}/${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          TrackCustomerResponse trackCustomerResponse =
          TrackCustomerResponse.fromJson(jsonDecode(response.body));
          newCustomer.value=trackCustomerResponse.data![0].newCustomer.toString();
          billedCustomer.value=trackCustomerResponse.data![0].billedCustomer.toString();
          unbilledCustomer.value=trackCustomerResponse.data![0].unbilledCustomer.toString();
          activeCustomer.value=trackCustomerResponse.data![0].activeCustomer.toString();
          lostCustomer.value=trackCustomerResponse.data![0].lostCustomer.toString();
          nopCustomer.value=trackCustomerResponse.data![0].nopCustomer.toString();



          zactCust1.value=trackCustomerResponse.data![0].zactCust1.toString();

          znewCust.value=trackCustomerResponse.data![0].znewCust.toString();
          zbillCust.value=trackCustomerResponse.data![0].zbillCust.toString();
          zunBill.value=trackCustomerResponse.data![0].zunBill.toString();


          currentMonthActiveCustomer.value=getTotal(znewCust.value, zbillCust.value);

          print("${currentMonthActiveCustomer.value}");

        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('User', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('User', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('User', 'Please try again');
    });
  }

  String getTotal(String a,String b){
    return (double.parse(a)+double.parse(b)).toString();
  }


  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void callCustomer(CustomerListResponse dataModel) {
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

  void goToListScreen(String s) {
    Get.to(() => TrackCustomerListScreen(), arguments: {
      'list_type': s,
    });

    /*switch (s){
      case "billed":
        break;
      case "unbilled":
        break;
      case "":
        break;
      case "":
        break;
    }*/
  }


  getSalesTargetList() {
    print("track customer : ${tokenid}");
    print("track customer : ${login}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    salestargetlistData1.value=true;
    ApiService()
        .executeWithBearerTokenGET('api/sales-manager-target-master/get-division/${login}/${currentIntYear}/${currentIntMonth}/${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          SalesTargetListResponse salesTargetListResponse =
          SalesTargetListResponse.fromJson(jsonDecode(response.body));
          salestargetlist.value=salesTargetListResponse.data!;

          print("salse target${salestargetlist.value.length}");

        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('User', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('User', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('User', 'Please try again');
    });
  }
}
