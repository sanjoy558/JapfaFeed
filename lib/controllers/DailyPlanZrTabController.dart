import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';

class DailyPlanZrTabController extends GetxController {
  var displayLoading = false.obs;
  var userId = "";
  String screetype = "";
  String login = "";
  var division_name = "".obs;
  var division_id = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      login = MainPresenter.getInstance().userModel.login!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
    }
  }
}
