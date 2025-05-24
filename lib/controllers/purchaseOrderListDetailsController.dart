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
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';
import '../responses/PurchaseOrderResponse.dart';
import '../views/purchaseOrderMain_Screen.dart';

class PurchaseOrderListDetailsController extends GetxController {
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var customerList = List<PurchaseOrderResponse>.empty().obs;
  CustomerListResponse? customerListResponse;
  late Future<void> _launched;

  PurchaseOrderResponse purchase_order_object=new PurchaseOrderResponse();
  var itemsList=List<Items>.empty().obs;

  var division_name="".obs;
  var division_id="".obs;



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
      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;
      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      if (Get.arguments != null) {
        purchase_order_object = Get.arguments['purchase_order'];
        itemsList.value=purchase_order_object.items!;
        print(' purchase_order_object details screen tushar : ${purchase_order_object.customer?.firstName.toString()}');
      }

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


  void pressBack() {
    Get.back();
  }

  void purchaseOrderDetails(PurchaseOrderResponse dataModel) {
    print(dataModel.customer?.firstName);
  }
 /* void goToMainPurchaseOrderScreen() {
    Get.to(() => PurchaseOrderMainScreen(), arguments: {
    'customer_list':customerList,
    });
  }*/
}
