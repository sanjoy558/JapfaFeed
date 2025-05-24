import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/hive/databaseConstant.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/CustomerVisitorList.dart';
import 'package:japfa_feed_application/responses/DailyPlanNewCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/responses/LoginResponse.dart';
import 'package:japfa_feed_application/responses/TrackTargetStatusResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/dailyVisitFeedback.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class DailyPlanZrListController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var division_name = "".obs;
  var division_id = "".obs;
  var routeid = "".obs;
  var designation = "".obs;

  var customerVisitorlist1 = List<DailyPlanCustomers>.empty().obs;
  var customerVisitorList = List<CustomersVisitorList>.empty().obs;


  late Future<void> _launched;

  var dailyVisitFeedbackList = List<VisitFeedBackString>.empty().obs;

  var customerVisitCount=0.obs;
  var customerVisitTotalCount=0.obs;
  var customer_type="".obs;
  var customer_visitor_loginid="".obs;

  var newCustomerVisitorList = List<DailyPlanNewCustomerListResponse>.empty().obs;
  var visiblityflag="".obs;

  var trackTargeList = List<TrackTargetStatusResponse>.empty().obs;

  var Data1=false.obs;
  var Data2=false.obs;

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
      division_name.value = MainPresenter
          .getInstance()
          .userModel
          .divisionname!;
      division_id.value = MainPresenter
          .getInstance()
          .userModel
          .divisionid!;

      designation.value = MainPresenter
          .getInstance()
          .userModel
          .designation!;


      MainPresenter.getInstance().printLog("userid tushar1", userId);
      if (Get.arguments != null) {
        customer_type.value = Get.arguments['customertype'];
        customer_visitor_loginid.value = Get.arguments['loginid'];
        print('zr daily plan list : ${customer_type.value}');
        print('zr daily plan list : ${customer_visitor_loginid.value}');
        if(customer_type.value=="old_customer"){
          visiblityflag.value="1";
          getCustomerList();
        }else if(customer_type.value=="new_customer"){
          visiblityflag.value="2";
          getNewCustomerList(customer_visitor_loginid.value);
        }
      }

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
        .executeWithBearerTokenGET('api/todays-track-target-id-division/${customer_visitor_loginid.value}/${division_id.value}', tokenid)
        .then((value) {
      http.Response response = value;
      Data1.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
         DailyPlanResponse dailyPlanResponse=DailyPlanResponse.fromJson(jsonDecode(response.body));
         routeid.value=dailyPlanResponse.id.toString();
         customerVisitorlist1.value=dailyPlanResponse.customers!;
         customerVisitTotalCount.value=customerVisitorlist1.value.length;
        /*  final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => CustomerListResponse.fromJson(e)).toList();*/
          MainPresenter.getInstance()
              .printLog("customerVisitorlist1", customerVisitorlist1.value.length);
         getTrackStatusList(routeid.value);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Daily Plan', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Daily Plan', "Invalid..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      Data1.value=true;
      //openAndCloseLoadingDialog('Daily Plan', 'Please try again');
    });
  }

  void getTrackStatusList(String id) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/track-targets-update-visited-list/${id}', tokenid)
        .then((value) {
      http.Response response = value;
      Data1.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          trackTargeList.value =
              list.map((e) => TrackTargetStatusResponse.fromJson(e)).toList();

          List<String> customerIds=[];
          for (var item in trackTargeList.value) {
            customerIds.add(item.customerId.toString());
          }
          print(customerIds.length.toString());


          if(trackTargeList.length>0){
            for (var item in customerVisitorlist1.value) {
              var foundMatch = false; // Flag to track if a match is found for the current item
              for (var item2 in trackTargeList.value) {
                if (item.id.toString() == item2.customerId) {
                  customerVisitorList.add(CustomersVisitorList(
                      id: item.id.toString(),
                      firstName: item.firstName,
                      phone: item.phone,
                      addressLine1: item.addressLine1,
                      addressLine2: item.addressLine2,
                      zone: item.zone,
                      login: item.login,
                      status: "Visited"
                  ));
                  foundMatch = true; // Set flag to true indicating match found
                  break; // Exit the inner loop since a match is found
                }
              }
              if (!foundMatch) {
                customerVisitorList.add(CustomersVisitorList(
                    id: item.id.toString(),
                    firstName:item.firstName,
                    phone: item.phone,
                    addressLine1: item.addressLine1,
                    addressLine2: item.addressLine2,
                    zone: item.zone,
                    login: item.login,
                    status: "N/A"
                ));
              }
            }
          }else {
            for (var item in customerVisitorlist1.value) {
                customerVisitorList.add(CustomersVisitorList(
                    id: item.id.toString(),
                    firstName:item.firstName,
                    phone: item.phone,
                    addressLine1: item.addressLine1,
                    addressLine2: item.addressLine2,
                    zone: item.zone,
                    login: item.login,
                    status: "N/A"
                ));
            }
          }


          MainPresenter.getInstance()
              .printLog("brandlist", customerVisitorList.value.length);

          MainPresenter.getInstance()
              .printLog("productlist", customerVisitorList.value.length);
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Daily Plan', "Invalid..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      Data1.value=true;
      //openAndCloseLoadingDialog('Daily Plan', 'Please try again');
    });
  }

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void callCustomer(CustomersVisitorList dataModel) {
    if (dataModel.phone != null && dataModel.phone!.length > 0)
      _launched = _launchedyoutube(
          'tel://${dataModel.phone!}');
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


  void getNewCustomerList(String strloginid) {
    print("getNewCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/customer-enquiry-todays/${strloginid}', tokenid!)
        .then((value) {
      http.Response response = value;
      Data2.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          final list = jsonDecode(response.body) as List<dynamic>;
          newCustomerVisitorList.value =
              list.map((e) => DailyPlanNewCustomerListResponse.fromJson(e)).toList();

          MainPresenter.getInstance()
              .printLog("customerVisitorslist1", newCustomerVisitorList.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Daily Plan', "Server error");
        }
      } else {
        displayLoading.value = false;
        Data2.value=true;
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      Data2.value=true;
    });
  }
}
