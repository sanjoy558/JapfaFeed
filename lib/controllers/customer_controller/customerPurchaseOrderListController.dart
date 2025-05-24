import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerPoAcceptCancelResponse.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/customer/customerEditPurchaseOrderMain_Screen.dart';
import 'package:japfa_feed_application/views/customer/customerPurchaseOrderListDetails_Screen.dart';
import 'package:japfa_feed_application/views/customer/customerPurchaseOrderMain_Screen.dart';
import 'package:japfa_feed_application/views/customer/customer_home_screen.dart';
import 'package:japfa_feed_application/views/customer/editPurchaseOrderScreen.dart';

class CustomerPurchaseOrderListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var division_name = "".obs;
  var division_id = "".obs;
  var customerList = List<PurchaseOrderResponse>.empty().obs;
  var refreshFlag="".obs;


  var ontapSearchFalg=false.obs;
  final filter_textedit = new TextEditingController();

  var fromdate_str = "".obs;
  var todate_str = "".obs;

  var filteredPurchaseOrderList = List<PurchaseOrderResponse>.empty().obs;
  var Data1=false.obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
     /* if (Get.arguments != null) {
        refreshFlag.value = Get.arguments['refresh'];
        getCustomerList();
      }else{
        getCustomerList();
      }*/

      initializeDate();
      getPurchaseOrderList();

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
    };
    ApiService()
        .executeWithBearerTokenGETAndParam('api/mobile/purchase-order-hds-date', tokenid!,paramsMaps)
        .then((value) {
      http.Response response = value;
      Data1.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => PurchaseOrderResponse.fromJson(e)).toList();
          filteredPurchaseOrderList.value=customerList.value;
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
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
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
          filteredPurchaseOrderList.value=customerList.value;
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void changetab(int i) {
    Get.off(CustomerHomeScreen());
  }

  void purchaseOrderDetails(PurchaseOrderResponse dataModel) {
    print(dataModel.customer?.firstName);
    Get.to(() => CustomerPurchaseOrderListDetailsScreen(),
        arguments: {'purchase_order': dataModel});
  }

  void goToMainPurchaseOrderScreen() {
    Get.to(() => CustomerPurchaseOrderMainScreen(true), arguments: {
      'customer_list': customerList.value,
    });
  }

  void processorder(String str_1, int? id,int position) {

    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(str_1=="Accept"?'api/mobile/purchase-order-hds-update/${id}/Accepted'
        :"api/mobile/purchase-order-hds-update/${id}/Cancel", tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          CustomerPoAcceptCancelResponse cancelResponse=CustomerPoAcceptCancelResponse.fromJson(jsonDecode(response.body));

          if(cancelResponse.message=="Success"){
            if(str_1=="Accept"){
              customerList.value[position].status="Delivered";
              filteredPurchaseOrderList.value[position].status="Delivered";
              MainPresenter.getInstance().showToast("Order Successfully Accepted");
              update();
            }else if(str_1=="Cancel"){
              customerList.value[position].status="Cancelled";
              filteredPurchaseOrderList.value[position].status="Cancelled";
              update();
              MainPresenter.getInstance().showToast("Order Successfully Canceled");
            }
          }else{
            MainPresenter.getInstance().showToast("Server Error");
          }

        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void reOrder(String str_1, int? id, PurchaseOrderResponse dataModel) {
    Get.to(() => CustomerEditPurchaseOrderMainScreen(true),
        arguments: {'purchase_order': dataModel});
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

  void filterPurchaseOrder(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<PurchaseOrderResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList.value;
    } else {
      /*results = customerList.value
          .where((element) => element.customer!.firstName.toString().toLowerCase().contains(playerName.toLowerCase()))
          .toList();*/

      results= customerList.value.where((item) =>
      item.customer!.firstName.toString().toLowerCase().contains(playerName.toLowerCase()) ||
          item.status.toString().toLowerCase().contains(playerName.toLowerCase()) ||
          item.orderUUID.toString().contains(playerName.toLowerCase())).toList();
    }
    filteredPurchaseOrderList.value = results;
  }

  void clearFilter() {
    filter_textedit.clear();
    filteredPurchaseOrderList.value=customerList.value;
  }
}
