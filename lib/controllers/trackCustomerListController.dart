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
import 'package:japfa_feed_application/responses/TrackCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class TrackCustomerListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";
  var trackcustomerlist = List<TrackCustomerListResponse>.empty().obs;

  late Future<void> _launched;

  var listtype = "".obs;
  var actionbartitle = "".obs;
  var Data1 = false.obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      login = MainPresenter.getInstance().userModel.login!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      //getCustomerList();
    }
    if (Get.arguments != null) {
      listtype.value = Get.arguments['list_type'];
      print(' details screen list_type : ${listtype.value}');

      //last_month_billed_customer

      switch (listtype.value) {
        case "last_month_billed_customer":
          actionbartitle.value = "Billed Customers";
          break;
        case "current_month_billed":
          actionbartitle.value = "Current Month";
          break;
        case "current_month_new_customer":
          actionbartitle.value = "Current Month New";
          break;
        case "current_month_unbilled_customer":
          actionbartitle.value = "Unbilled Customer";
          break;
        case "total_current_month_active_customers":
          actionbartitle.value = "Active Customers";
          break;
      }

      getCustomerList(listtype.value);
    }
  }


  /*lmbc(last month builled customer) o column
  cmb(curtrent month builled) n column
  cnc(current month new customer)p column
  cmuc(current month unbuilled customer) q column
  tcmac(totalcurrent month active customer) n and p column*/

  Future<void> openAndCloseLoadingDialog(String title, String msg) async {
    Get.defaultDialog(title: title, content: Text("$msg"), actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'))
    ]);
  }

  void getCustomerList(String listtype) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET(
            'api/mobile/my-customers-status/${login}/${listtype}', tokenid!)
        .then((value) {
      http.Response response = value;
      Data1.value = true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          trackcustomerlist.value =
              list.map((e) => TrackCustomerListResponse.fromJson(e)).toList();
          MainPresenter.getInstance()
              .printLog("trackcustomerlist", trackcustomerlist.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Login', "Server error");
        }
      } else {
        displayLoading.value = false;
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      Data1.value = true;
    });
  }

  void changetab(int i) {
    Get.back();
  }

  void callCustomer(TrackCustomerListResponse dataModel) {
    if (dataModel.phone != null && dataModel.phone!.length > 0)
      _launched = _launchedyoutube('tel://${dataModel.phone!}');
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
}
