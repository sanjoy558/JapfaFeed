import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/BrochureListResponse.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';
import '../views/view_pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
/*https://www.developers-zone.com/pdf-view-in-flutter-from-url-flutter_pdfview/
https://medium.com/@ahmedtahaelelemy/how-to-display-a-pdf-in-flutter-9523e38f4ea1#:~:text=In%20this%20tutorial%2C%20we%20have,to%20it%20from%20another%20screen.*/
class ViewPdfController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  String pdfurl = "";
  String pdftitle = "";

  late File Pfile;
  var filename1 = "".obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      if (Get.arguments != null) {
        pdfurl = Get.arguments['pdfurl'];
        pdftitle = Get.arguments['pdftitle'];
      }

      loadNetwork();
    }
  }
  Future<void> loadNetwork() async {
    displayLoading.value = true;
    var url = pdfurl;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    Pfile = file;
    filename1.value=filename;
    print(Pfile);
    displayLoading.value = false;
  }
}
