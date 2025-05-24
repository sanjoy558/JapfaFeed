import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/hive/TrackTargetString.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/pointsTravelledString.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/hive/visitIdString.dart';
import 'package:japfa_feed_application/responses/TrackTargetSubmitResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/utils/location_service.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class DailyVisitFeedbackController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var routeid = "".obs;
  var apiwise = "".obs;
  var division_name = "".obs;
  var division_id = "".obs;

  var customers = new DailyPlanCustomers().obs;
  var customer_name = "".obs;
  var customer_address = "".obs;
  var customer_phone = "".obs;
  var customer_todays_date = "".obs;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final dateController = TextEditingController();

  final contr1 = TextEditingController();
  final contr2 = TextEditingController();
  final contr3 = TextEditingController();
  final contr4 = TextEditingController();
  final contr5 = TextEditingController();
  final contr6 = TextEditingController();
  final contr7 = TextEditingController();
  final contr8 = TextEditingController();
  final contr9 = TextEditingController();
  final contr10 = TextEditingController();
  final contr11 = TextEditingController();

  var selectedStatus = ''.obs;

  // droop dowm controllers
  var selectedDropdownValue1 = 0.obs;
  var selectedDropdownValue2 = 0.obs;
  var selectedDropdownValue3 = 0.obs;
  var selectedDropdownValue4 = 0.obs;
  var selectedDropdownValue5 = 0.obs;
  var selectedDropdownValue6 = 0.obs;
  var selectedDropdownValue7 = 0.obs;
  var selectedDropdownValue8 = 0.obs;
  var selectedDropdownValue9 = 0.obs;
  var selectedDropdownValue10 = 0.obs; // Define _selectedDropdownValue here

  // check box values
  var priceSelected = false.obs;
  var qualitySelected = false.obs;
  var serviceSelected = false.obs;
  var otherSelected = false.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var dailyVisitFeedbackList = List<VisitFeedBackString>.empty().obs;

  var tracktargetlist = List<TrackTargetString>.empty().obs;

  @override
  void onInit() {
    getLocation();
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);

      customer_todays_date.value =
          MainPresenter().getPaternWiseDate("yyyy-MM-dd");

      if (Get.arguments != null) {
        customers.value = Get.arguments['dataModel'];
        apiwise.value = Get.arguments['routeid'];
        /* routeid.value = getRoutid().toString();*/

        print(' daily visit feedback : ${customers.value.firstName}');
        customer_name.value = customers.value.firstName!;
        customer_address.value =
            customers.value.addressLine1! + "," + customers.value.addressLine2!;
        customer_phone.value = customers.value.phone!;

        print("routeid: ${routeid.value}");
        print("apiwise: ${apiwise.value}");
        getRoutid();
      }
    }
  }

  void getRoutid() async {
    routeid.value =
        await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI);
    print(' daily visit feedback routeid : ${routeid.value}');
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

  void addData() async {
    print(getFeedCriteria());
    print(latitude.toString());
    print(longitude.toString());

    Map<String, dynamic> formDataMap = {
      'address': customer_address.value.toString(),
      'customervisitfeedback': contr8.text,
      'customervisitlevel': selectedDropdownValue8.value.toString(),
      'date': MainPresenter.getInstance().getPaternWiseDate("dd-MM-yyyy"),
      'deliverytimefeedback': contr4.text,
      'deliverytimelevel': selectedDropdownValue4.value.toString(),
      'feedavailabilityfeedback': contr3.text,
      'feedavailabilitylevel': selectedDropdownValue3.value.toString(),
      'feedpricefeedback': contr2.text,
      'feedpricelevel': selectedDropdownValue2.value.toString(),
      'feedqualityfeedback': contr1.text,
      'feedqualitylevel': selectedDropdownValue1.value.toString(),
      'generalfeedback': contr11.text,
      'goodconsideration': getFeedCriteria().toString(),
      'imagefeedback': contr9.text,
      'imagelevel': selectedDropdownValue9.value.toString(),
      'mobilenumber': customer_phone.value.toString(),
      'name': customer_name.value.toString(),
      'paymentfeedback': contr5.text,
      'paymentlevel': selectedDropdownValue5.value.toString(),
      'promotionfeedback': contr7.text,
      'promotionlevel': selectedDropdownValue7.value.toString(),
      'relationfeedback': contr10.text,
      'relationlevel': selectedDropdownValue10.value.toString(),
      'status': selectedStatus.value.toString(),
      'technicalservicefeedback': contr6.text,
      'technicalservicelevel': selectedDropdownValue6.value.toString(),
      'visit_end_time': MainPresenter.getInstance().getTimeStamp(),
      'visit_start_time': MainPresenter.getInstance().getTimeStamp(),
    };

    print(jsonEncode(formDataMap));

    SharePrefsHelper.setString(
        SharePrefsHelper.VISIT_ROUTE_ID, routeid.value.toString());
    await LocalDataBase.instance!
        .insertVisitId(todo: VisitIdString(id: customers.value.id.toString()));

    await LocalDataBase.instance!.insertDailyVisitFeedback(
        todo: VisitFeedBackString(
            distance: 0.0,
            flockNumber: customers.value.id.toString(),
            latitude: latitude.value,
            longitude: longitude.value,
            operationType: "VISITED",
            remark: jsonEncode(formDataMap.toString()),
            routeId: routeid.value.toString(),
            superVisorId: userId.toString(),
            timeStamp: MainPresenter.getInstance().getTimeStamp(),
            visitDate: MainPresenter.getInstance()
                .getPaternWiseDate("yyyy-MM-dd'T'HH:mm:ss")));

    await LocalDataBase.instance!.insertPointsVisited(
        todo: PointsTravelledString(
            distance: 0.0,
            latitude: latitude.value,
            longitude: longitude.value,
            operationType: "ROUTE",
            remark: jsonEncode(formDataMap.toString()),
            routeId: routeid.value.toString(),
            superVisorId: userId.toString(),
            timeStamp: MainPresenter.getInstance().getTimeStamp(),
            visitDate: MainPresenter.getInstance()
                .getPaternWiseDate("yyyy-MM-dd'T'HH:mm:ss")));

    /*await LocalDataBase.instance!.insertTrackTarget(
        todo: TrackTargetString(customerId: customers.value.id.toString(), id:int.parse(apiwise.value), status: "visited"));*/

    tracktargetlist.value.clear();
    tracktargetlist.add(TrackTargetString(customerId: customers.value.id.toString(), id: int.parse(apiwise.value), status: "visited"));
    print(jsonEncode(tracktargetlist.map((i) => i.toMap()).toList()));
    postTrackTargetData(jsonEncode(tracktargetlist.map((i) => i.toMap()).toList()));

  }

  void postTrackTargetData(String jsondata,) {

    displayLoading.value = true;
    ApiService()
        .executeRawPOSTCustomerForm(
        'api/track-targets-update-visit', jsondata, tokenid)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        TrackTargetSubmitResponse trackTargetSubmitResponse =
        TrackTargetSubmitResponse.fromJson(jsonDecode(response.body));
        if(trackTargetSubmitResponse.success!.length>0){
          tracktargetlist.value.clear();
          Get.back(result: "true");
        }
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
    });
  }

  List getFeedCriteria() {
    var coosing_criteria = [];
    if (priceSelected.value) {
      coosing_criteria.add("Price");
    }
    if (qualitySelected.value) {
      coosing_criteria.add("Quality");
    }
    if (serviceSelected.value) {
      coosing_criteria.add("Service");
    }
    if (otherSelected.value) {
      coosing_criteria.add("Other");
    }
    return coosing_criteria;
  }

  void getLocation() async {
    LocationData? currentLocation;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.getLocation().then(
      (location) async {
        currentLocation = location;
        // call api
        if (currentLocation?.latitude != null) {
          latitude.value = currentLocation!.latitude!;
          longitude.value = currentLocation!.longitude!;
          MainPresenter.getInstance().printLog(
              "location", "latitude: $latitude \n longitude:$longitude");
        }
      },
    );
  }

  void getallVisitFeedback() async {
    Get.back();
/* await LocalDataBase.instance!.getAllVisitedIds().then((value) {
      */ /*dailyVisitFeedbackList.value = value;
      print("dailyVisitFeedbackList   ::::  ${value.length}");*/ /*


      var json = jsonEncode(value.map((e) => e.toMap()).toList());
      print(json.toString());
    }).catchError((e) => debugPrint(e.toString()));*/

    /* await LocalDataBase.instance!.getAllVisitFeedBack().then((value) {
      dailyVisitFeedbackList.value = value;
      print("dailyVisitFeedbackList   ::::  ${value.length}");


      var json = jsonEncode(dailyVisitFeedbackList.value.map((e) => e.toMap()).toList());

      print(dailyVisitFeedbackList.value[0].timeStamp);
      print(dailyVisitFeedbackList.value[0].visitDate);
      print(json.toString());
    }).catchError((e) => debugPrint(e.toString()));*/
  }
}
