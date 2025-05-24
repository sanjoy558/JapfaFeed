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
import 'package:japfa_feed_application/responses/PendingGoodsResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/goodsReceivedDetailsList_Screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class GoodsReceivedController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var division_name="".obs;
  var division_id="".obs;
  var pendingGoodsList = List<PendingGoodsResponses>.empty().obs;
  var pendingGoodsListDistinct = List<PendingGoodsResponses>.empty().obs;

  late Future<void> _launched;

  var tabindex=0.obs;
  var filteredPendingGoodsList = List<PendingGoodsResponses>.empty().obs;
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
   /* final body = jsonEncode({
       'username': "0030000001",
    });*/
    /*Map<String, dynamic> paramsMaps = {
      'divisionId': division_id.value,
    };*/
    ApiService()
        .executeWithBearerTokenGET('api/pending-delivery-division/${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          pendingGoodsList.value =
              list.map((e) => PendingGoodsResponses.fromJson(e)).toList();

          pendingGoodsListDistinct.value = getDistinctByDcNumber(pendingGoodsList.value);

          filteredPendingGoodsList.value=pendingGoodsListDistinct.value;
          MainPresenter.getInstance()
              .printLog("customerlist1", pendingGoodsListDistinct.value.length);
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

  void goToGoodsDetailsScreen(String? dcNumber,String? pono) {
    MainPresenter.getInstance().printLog("new list","${dcNumber}");
    var newPendingGoodsList = List<PendingGoodsResponses>.empty().obs;
    /*int i=0;
    while (i < pendingGoodsList.length) {
      i++;
      if(dcNumber==pendingGoodsList[i].dcNumber){
        MainPresenter.getInstance().printLog("new list1","${pendingGoodsList[i].dcNumber}");
      }

    }*/

    for(var abc in pendingGoodsList){
      if(abc.dcNumber==dcNumber){
        MainPresenter.getInstance().printLog("new list123","${abc.dcNumber}");
        newPendingGoodsList.add(abc);
      }
    }
    MainPresenter.getInstance().printLog("new list1234","${newPendingGoodsList.length}");


    Get.to(() => GoodsReceivedListDetailsScreen(), arguments: {
      'pono':pono,
      'dc_number':dcNumber,
      'pending_list':newPendingGoodsList,
    });
  }

  void filterGoodsRec(String flagStatus, String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<PendingGoodsResponses> results = [];
    if (playerName.isEmpty) {
      results = pendingGoodsListDistinct.value;
    } else {
      results = pendingGoodsListDistinct.value
          .where((item) => item.dcNumber
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase()) ||

          item.pono
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase()) ||

          item.poNumber
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();

    }
    filteredPendingGoodsList.value = results;
  }

  void clearFilter() {
    filter_textedit.clear();
    filteredPendingGoodsList.value = pendingGoodsListDistinct.value;
  }


  List<PendingGoodsResponses> getDistinctByDcNumber(List<PendingGoodsResponses> list) {
    var dcNumberSet = <String>{};
    List<PendingGoodsResponses> distinctList=[];

    for (var item in list) {
      if (dcNumberSet.add(item.dcNumber.toString())) {
        distinctList.add(item);
      }
    }

    return distinctList;
  }
}
