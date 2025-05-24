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
import 'package:japfa_feed_application/responses/NewCustomerEnquiryListResponse.dart';
import 'package:japfa_feed_application/responses/PendingGoodsResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/goodsReceivedDetailsList_Screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class DailyPlanNewCustomerUpdateController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var login = "";
  var tokenid = "";
  var newcustomer_enquiryList = List<NewCustomerEnquiryListResponse>.empty().obs;

  late Future<void> _launched;

  var tabindex=0.obs;
  var filtered_newcustomer_enquiryList = List<NewCustomerEnquiryListResponse>.empty().obs;
  var ontapSearchFalg=false.obs;
  final filter_textedit = new TextEditingController();
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
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/customer-enquiry-list/$login', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          newcustomer_enquiryList.value =
              list.map((e) => NewCustomerEnquiryListResponse.fromJson(e)).toList();

          filtered_newcustomer_enquiryList.value=newcustomer_enquiryList.value;
          MainPresenter.getInstance()
              .printLog("customerlist1", newcustomer_enquiryList.value.length);
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
    Get.back();
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

  void goToNewCustomerFormScreen(NewCustomerEnquiryListResponse dataModel) async {
    if(await SharePrefsHelper.getBool(
    SharePrefsHelper.USER_START_JOURNEY_FLAG)){

      var data = await Get.to(NewCustomerFormScreen(),arguments: {
        'screen_type':'update',
        'dataModel': dataModel
      });

      if (data != null) {
        var backResult = data.toString();
        MainPresenter.getInstance().printLog("backResult", backResult.toString());
        if(backResult.toString()=="true"){
          getCustomerList();
        }
      }

    /*Get.to(NewCustomerFormScreen(), arguments: {
      'screen_type':'update',
    'dataModel': dataModel
    });*/
    }else{
    MainPresenter.getInstance().showToastLong("Please Start Journey!!");
    }
  }

  void filterGoodsRec(String flagStatus, String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<NewCustomerEnquiryListResponse> results = [];
    if (playerName.isEmpty) {
      results = newcustomer_enquiryList.value;
    } else {
      results = newcustomer_enquiryList.value
          .where((item) => item.customerName
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase()) ||

          item.mobileNumber
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase()))
          .toList();

    }
    filtered_newcustomer_enquiryList.value = results;
  }

  void clearFilter() {
    filter_textedit.clear();
    filtered_newcustomer_enquiryList.value = newcustomer_enquiryList.value;
  }
}
