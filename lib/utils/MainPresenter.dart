import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/utils/Constants.dart';

import 'SharePrefHelper.dart';
import 'interfaces.dart';

class MainPresenter {
  static MainPresenter? instance;
  UserModel userModel = UserModel();
  var userId = "".obs;
  var showFreeDelivery = false.obs;
  var defaultMinimumCartAmt = 0.0.obs;
  var minimumCartAmount = 0.0.obs;
  var deliveryCharges = 0.0.obs;
  var minimumOrderValue = 0.0.obs;
  var remainingCartAmount = 0.0.obs;
  var cartCount = 0.obs;
  var appversion="".obs;

  static MainPresenter getInstance() {
    instance ??= MainPresenter();
    return instance!;
  }

  Future<void> getBuyerDetails(UserIdCallbackListener userIdCallbackListener) async {
    try {
      userModel = await SharePrefsHelper.getUserModel();
      printLog("UserModel with notnull", userModel.toJson());
      userIdCallbackListener.onUserIdDataReceived(userModel);
    } catch (e) {
      userModel = UserModel();
      userIdCallbackListener.onUserIdDataReceived(userModel);
    }
  }

  int currentYear() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    if (formattedDate.isNotEmpty) {
      return int.parse(formattedDate);
    } else {
      return 0;
    }
  }

  String getPaternWiseDate(String pattern) {
    DateTime now = DateTime.now();
    var formatter = new DateFormat(pattern);
    String todays_date = formatter.format(now);
    //todays_date
    print("patternwise Date : ${todays_date}");
    return todays_date;
  }

  String getTimeStamp() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String todays_date = formatter.format(now);
    //todays_date
    print("getTimeStamp : ${todays_date}");
    return todays_date;
  }

  void printLog(var TAG, var msg) {
    print("\n$TAG: $msg");
  }

  void showToast(var msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showToastLong(var msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showErrorToast(var msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: customerred,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  Position? startTracking(Position? position) {
    const duration = Duration(seconds: 4);
    Timer.periodic(duration, (Timer t) async {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,
      );
    });
    return position;
  }

}
