import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/responses/BrochureListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/view_pdf_screen.dart';

class BrochureListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var brochureList = List<BrochureResponse>.empty().obs;
  late Future<void> _launched;

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
        .executeWithBearerTokenGET('api/uploads', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {


          final list = jsonDecode(response.body) as List<dynamic>;
          brochureList.value =
              list.map((e) => BrochureResponse.fromJson(e)).toList();
          MainPresenter.getInstance()
              .printLog("customerVisitorslist1", brochureList.value.length);
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Brochure', "Server error");
        }
      } else {
        displayLoading.value = false;
        openAndCloseLoadingDialog('Brochure', "Invalid..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('Brochure', 'Please try again');
    });
  }

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void launchURL(String path) async {
    String pdfurl=BASE_URL+"api/uploads/pdf/"+path;

    Get.to(() => ViewPdfScreen(), arguments: {
      'pdftitle': path,
      'pdfurl': pdfurl,
    });
   /* if (!await launchUrl(url)) {
      throw Exception('Could not launch $path');
    }*/
  }

  void openPdf(String path) {
    if (path != null && path!.length > 0)
      _launched = _launchedurl(path);
    FutureBuilder<void>(future: _launched, builder: _launchStatus);
  }
  Future<void> _launchedurl(String url) async {
    if (await canLaunch(url)) {
      await launchUrl(url as Uri,mode: LaunchMode.externalApplication);
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
