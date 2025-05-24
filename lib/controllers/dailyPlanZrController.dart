import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class DailyPlanZrController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var division_name = "".obs;
  var division_id = "".obs;
  var routeid = "".obs;
  var designation = "".obs;
  var visitorList = List<VisitorListResponse>.empty().obs;

  late Future<void> _launched;

  String screen_type="";
  String appbarname="";

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

      designation.value = MainPresenter
          .getInstance()
          .userModel
          .designation!;
      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;
      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;

      if (Get.arguments != null) {
        screen_type = Get.arguments['screen_type'];

        if(screen_type=="plan"){

          appbarname="Team Plan";
        }else if(screen_type=="report"){
          appbarname="Team Report";
        }
      }


      /*if(designation.value=="ZO"){

      }else{

      }*/
      getVisitorList();
      MainPresenter.getInstance().printLog("userid tushar1", userId);
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
    Get.off(HomeScreen());
  }

  void callCustomer(VisitorListResponse dataModel) {
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
  void getVisitorList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });

    ApiService()
        .executeWithBearerTokenGET('api/web/my-visitors', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          visitorList.value =
              list.map((e) => VisitorListResponse.fromJson(e)).toList();
          MainPresenter.getInstance()
              .printLog("visitorList", visitorList.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Login', "Server error");
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
}
