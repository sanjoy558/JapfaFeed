import 'dart:async';
import 'dart:convert';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerAnalysisController.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerDashboardController.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerPurchaseOrderMainController.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/responses/DivisionResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:flutter/services.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/views/customer/customer_home_screen.dart';


class CustomerHomeController extends GetxController {

  var displayLoading = false.obs;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool positionStreamStarted = false;

  DateTime currentBackPressTime = DateTime.now();
  bool navigation_drawer_open_close = false;
  var userId = "";
  var firstname = "";
  var tokenid = "";
  var login = "";

  var userlock = "";
  var app_version = "";

  var permission="";

  var tabIndex = 2.obs;

  late CircularBottomNavigationController navigationController;

  double bottomNavBarHeight = 60;



  List<TabItem> tabItems = List.of([

    TabItem(
      Icons.bar_chart,
      "Statistics",
      Colors.orange,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
    ),
    TabItem(
      Icons.shopping_bag,
      "New Order",
      Colors.orange,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),

    ),
    TabItem(
      Icons.home,
      "Home",
      Colors.orange,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
    ),
    TabItem(
      Icons.article_rounded,
      "Brochure",
      Colors.orange,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
    ),
    TabItem(
      Icons.person,
      "Profile",
      Colors.orange,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
    ),
  ]);

  var divisionList = List<DivisionResponse>.empty().obs;
  var division_name = "".obs;
  var division_Id = "".obs;
  var division_visibility=true.obs;

  @override
  void onInit() {

    navigationController = CircularBottomNavigationController(tabIndex.value);
    if (MainPresenter
        .getInstance()
        .userModel
        .userId != null) {
      userId = MainPresenter
          .getInstance()
          .userModel
          .userId!;
      login = MainPresenter
          .getInstance()
          .userModel
          .login!;
      firstname = MainPresenter
          .getInstance()
          .userModel
          .firstName!;
      tokenid = MainPresenter
          .getInstance()
          .userModel
          .tokenid!;

      /*if(MainPresenter
          .getInstance()
          .userModel.usertype=="Customer"){
        permission = "";
      }else{
        permission = MainPresenter
            .getInstance()
            .userModel
            .permission!;
      }*/


      MainPresenter.getInstance().printLog("userid tushar1", userId);

      String per=permission.replaceAll(r'\', '');

     /* String jsonString = per.toString();
      Map<String, dynamic> jsonMap = json.decode("$jsonString");
      PermissionDeSerializing myData = PermissionDeSerializing.fromJson(jsonMap);
      print("permission jsonString${myData.po}");*/

      getDivisionList();

    }
  }

  @override
  void dispose() {
    super.dispose();
    navigationController.dispose();
  }

  void changeTabIndex(int index) {
    Get.put(CustomerHomeController());
    MainPresenter.getInstance().printLog("INDEX", index);
    tabIndex.value = index;

     if (index == 0) {
      final analysiscontroller=Get.find<CustomerAnalysisContoller>();
      if(analysiscontroller.initialized){
        analysiscontroller.onInit();
      }
    } else if (index == 1) {
      final purchaseOrderController=Get.find<CustomerPurchaseOrderMainController>();
      if(purchaseOrderController.initialized){
        purchaseOrderController.onInit();
      }
    }else if (index == 2) {
       final dashboardcontroller=Get.find<CustomerDashboardController>();
       if(dashboardcontroller.initialized){
         dashboardcontroller.onInit();
       }
     }
    update();
  }

  Future<bool> exit() {
    /* if (tabIndex != 0) {
      back();
      return Future.value(true);
    }*/
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      SystemNavigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void logoutApp() {
    if (navigation_drawer_open_close) {
      SystemNavigator.pop();
    }
    SharePrefsHelper.clearAll();
    exit();
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

  void alertDialog(String str_exit_logout) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0, right: 5.0),
                        decoration: BoxDecoration(
                            color: hometoolbarcolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${str_exit_logout}?",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "${str_exit_logout} now!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [

                          Expanded(
                            child: ElevatedButton(
                              child: Text('Yes',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: loginEmployee,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                Get.back();
                                if(str_exit_logout=="Exit"){
                                  exit();
                                }else if(str_exit_logout=="Logout"){
                                  logoutApp();
                                }

                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('No',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: loginCustomer,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getDivisionList() async {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/division/division-list/customer/${login}', tokenid!)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          divisionList.value=(jsonDecode(response.body) as List)
              .map((item) => DivisionResponse.fromJson(item))
              .toList();


          if(MainPresenter.getInstance().userModel.divisionid!=null){
            division_Id.value=MainPresenter
                .getInstance()
                .userModel
                .divisionid!;
            division_name.value=MainPresenter
                .getInstance()
                .userModel
                .divisionname!;
          }else
          {
            getDivisionSharedData(divisionList.value[0].divisionId,divisionList.value[0].divisionName);
          }

          MainPresenter.getInstance()
              .printLog("divisionList list", divisionList.value.length);
        } else {
          displayLoading.value = false;

        }
      } else {
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
    });
  }

  void getDivisionSharedData (String? divisionId,String? divisionName) async {
    var user = UserModel();
    user.usertype=MainPresenter.getInstance().userModel.usertype!;
    user.userId=MainPresenter.getInstance().userModel.userId!;
    user.login=MainPresenter.getInstance().userModel.login!;
    user.firstName=MainPresenter.getInstance().userModel.firstName!;
    user.zone=MainPresenter.getInstance().userModel.zone!;

    user.executiveId=MainPresenter.getInstance().userModel.executiveId!;
    user.executivelogin=MainPresenter.getInstance().userModel.executivelogin!;
    user.executivefirstName=MainPresenter.getInstance().userModel.executivefirstName!;
    user.executiveemail=MainPresenter.getInstance().userModel.executiveemail!;

    user.IS_LOGIN_FIRST="true";
    user.tokenid=MainPresenter.getInstance().userModel.tokenid!;

    user.divisionid=divisionId.toString();
    user.divisionname=divisionName.toString();
    MainPresenter.getInstance().userModel = user;
    SharePrefsHelper.saveUserModel(user);
    division_name.value=divisionName.toString();
    division_Id.value=divisionId.toString();

  }

  void setDivisionData(int index) {
    MainPresenter.getInstance().printLog("division name", divisionList.value[index].divisionName!);
    MainPresenter.getInstance().printLog("division id", divisionList.value[index].divisionId!);
    getDivisionSharedData(divisionList.value[index].divisionId!, divisionList.value[index].divisionName!);
    Get.offAll(() => CustomerHomeScreen());

  }
}
