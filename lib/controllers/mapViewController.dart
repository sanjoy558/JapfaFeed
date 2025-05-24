import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/pointsTravelledString.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/utils/location_service.dart';

class MapViewController extends GetxController {

  var displayLoading = false.obs;
  var userType = "";
  var firstname = "";
  var tokenid = "";
  var userId = "";
  var login = "";

  var totalDistance=0.0.obs;

  List<LatLng>? coordinates=<LatLng>[];
  var pointstravelled;
  List<PointsTravelledString> abc=[];

  @override
  void onInit() {

    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      login = MainPresenter.getInstance().userModel.login!;
      userType = MainPresenter.getInstance().userModel.usertype!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);

    }
    getData();

  }

  void getData()async {

    displayLoading.value=true;
    totalDistance.value=await SharePrefsHelper.getDouble(SharePrefsHelper.TOTAL_KM);

    await LocalDataBase.instance!.getAllPointsTravelled().then((value) {
      pointstravelled = value.map((e) => e.toMap()).toList();
    }).catchError((e) => debugPrint(e.toString()));

    abc=pointstravelled as List<PointsTravelledString>;

    for(var item in abc!){
     coordinates!.add(LatLng(item.latitude??0.0,item.longitude??0.0));
    }

   /* List<LatLng> latLngCoordinates = coordinates!
        .map((pos) => LatLng(pos.latitude, pos.longitude))
        .toList();*/
    displayLoading.value=false;

  }

  List<LatLng> getList(){
    List<LatLng> latLngCoordinates = coordinates!
        .map((pos) => LatLng(pos.latitude, pos.longitude))
        .toList();
    return latLngCoordinates;
  }

}