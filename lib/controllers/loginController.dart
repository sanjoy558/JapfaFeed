import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/CustomerDataResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/SocialMediaMasterResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/customer/customer_home_screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/otp/otpScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/PermissionDeSerializing.dart';

class LoginController extends GetxController {
  var ui_logintypeflag = 0.obs;
  final userloginid = TextEditingController();
  final userName = TextEditingController();
  final userPassword = TextEditingController();

  var displayLoading = false.obs;
  var loginType=0.obs;
  String deviceid="";

  var socialMediaList = List<SocialMediaMasterObject>.empty().obs;

  late Future<void> _launched;
  var morquee_str="Soon Feed Application Going To Launch".obs;
  var isHidden = true.obs;


  @override
  void onInit() {
    super.onInit();


    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
      deviceid=token.toString();
    });

    getSocialMediaData();

  }

  void togglePasswordView() {
      isHidden.value = !isHidden.value;
  }

  changeLoginPageTab(int flagvalue) {
    ui_logintypeflag.value = flagvalue;
    userName.clear();
    userPassword.clear();
    print(flagvalue);
  }

  void login() {
    if (!validateCountryCode(userName.text.toString().trim())) {
      openAndCloseLoadingDialog('User Name', 'Please enter valid user name');
    } else if (!validateCountryCode(userPassword.text.toString().trim())) {
      openAndCloseLoadingDialog('Password', 'Please enter valid password');
    }else {
      loginUser();
      //loginUserDetails("eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwMDMwMDAwMDAxIiwiYXV0aCI6IlJPTEVfVVNFUiIsImV4cCI6MTcxNDA0MzY3NH0.BAgg08MBKFqusM9w9Uu2cxJghrEkexRryy-cIMOHkhoweyGLm0IzlKmtwtLroQZESrZmBB1uC9dCA-LG3fzX1g");
    }
  }

  void validateUserid() {
    if (!validateCountryCode(userloginid.text.toString().trim())) {
      MainPresenter.getInstance().showErrorToast("Invalid Username");
    } else {
      otpScreen();
    }
  }

  bool validateCountryCode(String value) {
    if (value.length < 2) {
      return false;
    }
    return true;
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

  void loginUser() async {
    displayLoading.value = true;
    final body = jsonEncode({
      'username': userName.text,
      'password': userPassword.text,
      'rememberMe': 'true',
      'deviceid': deviceid
    });
    ApiService().executeRawPOST('api/authenticate', body).then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        LoginResponse loginResponse =
            LoginResponse.fromJson(jsonDecode(response.body));

        if(loginResponse.idToken==""){

          showDialog(
              barrierDismissible: false,
              context: Get.context as BuildContext,
              builder: (BuildContext context) {
                return WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: AlertDialog(
                    title: Text('Feed Connect'),
                    content: Text('This account is already logged in to another device. Please contact to admin to relogin.'),
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Ok'),
                        ),
                      ),
                    ],
                  ),
                );
              });

        }else if (loginResponse.idToken != null) {
          print(loginResponse.idToken);
          print(loginResponse.permission);
          loginUserDetails(loginResponse.idToken/*,loginResponse.permission*/);
        }
      }else{
        displayLoading.value = false;
        openAndCloseLoadingDialog('Users Details', "Invalid Users Details..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }


  void loginUserDetails(String? idToken/*,String? permission*/) {
    print("new  token : ${idToken}");
    displayLoading.value = true;
    final body = jsonEncode({
     /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService().executeWithBearerTokenGET('api/account',idToken!).then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        UserDetailsResponse userDetailsResponse =
        UserDetailsResponse.fromJson(jsonDecode(response.body));
        if (userDetailsResponse.id != null) {
          var user = UserModel();
          user.usertype=userDetailsResponse.type.toString();

          if(user.usertype=="Customer"){

            loginCustomersDetails(idToken/*,permission*/,userDetailsResponse.type.toString());

          }else{

            user.userId=userDetailsResponse.id.toString();
            user.login=userDetailsResponse.login.toString();
            user.firstName=userDetailsResponse.firstName.toString();

            if(userDetailsResponse.designation3!="na"){
              user.designation=userDetailsResponse.designation3.toString();
            }else if(userDetailsResponse.designation2!="na"){
              user.designation=userDetailsResponse.designation2.toString();
            }else if(userDetailsResponse.designation!="na"){
              user.designation=userDetailsResponse.designation.toString();
            }


            /*if(userDetailsResponse.designation3!=null){
              user.designation=userDetailsResponse.designation3.toString();
            }else if(userDetailsResponse.designation2!=null){
              user.designation=userDetailsResponse.designation2.toString();
            }else if(userDetailsResponse.designation!=null){
              user.designation=userDetailsResponse.designation.toString();
            }*/

            MainPresenter.getInstance().printLog("user Designation", user.designation);
            user.zone=userDetailsResponse.zone.toString();
            user.authority=userDetailsResponse.authorities?.toString();
            user.IS_LOGIN_FIRST="true";
            user.tokenid=idToken;
            /*user.permission=permission;*/
            MainPresenter.getInstance().userModel = user;
            MainPresenter.getInstance().printLog("TAG", user.toJson().toString());
            MainPresenter.getInstance().printLog("designation", user.designation.toString());
            SharePrefsHelper.saveUserModel(user);
            Get.offAll(() => HomeScreen());

          }

        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Users Details', "Invalid Users Details..");
        }
      }else{
        displayLoading.value = false;
        openAndCloseLoadingDialog('Users Details', "Invalid Users Details..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('Users Details', 'Please try again');
    });
  }

  void loginCustomersDetails(String? idToken/*,String? permission*/, String? customerusertype) {
    print("new  token : ${idToken}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService().executeWithBearerTokenGET('api/customers/account',idToken!).then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        CustomerDataResponse userDetailsResponse =
        CustomerDataResponse.fromJson(jsonDecode(response.body));
        if (userDetailsResponse.id != null) {
          var user = UserModel();
          user.usertype=customerusertype;
          user.userId=userDetailsResponse.id.toString();
          user.login=userDetailsResponse.login.toString();
          user.firstName=userDetailsResponse.firstName.toString();
          user.zone=userDetailsResponse.zone.toString();

          user.executiveId=userDetailsResponse.salesExecutive!.id.toString();
          user.executivelogin=userDetailsResponse.salesExecutive!.login.toString();
          user.executivefirstName=userDetailsResponse.salesExecutive!.firstName.toString();
          user.executiveemail=userDetailsResponse.salesExecutive!.email.toString();

          user.IS_LOGIN_FIRST="true";
          user.tokenid=idToken;
          //user.permission=permission;
          MainPresenter.getInstance().userModel = user;
          MainPresenter.getInstance().printLog("TAG", user.toJson().toString());
          SharePrefsHelper.saveUserModel(user);

          Get.offAll(() => CustomerHomeScreen());

        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Users Details', "Invalid Users Details..");

        }
      }else{
        displayLoading.value = false;
        openAndCloseLoadingDialog('Users Details', "Invalid Users Details..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }

  Future<void> printdata() async {
    var user1 = UserModel();
    user1 = await SharePrefsHelper.getUserModel();
    MainPresenter.getInstance().printLog("getshared", user1.toJson().toString());
  }

  void otpScreen() {

    Get.to(() => OtpScreen()/*, arguments: {
      'userid':userloginid.text
    }*/);
    /*userloginid.clear();*/
  }


  void getSocialMediaData() async {
    displayLoading.value = true;
    ApiService().executeGet('api/social_media_master')
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        SocialMediaMasterResponse socialMediaMasterResponse =
        SocialMediaMasterResponse.fromJson(jsonDecode(response.body));
        if (socialMediaMasterResponse.message=="Success") {
          socialMediaList.value=socialMediaMasterResponse.data!;
          print((socialMediaList.value.length));
          print((socialMediaList.value[2].socialMedia));

          if(socialMediaList.value.length>3){
            morquee_str.value=socialMediaList.value[3].socialMediaLink!;
          }

        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Social Media', "Server error");
        }
      }else{
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Social Media', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Social Media', 'Please try again');
    });
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

  void launchSocial(String s) {
    switch(s){
      case "1":
        getUrlToLaunch(socialMediaList.value[0].socialMediaLink);
        break;
      case "2":
        getUrlToLaunch(socialMediaList.value[1].socialMediaLink);
        break;
      case "3":
        getUrlToLaunch(socialMediaList.value[2].socialMediaLink);
        break;
    }
  }

  void getUrlToLaunch(String? socialMediaLink){
    MainPresenter.getInstance().printLog("socialMediaLink url : ", socialMediaLink);
    _launched = _launchedyoutube(
        "${socialMediaLink}");
    FutureBuilder<void>(
        future: _launched, builder: _launchStatus);
  }

}
