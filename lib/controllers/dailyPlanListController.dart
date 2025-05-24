import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/hive/TrackTargetString.dart';
import 'package:japfa_feed_application/hive/databaseConstant.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanVisitedListResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/TrackTargetSubmitResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/dailyVisitFeedback.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:collection';

import '../responses/CustomerListResponse.dart';

class DailyPlanListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var routeid = "".obs;
  var designation = "".obs;
  var showSoListFlag = false.obs;
  var customerVisitorList = List<DailyPlanCustomers>.empty().obs;
  var customerVisitedList = List<DailyPlanVisitedListResponse>.empty().obs;

  late Future<void> _launched;

  var dailyVisitFeedbackList = List<VisitFeedBackString>.empty().obs;

  var customerVisitCount = 0.obs;
  var customerVisitTotalCount = 0.obs;

  var zr_daily_plan = false.obs;
  var Data1 = false.obs;
  var tracktargetlist = List<TrackTargetString>.empty().obs;

  Map<int, List<String>> statusDict = {};

  var division_name="".obs;
  var division_id="".obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;

      designation.value = MainPresenter.getInstance().userModel.designation!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;

      if (designation.value == "ZO") {
        showSoListFlag.value = true;
      } else {
        showSoListFlag.value = false;
      }

      if (designation.value == "ZO") {
        zr_daily_plan.value = false;
      } else {
        zr_daily_plan.value = true;
      }

      MainPresenter.getInstance().printLog("userid tushar1", userId);
      getCustomerList();
      getDataCount();
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

  void getCustomerList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/todays-track-target-division/${division_id.value}', tokenid!)
        .then((value) {
      Data1.value = true;
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          DailyPlanResponse dailyPlanResponse =
              DailyPlanResponse.fromJson(jsonDecode(response.body));
          routeid.value = dailyPlanResponse.id.toString();
          //customerVisitorList.value = dailyPlanResponse.customers!;
          customerVisitTotalCount.value = dailyPlanResponse.customers!.length;

          MainPresenter.getInstance().printLog(
              "customerVisitorslist1", customerVisitorList.value.length);

          getVisitedList(dailyPlanResponse.customers!,routeid.value);
        } else {
          displayLoading.value = false;
        }
      } else {
        displayLoading.value = false;
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Daily Plan', 'Please try again');
    });
  }

  void getVisitedList(List<DailyPlanCustomers> dailyplanlist,String routeid123) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
            'api/track-targets-update-visited-list/${routeid123}', tokenid!)
        .then((value) {
      Data1.value = true;
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        List<dynamic> jsonResponse = jsonDecode(response.body);
        customerVisitedList.value = jsonResponse
            .map((item) => DailyPlanVisitedListResponse.fromJson(item))
            .toList();

        if (customerVisitedList.value.length > 0) {
          customerVisitorList.value= updateStatuses(dailyplanlist, customerVisitedList.value);
        }else{
          customerVisitorList.value=dailyplanlist;
        }
        for (var item in customerVisitorList.value) {
          print(item.status);
        }

        refresh();
      } else {
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print("catch block : ${onError}");
      displayLoading.value = false;
    });
  }

  List<DailyPlanCustomers> updateStatuses(List<DailyPlanCustomers> originalList,
      List<DailyPlanVisitedListResponse> updatedList) {
    // Create a map from the updated list for quick lookup
    Map<int, String> updatedStatusMap = {
      for (var item in updatedList)int.parse(item.customerId!) : item.status!
    };

    // Update the statuses in the original list
    for (var item in originalList) {
      if (updatedStatusMap.containsKey(item.id)) {
        //print("${updatedStatusMap[item.id]!}");
        item.status = updatedStatusMap[item.id]!;
      }
    }

    // Return the updated original list
    return originalList;
  }

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void callCustomer(DailyPlanCustomers dataModel) {
    if (dataModel.phone != null && dataModel.phone!.length > 0)
      _launched = _launchedyoutube('tel://${dataModel.phone!}');
    FutureBuilder<void>(future: _launched, builder: _launchStatus);
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

  /* Future<String> vistedfor(Customers dataModel)async{

    if(!await LocalDataBase.instance!.query(dataModel.id.toString())){
      return Color(value);
    }
    return false;
  }*/

  Future<Color> getVistedColor(DailyPlanCustomers dataModel) async {
    Color? color = new Color(0xFF000000);

    if (!await LocalDataBase.instance!.query(dataModel.id.toString())) {
      return color = Colors.green;
      ;
    }
    return color = Colors.white;
  }

  void cancelVisit(DailyPlanCustomers dataModel) async {
    postTrackTargetData(dataModel);
  }

  void postTrackTargetData(DailyPlanCustomers dataModel) {
    Get.back();
    tracktargetlist.value.clear();
    tracktargetlist.add(TrackTargetString(
        customerId: dataModel.id.toString(),
        id: int.parse(routeid.value),
        status: "canceled"));
    print(jsonEncode(tracktargetlist.map((i) => i.toMap()).toList()));
    displayLoading.value = true;
    ApiService()
        .executeRawPOSTCustomerForm('api/track-targets-update-visit',
            jsonEncode(tracktargetlist.map((i) => i.toMap()).toList()), tokenid)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        TrackTargetSubmitResponse trackTargetSubmitResponse =
            TrackTargetSubmitResponse.fromJson(jsonDecode(response.body));
        if (trackTargetSubmitResponse.success!.length > 0) {
          tracktargetlist.value.clear();
          MainPresenter.getInstance().showToast("Visit Canceled Successfully");
          //Get.back(result: "true");

          getCustomerList();
        }
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
    });
  }

  void gotToFeedBack(DailyPlanCustomers dataModel) async {
    print(await LocalDataBase.instance!.query(dataModel.id.toString()));
    if (await SharePrefsHelper.getBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG)) {
      if (!await LocalDataBase.instance!.query(dataModel.id.toString())) {
        var data = await Get.to(() => DailyVisitFeedback(), arguments: {
          'dataModel': dataModel,
          'routeid': routeid.value,
        });

        if (data != null) {
          var backResult = data.toString();
          MainPresenter.getInstance()
              .printLog("backResult", backResult.toString());

          if (backResult.toString() == "true") {
            getDataCount();
          }

          /*couponCodeResult.value = data;
            couponAmount.value = double.parse(couponCodeResult.value.discountAmt!);*/
        }

        /*Get.to(DailyVisitFeedback(), arguments: {
            'dataModel': dataModel,
            'routeid': routeid.value,
          });*/
      } else {
        MainPresenter.getInstance().showToastLong("Feedback Already Submited");
      }
    } else {
      MainPresenter.getInstance().showToastLong("Please Start Journey!!");
    }

    /*await LocalDataBase.instance!.getAllVisitFeedBack().then((value) {
      dailyVisitFeedbackList.value = value;
      print("dailyVisitFeedbackList   ::::  ${value.length}");
      var json = jsonEncode(dailyVisitFeedbackList.value.map((e) => e.toMap()).toList());
      print(json.toString());

      for(var item in dailyVisitFeedbackList.value){
        if(item.routeId==routeid.value){
          MainPresenter.getInstance().showToastLong("Feedback Submited");
          break;
        }else{
          Get.to(DailyVisitFeedback(), arguments: {
            'dataModel': dataModel,
            'routeid': routeid.value,
          });
        }
      }

    }).catchError((e) => debugPrint(e.toString()));*/
  }

  void getDataCount() async {
    //print(await LocalDataBase.instance!.query(dataModel.id.toString()));
    customerVisitCount.value = (await LocalDataBase.instance!
        .getCount(DataBaseConstants.dailyVisitFeedbackTable))!;
    print("getDataCount: ${customerVisitorList.value}");
    getCustomerList();
  }
}
