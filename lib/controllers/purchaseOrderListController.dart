import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';
import '../responses/PurchaseOrderResponse.dart';
import '../views/purchaseOrderListDetails_Screen.dart';
import '../views/purchaseOrderMain_Screen.dart';

class PurchaseOrderListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var customerList = List<PurchaseOrderResponse>.empty().obs;
  var filteredPurchaseOrderList = List<PurchaseOrderResponse>.empty().obs;
  var refreshFlag = "".obs;

  var ontapSearchFalg = false.obs;
  var ui_tabtypeflag = 0.obs;

  var fromdate_str = "".obs;
  var todate_str = "".obs;
  var dropdown_order_status_str = "--Select--".obs;
  var orderStatusList = List<String>.empty().obs;

  final filter_textedit = new TextEditingController();

  var Data1=false.obs;
  var division_id="".obs;
  var division_name="".obs;

  @override
  void onInit() {
    /*if (Get.arguments != null) {
      */ /*refreshFlag.value = Get.arguments[0]['refresh'];
      MainPresenter.getInstance().printLog("refresh",refreshFlag.value);*/ /*
      MainPresenter.getInstance().printLog("refreshFlag",Get.arguments['refresh']);
      */ /*MainPresenter.getInstance().printLog("refresh",Get.arguments['rajput']);*/ /*
      initializeDate();
      getPurchaseOrderList();
    }*/

    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      division_id.value=MainPresenter.getInstance().userModel.divisionid!;
      division_name.value=MainPresenter.getInstance().userModel.divisionname!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      orderStatusList.clear();
      orderStatusList.add("Created");
      orderStatusList.add("Approved");
      orderStatusList.add("Dispatched");
      orderStatusList.add("Delivered");
      orderStatusList.add("Cancelled");
      initializeDate();

      getPurchaseOrderList();

    }
  }

  void getDivisionSharedData() async{

    division_id.value =
    await SharePrefsHelper.getString(SharePrefsHelper.DIVISION_ID);
    //MainPresenter.getInstance().printLog("Division id", division_id.value.toString());
    if(!division_id.value.isEmpty){
      MainPresenter.getInstance().printLog("Division id", division_id.value.toString());

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

  void getPurchaseOrderList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    Map<String, dynamic> paramsMaps = {
      'startDate': fromdate_str.value.toString(),
      'endDate': todate_str.value.toString(),
      'divisionId':division_id.value.toString()
    };
    ApiService()
        .executeWithBearerTokenGETAndParam(
            'api/mobile/purchase-order-hds-date-division', tokenid!, paramsMaps)
        .then((value) {
      http.Response response = value;
      Data1.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => PurchaseOrderResponse.fromJson(e)).toList();
          filteredPurchaseOrderList.value = customerList.value;

          /*customerList1.value=customerList.value.toSet().toList();*/

          /* refreshFlag.value="";*/

          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void getAllPurchaseOrder() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    Map<String, dynamic> paramsMaps = {
      'startDate': fromdate_str.value.toString(),
      'endDate': todate_str.value.toString(),
    };
    ApiService()
        .executeWithBearerTokenGET('api/mobile/purchase-order-hds', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          customerList.clear();
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => PurchaseOrderResponse.fromJson(e)).toList();
          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
          filteredPurchaseOrderList.value = customerList.value;
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void purchaseOrderDetails(PurchaseOrderResponse dataModel) {
    print(dataModel.customer?.firstName);
    Get.to(() => PurchaseOrderListDetailsScreen(),
        arguments: {'purchase_order': dataModel});
  }

  void goToMainPurchaseOrderScreen() {
    Get.to(() => PurchaseOrderMainScreen(true));
  }

  changePageTab(int flagvalue) {
    ui_tabtypeflag.value = flagvalue;
    print(flagvalue);
  }

  void initializeDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print("todyas date is : ${formattedDate}");
    fromdate_str.value = formattedDate;
    todate_str.value = formattedDate;
  }

  void getTodaysData() {
    filteredPurchaseOrderList.clear();
    initializeDate();
    getPurchaseOrderList();
  }

  void getDataWithDateRange(DateTimeRange dateTimeRange) {
    print(dateTimeRange.start);
    print(dateTimeRange.end);

    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTimeRange.start);
    String formattedDate1 = formatter.format(dateTimeRange.end);
    print("todyas date is : ${formattedDate} ${formattedDate1}");
    fromdate_str.value = formattedDate;
    todate_str.value = formattedDate1;

    filteredPurchaseOrderList.clear();
    getPurchaseOrderList();
  }

  void filterPurchaseOrder(String flagStatus, String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<PurchaseOrderResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList.value;
    } else {
      /*results = customerList.value
          .where((element) => element.customer!.firstName.toString().toLowerCase().contains(playerName.toLowerCase()))
          .toList();*/
      if (flagStatus == "1") {
        results = customerList.value
            .where((item) =>
                item.customer!.firstName
                    .toString()
                    .toLowerCase()
                    .contains(playerName.toLowerCase()) ||
                item.status
                    .toString()
                    .toLowerCase()
                    .contains(playerName.toLowerCase()) ||
                item.orderUUID
                    .toString()
                    .contains(playerName.toLowerCase())||
                item.exec!.firstName
                    .toString()
                    .contains(playerName.toLowerCase()))
            .toList();
      } else if (flagStatus == "2") {
        results = customerList.value
            .where((item) => item.status
                .toString()
                .toLowerCase()
                .contains(playerName.toLowerCase()))
            .toList();
      }
    }
    filteredPurchaseOrderList.value = results;
  }

  void clearFilter() {
    filter_textedit.clear();
    filteredPurchaseOrderList.value = customerList.value;
  }
}
