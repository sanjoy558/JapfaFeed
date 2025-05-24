import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DeliveryChallanResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/PendingGoodsResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/goodsReceivedList_Screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class GoodsReceivedDetailsController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var dcnumber = "".obs;
  var pono = "".obs;
  var newPendingGoodsList = List<PendingGoodsResponses>.empty().obs;
  var delivery_challan_table = List<DeliveryChallanResponse>.empty().obs;

  late Future<void> _launched;

  var tabindex=0.obs;
  var division_name="".obs;
  var division_id="".obs;



  /*@PUT("api/update-delivery-status")
  Call<DeliveryResponseVM> setPendingDelivered(@Header("Authorization") String token, @Body DeliveryRequestVM data);*/

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
        newPendingGoodsList.value = Get.arguments['pending_list'];
        dcnumber.value = Get.arguments['dc_number'];
        pono.value = Get.arguments['pono'];
        print(' details screen tushar : ${newPendingGoodsList.value.toString()}');
        deliveryChallanTabel();
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


  void changetab(int i) {
    Get.off(GoodsReceivedListScreen());
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

  void setPoRecived(PendingGoodsResponses dataModel) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
       'id':dataModel.id,
      'status': "Delivered",
      'divisionId': division_id.value.toString()
    });
    ApiService()
        .executeRawPut('api/update-delivery-status',body, tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          MainPresenter.getInstance().showToast("Successfully updated");
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

  void deliveryChallanTabel() {
    print("delivery-challan-record : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/delivery-challan-record/${dcnumber.value}',tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          delivery_challan_table.value = jsonResponse
          .map((item) => DeliveryChallanResponse.fromJson(item))
          .toList();
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
}
