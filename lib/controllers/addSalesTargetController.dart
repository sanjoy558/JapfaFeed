import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerListByVisitorIdResponse.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class AddSalesTargetController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";
  var appbar_name = "";
  var divisionid = "";

  var yearList = List<String>.empty().obs;
  var selected_dropdown_year = "Select Year".obs;


  var monthList = List<String>.empty().obs;
  var selected_dropdown_month = "Select Month".obs;

  final et_add_sales_target = TextEditingController();


  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      login = MainPresenter.getInstance().userModel.login!;
      appbar_name = MainPresenter.getInstance().userModel.divisionname!;
      divisionid = MainPresenter.getInstance().userModel.divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);


      yearList.clear();
      yearList.add('2024');
      yearList.add('2025');
      yearList.add('2026');

      monthList.clear();
      for(int i=1;i<=12;i++){
        monthList.add(i.toString());
        print(i);
      }

      selected_dropdown_year.value=getyear("year");
      selected_dropdown_month.value=getyear("month");
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

  String getyear(String year_month) {
    DateTime now = DateTime.now();
    var formatter;
    if(year_month=="year"){
      formatter = new DateFormat('yyyy');
    }else if(year_month=="month"){
      formatter = new DateFormat('MM');
    }
    //var formatter_date = new DateFormat('yyyy-MM-dd');

    String year = formatter.format(now);
    return year;
  }

   bool validateTargetData() {
    if (selected_dropdown_year.value.toString().isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invlid year");
      return false;
    } else if (selected_dropdown_month.value.toString().isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invlid month");
      return false;
    } else if (et_add_sales_target.text == "") {
      MainPresenter.getInstance().showErrorToast("Invlid target");
      return false;
    } else {
      return true;
    }
  }

  void submitForm() {
    displayLoading.value = true;
    final body = jsonEncode({
      'divisionId':divisionid,
      'id': "0",
      'month': selected_dropdown_month.value,
      'salesExecutiveLogin': login,
      'salesExecutiveName': firstname,
      'target': et_add_sales_target.text.toString(),
      'year': selected_dropdown_year.value,
    });
    ApiService()
        .executeRawPOSTCustomerForm('api/sales-manager-target-master', body, tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        MainPresenter.getInstance().showToast("Form Successfully Submited");
        selected_dropdown_year.value="";
        selected_dropdown_month.value="";
        et_add_sales_target.clear();
        //Get.offAll(PgMain());
        Get.offAll(HomeScreen());
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
