import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/responses/OtpResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';

class OtpController extends GetxController {
  final userloginid = TextEditingController();
  final pinputcontroller = TextEditingController();

  var displayLoading = false.obs;
  String otp = "";
 /* String loginuserid = "";*/

  var flagDisplayId=true.obs;

  @override
  void onInit() {
    super.onInit();
   /* if (Get.arguments != null) {
      loginuserid = Get.arguments['userid'];

      print(' login user id tushar : ${loginuserid}');

       fetchData("1",loginuserid);
    }*/
  }

  Future<void> fetchData(String str, String str2) async {
    displayLoading.value = true;
    final http.Response? result =
        await ApiService.executeGET12("${getString(str)}" + "/${str2}");
    if (result != null) {
      // Process the response or update the state as needed.
      print("Response: ${result.body}");
      if (str == "1") {
        if (result.statusCode == 200) {
          displayLoading.value = false;
            OtpResponse otpResponse =
          OtpResponse.fromJson(jsonDecode(result.body));
          if (otpResponse.data != null) {
            otp=otpResponse.data!.otp.toString();
            flagDisplayId.value=false;
          } else {
            displayLoading.value = false;
            openAndCloseLoadingDialog('Otp Details', "Server error");
          }
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Otp Details', "Invalid Users Details..");
        }
      } else if (str == "2") {
        if (result.statusCode == 200) {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Password Details',
              "Password is sent to registered phone number.");
          pinputcontroller.clear();
        }else{
          displayLoading.value = false;
          openAndCloseLoadingDialog('Otp Details', "Invalid Users Details..");
        }
      }
    } else {
      // Handle the error case.
      print("Error occurred during the request.");
      openAndCloseLoadingDialog('Otp Details', "Invalid Users Details..");
    }
  }

  /*void getOtp(String str) async {
    displayLoading.value = true;

    //final result = await ApiService().executeGET1('api/account/${getString(str)}/$loginuserid');
    final response = await http.get(Uri.parse(getString(str)+"/$loginuserid"));
    if(str=="1"){
      if (response.statusCode == 200) {
        displayLoading.value = false;
        OtpResponse otpResponse =
        OtpResponse.fromJson(jsonDecode(response.body));
        if (otpResponse.data != null) {
          otp=otpResponse.data!.otp.toString();
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Otp Details', "Server error");
        }
      }else{
        displayLoading.value = false;
        openAndCloseLoadingDialog('Otp Details', "Invalid Users Details..");
      }
    }else if(str=="2"){
      if (response.statusCode == 200) {
        displayLoading.value = false;
        openAndCloseLoadingDialog('Password Details', "Password is sent to registered phone number.");
      }
    }
  }*/
  String getString(String abc) {
    if (abc == "1")
      return "api/account/forget-password-otp";
    else
      return "api/account/reset-password";
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

  bool validatePinPutWidget() {
    if (pinputcontroller.text.length != 6) {
      MainPresenter.getInstance().showErrorToast("Invalid Otp");
      return false;
    } else {
      return true;
    }
  }

  bool validateLoginIdWidget() {
    if (userloginid.text.isEmpty) {
      MainPresenter.getInstance().showErrorToast("Invalid Username");
      return false;
    } else {
      return true;
    }
  }

  void VerifyOtp() {
    print(otp);
    if (validatePinPutWidget()) {
      if (otp == pinputcontroller.text) {
        print(otp);
        fetchData("2", userloginid.text);
      }
    }
  }

  void getLoginId() {
    if(validateLoginIdWidget()){
      fetchData("1", userloginid.text);
    }
  }

  void editAgainLoginId() {
    flagDisplayId.value=true;
  }
}
