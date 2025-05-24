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
import 'package:japfa_feed_application/responses/DailyPlanReportResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/TrackCustomerResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/trackCustomerList_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class DailyPlanReportController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";
  var designation = "".obs;
  var division_name = "".obs;
  var division_id = "".obs;
  var daily_plan_report_list = List<DailyPlanReportResponse>.empty().obs;

  var fromdate_str = "".obs;
  var todate_str = "".obs;

  final fromdate = TextEditingController();
  final todate = TextEditingController();
  var daillyplanDataTrue_false=false.obs;

  var report_type="";

  var appbar_name="";

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
      designation.value=MainPresenter.getInstance().userModel.designation!;
      division_name.value=MainPresenter.getInstance().userModel.divisionname!;

      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;

      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;


      if(designation.value=="ZO"){
        login = MainPresenter
            .getInstance()
            .userModel
            .login!;
      }else{
        if (Get.arguments != null) {
          login = Get.arguments['login'];
        }
        print(login);
      }





      MainPresenter.getInstance().printLog("userid tushar1", userId);
      initializeDate();

      if (Get.arguments != null) {
        report_type = Get.arguments['report_type'];

        if(report_type=="existing_customer"){
          appbar_name="Existing Customer";
          dailyPlanReportTabel("api/track-target-history");
        }else if(report_type=="new_customer"){
          appbar_name="New Customer";
          dailyPlanReportTabel("api/customer-enquiry-count-list-division/${division_id.value}");
        }
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

  void dailyPlanReportTabel(String api_str) {
    print("delivery-challan-record : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('$api_str/${login}/${fromdate_str.value}/${todate_str.value}',tokenid!)
        .then((value) {
      http.Response response = value;
      daillyplanDataTrue_false.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        daily_plan_report_list.value.clear();
        if (response.body != null) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          daily_plan_report_list.value = jsonResponse
              .map((item) => DailyPlanReportResponse.fromJson(item))
              .toList();
          //MainPresenter.getInstance().showToast(daily_plan_report_list.value.length.toString());
          refresh();
        } else {
          displayLoading.value = false;
        }
      } else {
        displayLoading.value = false;
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      daillyplanDataTrue_false.value=true;
    });
  }
  DateTime selectedDate = DateTime.now();
  void selectDate(BuildContext context, String datetype) async {
    String dialogHead = "";

    if (datetype == "from") {
      dialogHead = "Select From Date";
    } else {
      dialogHead = "Select To Date";
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        helpText: dialogHead,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      if (datetype == "from") {
        fromdate_str.value = formatDate(picked);
        fromdate.text = fromdate_str.value;
        update();
      } else {
        todate_str.value = formatDate(picked);
        todate.text = todate_str.value;
        update();
      }
    }
  }

  String formatDate(DateTime dateTime) {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
  void initializeDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print("todyas date is : ${formattedDate}");
    fromdate_str.value = formattedDate;
    todate_str.value = formattedDate;
    fromdate.text = fromdate_str.value;
    todate.text = todate_str.value;
  }

  submitDate() {
    if(report_type=="existing_customer"){
      dailyPlanReportTabel("api/track-target-history");
    }else if(report_type=="new_customer"){
      dailyPlanReportTabel("api/customer-enquiry-count-list-division/${division_id.value}");
    }
    //dailyPlanReportTabel();
  }
}
