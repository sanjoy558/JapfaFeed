import 'dart:async';
import 'dart:convert';

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

class ChangePasswordController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var division_name = "".obs;

  final oldpassword = TextEditingController();

  final newpassword = TextEditingController();

  final confirm_newpassword = TextEditingController();


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
      MainPresenter.getInstance().printLog("userid tushar1", userId);

      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;
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

  bool validatePasswordWidget() {
    if (oldpassword.text.isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invalid Old Password");
      return false;
    }else if (newpassword.text.isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invalid New Password");
      return false;
    }else if (confirm_newpassword.text.isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invalid Confrim Password");
      return false;
    } else if (newpassword.text !=confirm_newpassword.text) {
      MainPresenter.getInstance().showErrorToast("Password Mismatch");
      return false;
    } else {
      return true;
    }
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

  void changePassword() {
    if(validatePasswordWidget()){
      print("getCustomerList : ${tokenid}");
      displayLoading.value = true;
      final body = jsonEncode({
         'currentPassword': oldpassword.text,
      'newPassword': confirm_newpassword.text,
      });
      ApiService()
          .executeRawPOSTCustomerForm('api/account/change-password',body, tokenid!)
          .then((value) {
        http.Response response = value;
        if (response.statusCode == 200) {
          MainPresenter.getInstance().showToastLong("Password Updated Successfully");
          oldpassword.clear();
          newpassword.clear();
          confirm_newpassword.clear();
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Change Password', "Server error..");
        }
      }).catchError((onError) {
        print(onError);
        displayLoading.value = false;
        openAndCloseLoadingDialog('Change Password', 'Please try again');
      });
    }




  }



}
