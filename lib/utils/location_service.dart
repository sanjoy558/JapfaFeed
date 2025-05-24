import 'dart:async';

import 'package:get/route_manager.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/locationString.dart';
import 'package:location/location.dart';

class LocationService {
  LocationService.init();
  static LocationService instance = LocationService.init();

  final Location _location = Location();

  Future<bool> checkForServiceAvailability() async {
    bool isEnabled = await _location.serviceEnabled();
    if (isEnabled) {
      return Future.value(true);
    }

    isEnabled = await _location.requestService();

    if (isEnabled) {
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<bool> checkForPermission() async {
    PermissionStatus status = await _location.hasPermission();

    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      if (status == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
    if (status == PermissionStatus.deniedForever) {
      Get.snackbar("Permission Needed",
          "We use permission to get your location in order to give your service",
          /*onTap: (snack) async {
            await handler.openAppSettings();
          }*/).show();
      return false;
    }

    return Future.value(true);
  }

  Future<void> getUserLocation({required DashboardController controller}) async {
    controller.updateIsAccessingLocation(true);

    if (!(await checkForServiceAvailability())) {
      controller.errorDescription.value = "Service not enabled";
      controller.updateIsAccessingLocation(false);

      return;
    }
    if (!(await checkForPermission())) {
      controller.errorDescription.value = "Permission not given";
      controller.updateIsAccessingLocation(false);
      return;
    }

  }

  Future<LocationData> getUserLocationVisit() async {
    final LocationData data = await _location.getLocation();
    return data;
  }


  Future<void> getUserContinuousLocation(bool bool) async{
    //https://github.com/Amanullahgit/Live-Location-Tracker-Flutter/blob/master/lib/main.dart

    StreamSubscription<LocationData>? locationSubscription=null;
    if(bool){
      locationSubscription=_location.onLocationChanged.listen((LocationData locationData) async {
        print("latitude: ${locationData.latitude}:::::longitude:${locationData.longitude}");
        await LocalDataBase.instance!.insertLocation(todo: LocationString(userlatitude: locationData.latitude.toString(), userlongitude: locationData.longitude.toString()));
      });
    }else if(!bool){
      try {
        print("location subscription canceled");
        await locationSubscription?.cancel();
    } catch (e) {
    print("location subscription exception: ${e}");
    }
  }
}

 /* Future<void> getLocationOnChanged({required DashboardController controller}) async {
 https://github.com/RaghibArshi/get_continuous_location_flutter/blob/main/HomeScreen.dart
    controller.updateIsAccessingLocation(true);
    if (!(await checkForServiceAvailability())) {
      controller.errorDescription.value = "Service not enabled";
      controller.updateIsAccessingLocation(false);

      return;
    }
    if (!(await checkForPermission())) {
      controller.errorDescription.value = "Permission not given";
      controller.updateIsAccessingLocation(false);
      return;
    }

    _location.onLocationChanged.listen((LocationData locationdata) {
      *//*print(locationdata.latitude);
      print(locationdata.longitude);*//*

      *//*final LocationData data = await _location.getLocation();*//*
      controller.updateUserLocation(locationdata);
      controller.updateIsAccessingLocation(false);

    });

  }*/
}