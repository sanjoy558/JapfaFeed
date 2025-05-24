import 'dart:async';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/interfaces.dart';
import 'package:japfa_feed_application/views/customer/customer_home_screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/loginScreen.dart';

class SplashController extends GetxController implements UserIdCallbackListener{

  var userModel=UserModel();
  @override
  void onInit() {
    MainPresenter.getInstance().getBuyerDetails(this);
    super.onInit();
  }


  gotoNextPage(String? is_login_first,String? usertype){

    Timer(
        const Duration(seconds: 3),
            () async => {
              if (is_login_first == "true"){

                if(usertype=="Customer"){
                  Get.offAll(() =>CustomerHomeScreen())
                }else{
                  Get.offAll(() =>HomeScreen())
                }

              }else{
                Get.offAll(() => LoginScreen())
              }
        });
  }

  @override
  void onUserIdDataReceived(UserModel userModel) {
    // TODO: implement onUserIdDataReceived
    userModel=userModel;
    MainPresenter.instance?.printLog("splash UserModel1", userModel.toJson().toString());
    gotoNextPage(userModel.IS_LOGIN_FIRST,userModel.usertype);
  }
}