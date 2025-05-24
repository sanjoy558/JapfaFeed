import
'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/pointsTravelledString.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/responses/CummulativeDataResponse.dart';
import 'package:japfa_feed_application/responses/CustomerPieChartResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/responses/DailyPlanVisitedListResponse.dart';
import 'package:japfa_feed_application/responses/DivisionResponse.dart';
import 'package:japfa_feed_application/responses/FeedBackFormInserResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse.dart';
import 'package:japfa_feed_application/responses/PlantResponse.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/responses/UserGlobalResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/LocationNotifier.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/ServiceHelper.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/utils/location_service.dart';
import 'package:japfa_feed_application/views/addplan_screen.dart';
import 'package:japfa_feed_application/views/cutomerList_Screen.dart';
import 'package:japfa_feed_application/views/goodsReceivedList_Screen.dart';
import 'package:japfa_feed_application/views/loginScreen.dart';
import 'package:japfa_feed_application/views/purchaseOrderList_Screen.dart';
import 'package:japfa_feed_application/views/trackCustomer_Screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DashboardController extends GetxController {
  var displayLoading = false.obs;
  var userType = "";
  var firstname = "";
  var tokenid = "";
  var userId = "";
  var login = "";
  var userlock = "".obs;
  var app_version = "".obs;
  var start_journey_flag = false.obs;
  var start_journey_type = "".obs;

  var latitude = "".obs;
  var longitude = "".obs;

  var customerList = List<Data>.empty().obs;
  var graphList = List<GraphData>.empty().obs;

  final textfiled_vehiclenumber = TextEditingController();
  final textfield_opening_km = TextEditingController();
  final textfield_ending_km = TextEditingController();
  final textfield_remark = TextEditingController();
  var current_latitude = "".obs;
  var current_longitude = "".obs;
  late Future<void> _launched;
  DateTime currentBackPressTime = DateTime.now();
  var selected_dropdown_object = Data().obs;
  var selected_dropdown_string = "Select Customer".obs;
 /* bool flag_user = false;*/
  var currentIntMonth = 0.obs;
  var currentIntYear = 2023.obs;

  var visited_plan_list_after = List<VisitFeedBackString>.empty().obs;
  var visit_plan_list = List<DailyPlanCustomers>.empty().obs;
  var customerVisitedList = List<DailyPlanVisitedListResponse>.empty().obs;



  var purchaseorder_list = List<PurchaseOrderResponse>.empty().obs;
  var cummulative_target = 0.0.obs;
  var cummulative_actual = 0.0.obs;
  var cummulative_total_customer = "".obs;
  var strig_current_year = "".obs;
  var todyas_purchase_order_count = 0.obs;

  var fromdate_str = "".obs;
  var todate_str = "".obs;

  /* Map<String, double> dataMap = {};*/

  /*final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];

  Map<String, double> dataMap1 = {};

  final colorList1 = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];*/

  var isAccessingLocation = false.obs;
  final RxString errorDescription = RxString("");

  final homeController = Get.find<HomeController>();

  var trackTarget;
  var visitedCustomer;
  var visitedCustomerFeedback;
  var pointstravelled;

  final RxList<Position> coordinates = <Position>[].obs;
  late StreamSubscription<Position> locationSubscription;
  var totalDistance = 0.0.obs;
  var distanceInMeters = 0.0.obs;
  int positionCount = 0;
  Position? firstPosition;
  String purchase_uuid = "";

  String deviceid = "";
  var uuid = Uuid();

  var plantlsit = List<PlantResponse>.empty().obs;
  var plantlsit_saved = List<PlantResponse>.empty().obs;

  var journeyTypeList = List<String>.empty().obs;
  var selected_dropdown_journeytype = "Own Vehicle".obs;

  //DateTime endOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 00, 00);


  var division_id="".obs;
  var division_name="".obs;

  var journeycount=0.obs;
  var designation="".obs;
  var punchinn_time="".obs;
  var punchout_time="".obs;

  @override
  void onInit() {
    LocationService.instance.getUserLocation(controller: this);
    initDb();
    if (MainPresenter.getInstance().userModel.userId != null) {
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      userId = MainPresenter.getInstance().userModel.userId!;
      login = MainPresenter.getInstance().userModel.login!;
      userType = MainPresenter.getInstance().userModel.usertype!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      MainPresenter.getInstance().printLog("userid tushar1", "${userId}");
      designation.value=MainPresenter.getInstance().userModel.designation!;

      FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

      _firebaseMessaging.getToken().then((token) {
        print("token is $token");
        deviceid = token.toString();
      });
      journeyTypeList.clear();
      journeyTypeList.add("Own Vehicle");
      journeyTypeList.add("Public Transport");
      getFunction();
    }
    //initDb();

    loginUserDetails();
    getyear();
    getUserGlobalData();
    getCummulativeData();
    getPurchaseOrderList();
    //getCustomerPieChartData();
    //getChartData(login,getDate().toString());
    //getl();
  }

  Future<void> requestNotificationPermission(BuildContext context) async {
    if (Platform.isAndroid && (await _isAndroid13OrAbove())) {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notification permission granted')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notification permission denied')),
        );
      }
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    return (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33;
  }

  Future<bool> checkNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    return status.isGranted;
  }

  void updateIsAccessingLocation(bool b) {
    isAccessingLocation.value = b;
  }

  void initDb() async {
    //await _location.changeSettings(accuracy: LocationAccuracy.high,interval: 1000,distanceFilter: 0);
    await LocalDataBase.instance?.database;
    totalDistance.value =
        await SharePrefsHelper.getDouble(SharePrefsHelper.TOTAL_KM);

    print(
        "database created or not : ${await LocalDataBase.instance!.databaseExists()}");

   /* bool isEmpty = await LocalDataBase.instance!
        .isTableEmpty(DataBaseConstants.tableplant);
    if (isEmpty) {
      getPlantList();
    }*/
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

  Future<void> versionAndLockDialog(
      String lock_version, String title, String msg) async {
    Get.defaultDialog(title: title, content: Text("$msg"), actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'))
    ]);
  }

  void loginUserDetails() {
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/account', tokenid!)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        UserDetailsResponse userDetailsResponse =
            UserDetailsResponse.fromJson(jsonDecode(response.body));
        if (userDetailsResponse.id != null) {
          if(userDetailsResponse.activated==false){
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
                      content: Text('Inactive User'),
                      actions: <Widget>[
                        GestureDetector(
                          onTap: () {
                            exit();
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
          }

         /* if (userDetailsResponse.deviceid == deviceid) {

          } else {
            SharePrefsHelper.clearAll();
            await LocalDataBase.instance!.cleanDatabase(0);
            Get.offAll(() => LoginScreen());
          }*/
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Login', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Login', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }

  void goTOCustomer() {
    Get.to(() => CustomerListScreen());
  }

  void goToGoodsRecived() {

    Get.to(() => GoodsReceivedListScreen());
    /*if (flag_user == false) {
      Get.to(() => GoodsReceivedListCustomerScreen());
    } else {

    }*/
  }

  void gotoAddPlan() {
    Get.to(() => AddPlanScreen());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void purchaseorder() {
    //Get.to(() => PurchaseOrderListScreen(),arguments:'storeName');
    Get.to(() =>
            PurchaseOrderListScreen() /*,arguments:{
      "storeName":"tushar",
      "rajput":"rajput"
    }*/
        );
    //MainPresenter.getInstance().printLog("userlocation get data: ",userlocationlist.value.toString());
  }

  String initializeDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print("todyas date is : ${formattedDate}");
    return formattedDate.toString();
  }

  /* Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }*/

 /* void getChartData(String loginid, String stringDate) {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
            'api/target-actual-master/get/$loginid/$stringDate', tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;

        GraphDataResponse graphDataResponse =
            GraphDataResponse.fromJson(jsonDecode(response.body));
        if (graphDataResponse != null) {
          //print(userGlobalResponse.data!.version);
          graphList.value = graphDataResponse.data!;
          print("graphList list ${graphList.value.length}");
          iniliseFirstPieChart();
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('User Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        openAndCloseLoadingDialog('User Data', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('User Data', 'Please try again');
    });
  }

  void getCustomerPieChartData() {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/customer-sales/all', tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;

        CustomerPieChartResponse customerPieChartResponse =
            CustomerPieChartResponse.fromJson(jsonDecode(response.body));
        if (customerPieChartResponse != null) {
          //print(userGlobalResponse.data!.version);
          customerList.value = customerPieChartResponse.data!;
          print("customer list ${customerList.value.length}");
          selected_dropdown_object.value = customerList.value[0];
          selected_dropdown_string.value = customerList.value[0].id.toString();
          iniliseSecondPieChart();
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('User Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        openAndCloseLoadingDialog('User Data', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('User Data', 'Please try again');
    });
  }*/

  void getUserGlobalData() {
    displayLoading.value = true;
    ApiService()
          .executeWithBearerTokenGET('api/api-version/getactive', tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        UserGlobalResponse userGlobalResponse =
            UserGlobalResponse.fromJson(jsonDecode(response.body));
        if (userGlobalResponse != null) {
          //print(userGlobalResponse.data!.version);
          userlock.value = userGlobalResponse.data!.lock.toString();
          app_version.value = userGlobalResponse.data!.version.toString();
          appVersionDialog();
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('User Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('User Data', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('User Data', 'Please try again');
    });
  }

  Future<void> appVersionDialog() async {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String packageName = packageInfo.packageName;
    print("tushar $version");*/
    print("tushar ${app_version.value}");
    if (appversion_version != app_version.value.toString()) {
      showDialog(
          context: Get.context as BuildContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                title: Text('Feed Connect'),
                content: Text('Please update to new version'),
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                    /*  Get.back();
                      if (Platform.isAndroid) {
                        _launched = _launchedyoutube(
                            "https://play.google.com/store/apps/details?id=" +
                                packageName);
                        FutureBuilder<void>(
                            future: _launched, builder: _launchStatus);
                      } else {
                        _launched =
                            _launchedyoutube('https://apps.apple.com/app/id');
                        FutureBuilder<void>(
                            future: _launched, builder: _launchStatus);
                      }*/

                      exit();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            );
          });
    }

    if (appversion_version == app_version.value && userlock.value == "true") {
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
                content: Text('User locked by admin'),
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      exit();
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
    }
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

  Future<bool> exit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      SystemNavigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void iniliseFirstPieChart() {
    if (graphList.length > 0) {
      /* dataMap.addAll({
        'Achived': graphList[0].actual!.toDouble(),
        'Pending': graphList[0].target!.toDouble()-graphList[0].actual!.toDouble()
      });*/
    }
  }

  void iniliseSecondPieChart() {
    if (graphList.length > 0) {
      /* dataMap1.addAll({
        'Achived': graphList[0].actual!.toDouble(),
        'Pending': graphList[0].target!.toDouble()-graphList[0].actual!.toDouble()
      });*/
    }
  }

  void setSelected(Data data) {
    selected_dropdown_string.value = data.id.toString();
    /* dataMap1.clear();
    dataMap1.addAll({
      'Achived': data.achieveTarget!.toDouble(),
      'Pending': data.pendingTarget!.toDouble()
    });*/
  }

  String getDate() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy/MM');
    String todays_date = formatter.format(now);
    //todays_date
    print("todyas date is : ${todays_date}");
    return todays_date;
  }

  String getyear() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy');
    var formatter_date = new DateFormat('yyyy-MM-dd');

    String year = formatter.format(now);
    String todays_date = formatter_date.format(now);
    //todays_date
    strig_current_year.value = year;
    fromdate_str.value = todays_date;
    todate_str.value = todays_date;
    print("year is : ${year} and date : ${todays_date}");
    return todays_date;
  }

  String getTime() {
    DateTime now = DateTime.now();
    //var formatter = new DateFormat('Hm');//24 hours
    var formatter_time = new DateFormat('h:mm a', 'en_IN');//12 hours
    String time = formatter_time.format(now);
    MainPresenter.getInstance().printLog("Time", time);
    return time;
  }

  void selectDateAndModifyPichart() {
    //getChartData(login, (currentIntYear.toString() + "/" + currentIntMonth.toString()));
  }

  //cummulative_data
  void getCummulativeData() {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
            'api/target-actual-master/get-aggregate1-division/${login}/${strig_current_year.value}/${division_id.value}',
            tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        CummulativeDataResponse cummulativeDataResponse =
            CummulativeDataResponse.fromJson(jsonDecode(response.body));
        if (cummulativeDataResponse != null) {
          //print(userGlobalResponse.data!.version);
          cummulative_target.value = cummulativeDataResponse.data![0].target!;
          cummulative_actual.value = cummulativeDataResponse.data![0].actual!;
          cummulative_total_customer.value =
              cummulativeDataResponse.data![0].totalCustomer!;
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Cummulative Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Cummulative Data', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Cummulative Data', 'Please try again');
    });
  }

  void getPurchaseOrderList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    Map<String, dynamic> paramsMaps = {
      'startDate': fromdate_str.value.toString(),
      'endDate': todate_str.value.toString(),
      'divisionId':division_id.value
    };
    ApiService()
        .executeWithBearerTokenGETAndParam(
            'api/mobile/purchase-order-hds-date-division', tokenid!, paramsMaps)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          purchaseorder_list.value =
              list.map((e) => PurchaseOrderResponse.fromJson(e)).toList();
          todyas_purchase_order_count.value = purchaseorder_list.value.length;

          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
          //checkIfDayEnds();
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void submitEndJourney(bool flag) async {

    ServiceHelper.stopService();



    /*if(selected_dropdown_journeytype.value=="Own Vehicle"){
      if(validateEndJourney()){
        //getDailyPlanList();
        getAllLocations(0);
      }
    }else if(selected_dropdown_journeytype.value=="Public Transport"){
      //getDailyPlanList();
      getAllLocations(0);
    }*/


    /*start_journey_flag.value = false;
    SharePrefsHelper.setBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG, false);*/
  }

  void endJourney() async{

    if(selected_dropdown_journeytype.value=="Own Vehicle"){

      getAllLocations(0);
     /* if(validateEndJourney()){
        //getDailyPlanList();

      }*/
    }else if(selected_dropdown_journeytype.value=="Public Transport"){
      //getDailyPlanList();
      getAllLocations(0);
    }


    /*start_journey_flag.value = false;
    SharePrefsHelper.setBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG, false);
    SharePrefsHelper.setDouble(SharePrefsHelper.TOTAL_KM, 0.0);
    SharePrefsHelper.clearOne(SharePrefsHelper.PURCHASE_ORDER_UUDI);
    homeController.total_km.value = 0.0;
    totalDistance.value = 0.0;
    MainPresenter.getInstance().showToast("Data Inserted!!");
    await LocalDataBase.instance!.cleanDatabase(0);*/
  }

  void submitStartJourney(bool flag) async {
    MainPresenter.getInstance().printLog('submitStartJourney', flag.toString());
    /*https://github.com/vagish1/Acess-Location/blob/main/lib/main.dart*/
    if (await LocationService.instance.checkForPermission()) {
      if (await LocationService.instance.checkForServiceAvailability()) {

        if(selected_dropdown_journeytype.value=="Own Vehicle"){
          if(validateStartJourney()){
            Get.back();
            punchinn_time.value=getTime();
            punchout_time.value="--:--";
            SharePrefsHelper.setString(SharePrefsHelper.PUNCHINN_TIME,
                punchinn_time.value);
            SharePrefsHelper.setString(SharePrefsHelper.PUNCHOUT_TIME,
                punchout_time.value);

            SharePrefsHelper.setString(SharePrefsHelper.USER_START_JOURNEY_TYPE,
                selected_dropdown_journeytype.value);

            SharePrefsHelper.setBool(
                SharePrefsHelper.USER_START_JOURNEY_FLAG, flag);

            SharePrefsHelper.setString(SharePrefsHelper.VISIT_START_TIME,
                MainPresenter.getInstance().getTimeStamp());

            SharePrefsHelper.setString(
                SharePrefsHelper.VISIT_DATE, initializeDate());

            SharePrefsHelper.setString(SharePrefsHelper.VISIT_VEHICLE_NUMBER,
                textfiled_vehiclenumber.text.toString());

            SharePrefsHelper.setString(SharePrefsHelper.VISIT_OPENING_KM,
                textfield_opening_km.text.toString());

            SharePrefsHelper.setString(
                SharePrefsHelper.VISIT_REMARK, textfield_remark.text.toString());
            getFunction();
          }
        } else if(selected_dropdown_journeytype.value=="Public Transport"){
          Get.back();

          punchinn_time.value=getTime();
          punchout_time.value="--:--";
          SharePrefsHelper.setString(SharePrefsHelper.PUNCHINN_TIME,
              punchinn_time.value);

          SharePrefsHelper.setString(SharePrefsHelper.PUNCHOUT_TIME,
              punchout_time.value);

          SharePrefsHelper.setString(SharePrefsHelper.USER_START_JOURNEY_TYPE,
              selected_dropdown_journeytype.value);

          SharePrefsHelper.setBool(
              SharePrefsHelper.USER_START_JOURNEY_FLAG, flag);

          SharePrefsHelper.setString(SharePrefsHelper.VISIT_START_TIME,
              MainPresenter.getInstance().getTimeStamp());

          SharePrefsHelper.setString(
              SharePrefsHelper.VISIT_DATE, initializeDate());

          SharePrefsHelper.setString(SharePrefsHelper.VISIT_VEHICLE_NUMBER,
              "0");

          SharePrefsHelper.setString(SharePrefsHelper.VISIT_OPENING_KM,
              "0");

          SharePrefsHelper.setString(
              SharePrefsHelper.VISIT_REMARK, textfield_remark.text.toString());
          getFunction();

        }

      } else {
        MainPresenter.getInstance().printLog('TAG', "Service disable");
      }
    } else {
      MainPresenter.getInstance().printLog('TAG', "permission not given");
    }
  }


  bool validateStartJourney() {
    if (textfiled_vehiclenumber.text.isEmpty) {
      MainPresenter.getInstance().showToast("Inalid Vehicle Number");
      return false;
    }/* else if (textfield_opening_km.text.isEmpty) {
      MainPresenter.getInstance().showToast("Inalid KM");
      return false;
    }*/ else {
      return true;
    }
  }

  bool validateEndJourney() {
     if (textfield_ending_km.text.isEmpty) {
      MainPresenter.getInstance().showToast("Inalid KM");
      return false;
    } else {
      return true;
    }
  }

  void getFunction() async {
    await initializeDateFormatting('en_IN', null);
    punchinn_time.value = await SharePrefsHelper.getString(SharePrefsHelper.PUNCHINN_TIME);
    punchout_time.value = await SharePrefsHelper.getString(SharePrefsHelper.PUNCHOUT_TIME);






    MainPresenter.getInstance().printLog("punch time", punchout_time.value);

    if(punchinn_time.value.isEmpty || punchinn_time.value==null){
      punchinn_time.value="--:--";
    }
    if(punchout_time.value.isEmpty || punchout_time.value==null){
      punchout_time.value="--:--";
    }

    MainPresenter.getInstance().printLog("punch inn time", punchinn_time.value);
    MainPresenter.getInstance().printLog("punch out time", punchout_time.value);

    if (await SharePrefsHelper.getBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG)) {
      //MainPresenter.getInstance().showToast(start_journey_flag.value.toString());
      start_journey_flag.value = true;
      totalDistance.value =
          await SharePrefsHelper.getDouble(SharePrefsHelper.TOTAL_KM);
      selected_dropdown_journeytype.value=await SharePrefsHelper.getString(SharePrefsHelper.USER_START_JOURNEY_TYPE);
      purchase_uuid =
      await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI);
      if (purchase_uuid.isEmpty) {
        purchase_uuid = uuid.v1();
        SharePrefsHelper.setString(
            SharePrefsHelper.PURCHASE_ORDER_UUDI, purchase_uuid);

        print(
            "Purchase Order uuid :  ${await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI)}");
      }
      //getContinuousLocation();
      ServiceHelper.initializeService().then((_) {
        ServiceHelper.startService();
        /*locationNotifier.addListener(() {
          if (locationNotifier.latitude != null && locationNotifier.longitude != null) {
            print('Latitude: ${locationNotifier.latitude}, Longitude: ${locationNotifier.longitude}');
          }
        });*/
      });
    } else {
      start_journey_flag.value = false;
    }
  }

  void updateLocation(double latitude, double longitude) {
    // Handle the location update
    print("Latitude: $latitude, Longitude: $longitude");
  }

  void getContinuousLocation() async {
    purchase_uuid =
        await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI);
    if (purchase_uuid.isEmpty) {
      purchase_uuid = uuid.v1();
      SharePrefsHelper.setString(
          SharePrefsHelper.PURCHASE_ORDER_UUDI, purchase_uuid);

      print(
          "Purchase Order uuid :  ${await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI)}");
    }

    locationSubscription = Geolocator.getPositionStream().listen((Position position) async {
      positionCount++;

      if (positionCount == 1) {
        // Save the first position
        firstPosition = position;
      } else if (positionCount == 5) {
        // Check the distance for the 10th position
        if (firstPosition != null) {
          distanceInMeters.value = Geolocator.distanceBetween(
            firstPosition!.latitude,
            firstPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          if (distanceInMeters.value > 10) {
            //MainPresenter.getInstance().showToastLong('${distanceInMeters.value}');

            totalDistance.value +=
                distanceInMeters.value / 1000; // Converting to km
            String inString = totalDistance.value.toStringAsFixed(2);
            homeController.total_km.value = double.parse(inString);
            SharePrefsHelper.setDouble(
                SharePrefsHelper.TOTAL_KM, homeController.total_km.value);

            await LocalDataBase.instance!.insertPointsVisited(
                todo: PointsTravelledString(
                    distance: double.parse(inString),
                    latitude: position.latitude,
                    longitude: position.longitude,
                    operationType: "ROUTE",
                    remark: "",
                    routeId: purchase_uuid.toString(),
                    superVisorId: userId.toString(),
                    timeStamp: MainPresenter.getInstance().getTimeStamp(),
                    visitDate: MainPresenter.getInstance()
                        .getPaternWiseDate("yyyy-MM-dd'T'HH:mm:ss")));
          } /*else {
            //MainPresenter.getInstance().showToastLong('Distance is not greater than 2 meters.');
          }*/
        }
        // Reset the counter for the next cycle
        positionCount = 0;
      }
    });
  }

  getAllLocations(int pending) async {
    /*start_journey_flag.value = false;
    SharePrefsHelper.setBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG, false);*/

    await LocalDataBase.instance!.getAllVisitFeedBack().then((value) {
      visited_plan_list_after.value.clear();
      visitedCustomerFeedback = value.map((e) => e.toMap()).toList();
      visited_plan_list_after.value=value;

    }).catchError((e) => debugPrint(e.toString()));
    String visitedCustomerFeedback1 = jsonEncode(visitedCustomerFeedback);
    MainPresenter.getInstance().printLog("visited feedback", visitedCustomerFeedback1);

    if(validateDailyPlanData(pending)){
      await LocalDataBase.instance!.getAllTrackTarget().then((value) {
        trackTarget = value;
      }).catchError((e) => debugPrint(e.toString()));

      MainPresenter.getInstance().printLog("target", jsonEncode(trackTarget.map((i) => i.toMap()).toList()));

      await LocalDataBase.instance!.getAllVisitedIds().then((value) {
        visitedCustomer = value.map((e) => e.toMap()).toList();
      }).catchError((e) => debugPrint(e.toString()));

      /*await LocalDataBase.instance!.getAllPointsTravelled().then((value) {
        pointstravelled = value.map((e) => e.toMap()).toList();
      }).catchError((e) => debugPrint(e.toString()));*/

      await LocalDataBase.instance!.getAllPointsTravelled().then((value) {
        pointstravelled = value.map((e) {
          var map = e.toMap();
          // Update each map here as needed
          // For example, let's say you want to add a new key-value pair
          map['superVisorId'] = userId;
          return map;
        }).toList();
      }).catchError((e) => debugPrint(e.toString()));

      String totalPoints = jsonEncode(pointstravelled);
      MainPresenter.getInstance().printLog("visited totalPoints", totalPoints);

      String customervisit = jsonEncode(visitedCustomer);

      Map<String, dynamic> visitor = {'id': int.parse(userId)};
      Map<String, dynamic> formDataMap = {
        'endingKm': selected_dropdown_journeytype.value=="Own Vehicle"?textfield_ending_km.text.toString()!:"0",
        'customers': visitedCustomer,
        'customersVisited': visitedCustomerFeedback1,
        'endTime': MainPresenter.getInstance().getTimeStamp(),
        'noOfPoints': "",
        'startingKm':
        await SharePrefsHelper.getString(SharePrefsHelper.VISIT_OPENING_KM),
        'pointsTravelled': totalPoints,
        'remark': await SharePrefsHelper.getString(SharePrefsHelper.VISIT_REMARK),
        'routId':
        await SharePrefsHelper.getString(SharePrefsHelper.VISIT_ROUTE_ID),
        'startTime':
        await SharePrefsHelper.getString(SharePrefsHelper.VISIT_START_TIME),
        'superVisorId': userId,
        'vehicleNumber': await SharePrefsHelper.getString(
            SharePrefsHelper.VISIT_VEHICLE_NUMBER),
        'date': MainPresenter.instance!.getPaternWiseDate("yyyy-MM-dd"),
        'visitor': visitor
      };
      postTrackTargetData(jsonEncode(formDataMap));
    }
    







  }

  void trackCustomer() async {
    //await LocalDataBase.instance!.cleanDatabase(0);
    //locationSubscription.cancel();

    Get.to(TrackCustomerScreen());
  }


  bool validateDailyPlanData(int pending) {
    if (visited_plan_list_after.value.length<1) {
      MainPresenter.getInstance().showToast("Visit in daily plan is required.");
      return false;
    }/*else if (pending>0) {
      MainPresenter.getInstance().showToast("${pending} Customer needs visit/cancel in daily plan.");
      return false;
    }*/else {
      return true;
    }
  }
  void postFeedBackData(List coosing_criteria) {
    //log(jsonEncode(coosing_criteria));
    displayLoading.value = true;
    ApiService()
        .executeRawPOSTCustomerForm(
            'api/track-visits-list', coosing_criteria.toString(), tokenid)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        FeedBackFormInserResponse feedBackFormInserResponse =
            FeedBackFormInserResponse.fromJson(jsonDecode(response.body));
        int abc = feedBackFormInserResponse.success!.length;

        if (abc > 0) {
          start_journey_flag.value = false;
          SharePrefsHelper.setBool(
              SharePrefsHelper.USER_START_JOURNEY_FLAG, false);
          SharePrefsHelper.setDouble(SharePrefsHelper.TOTAL_KM, 0.0);
          SharePrefsHelper.clearOne(SharePrefsHelper.PURCHASE_ORDER_UUDI);
          homeController.total_km.value = 0.0;
          totalDistance.value = 0.0;
          MainPresenter.getInstance().showToast("Data Inserted!!");
          await LocalDataBase.instance!.cleanDatabase(0);

          punchout_time.value=getTime();
          SharePrefsHelper.setString(SharePrefsHelper.PUNCHOUT_TIME,
              punchout_time.value);
          /*locationSubscription.cancel();*/

        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('PostData', "Server Error..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('PostData', 'Server Error1');
    });
  }

  void postTrackTargetData(/*String jsondata,*/String feedbackdata) {
    //log(jsonEncode(coosing_criteria));

    var coosing_criteria = [];
    coosing_criteria.add(feedbackdata);
    postFeedBackData(coosing_criteria);

   /* displayLoading.value = true;
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
          var coosing_criteria = [];
          coosing_criteria.add(feedbackdata);
          postFeedBackData(coosing_criteria);
        }

      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
    });*/
  }


  void getDailyPlanList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/todays-track-target', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          visit_plan_list.value.clear();
          DailyPlanResponse dailyPlanResponse=DailyPlanResponse.fromJson(jsonDecode(response.body));
          visit_plan_list.value=dailyPlanResponse.customers!;

          MainPresenter.getInstance()
              .printLog("visit_plan_list", visit_plan_list.value.length);
          getVisitedList(visit_plan_list.value,dailyPlanResponse.id.toString());



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

  void getVisitedList(List<DailyPlanCustomers> dailyplanlist,String routeid123) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
        'api/track-targets-update-visited-list/${routeid123}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        List<dynamic> jsonResponse = jsonDecode(response.body);
        customerVisitedList.value = jsonResponse
            .map((item) => DailyPlanVisitedListResponse.fromJson(item))
            .toList();
        if (customerVisitedList.value.length > 0) {
          visit_plan_list.value= updateStatuses(dailyplanlist, customerVisitedList.value);
        }else{
          visit_plan_list.value=dailyplanlist;
        }
        refresh();
        int pending=0;
        for (var item in visit_plan_list.value) {
          print(item.status);
          if(item.status=="Pending"){
            pending=pending+1;
          }
        }

        print("pending locations ${pending}");

        //getAllLocations(pending);

      } else {
        displayLoading.value = false;
      }
    }).catchError((onError) {
      print(onError);
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

  void getAllPointsTravelled() async {
    await LocalDataBase.instance!.getAllPointsTravelled().then((value) {
      pointstravelled = value.map((e) => e.toMap()).toList();
    }).catchError((e) => debugPrint(e.toString()));
    String points = jsonEncode(pointstravelled);
    log(points);
  }

/* Future<Position> getPositionFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];

        return Position(
          longitude: longitude,
          latitude: latitude,
          timestamp: DateTime.now(),  // You can set the timestamp accordingly
          accuracy: 0.0,  // Set as needed
          altitude: 0.0,  // Set as needed
          heading: 0.0,  // Set as needed
          speed: 0.0,  // Set as needed
          speedAccuracy: 0.0,  // Set as needed
          floor: null,  // Set as needed
          isMocked: false,  // Set as needed
        );
      } else {
        // Handle the case when no placemark is found
        return Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          floor: null,
          isMocked: false,
        );
      }
    } catch (e) {
      // Handle any errors that might occur during the geocoding process
      print('Error: $e');
      return Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        floor: null,
        isMocked: false,
      );
    }
  }*/

  void getPlantList() async {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/plants/code/${10}', tokenid!)
        .then((value) async {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          var list = jsonDecode(response.body) as List<dynamic>;
          plantlsit.value = list.map((e) => PlantResponse.fromJson(e)).toList();
          for (var jsonData in plantlsit) {
            await LocalDataBase.instance!.insertAllPlants(
                todo: PlantResponse(
                    id: jsonData.id,
                    name: jsonData.name,
                    code: jsonData.code,
                    plantCode: jsonData.plantCode,
                    person: jsonData.person,
                    address: jsonData.address,
                    zip: jsonData.zip,
                    district: jsonData.district));
          }

          await LocalDataBase.instance!.getAllPlants().then((value) {
            /*List<dynamic> dynamicList = [PlantResponse(), PlantResponse()];
            dynamicList = value.map((e) => e.toJson()).toList();
            plantlsit_saved.value =dynamicList.cast<PlantResponse>();*/
            plantlsit_saved.value =
                (value.map((e) => e.toJson()).toList()).cast<PlantResponse>();
            MainPresenter.getInstance().printLog(
                "plantlsitttttttttttttttttttttt", plantlsit_saved.value.length);
          }).catchError((e) => debugPrint(e.toString()));
          MainPresenter.getInstance()
              .printLog("plantlsit", plantlsit.value.length);
        } else {
          displayLoading.value = false;
          openAndCloseLoadingDialog('Plant', "Server error");
        }
      } else {
        displayLoading.value = false;
        openAndCloseLoadingDialog('Plant', "Server error");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      openAndCloseLoadingDialog('Plant', 'Please try again');
    });
  }

  Future<int> getPlanListCount() async {
    print("getPlanListCount : ${tokenid}");

    int plancount = 0;
    displayLoading.value = true;

    try {
      http.Response response = await ApiService().executeWithBearerTokenGET(
          'api/todays-track-target-division/${division_id.value}', tokenid!
      );

      displayLoading.value = false;

      if (response.statusCode == 200) {
        if (response.body != null) {
          DailyPlanResponse dailyPlanResponse = DailyPlanResponse.fromJson(jsonDecode(response.body));
          plancount = dailyPlanResponse.customers!.length;
          MainPresenter.getInstance().printLog(
              "Journey Plan Count", dailyPlanResponse.customers!.length.toString()
          );
        }
      }
    } catch (onError) {
      print(onError);
      displayLoading.value = false;
    }

    return plancount;
  }





  /*void checkIfDayEnds() {
    DateTime now = DateTime.now();
    if (now.isAfter(endOfDay)) {
      MainPresenter.getInstance().showErrorToast("hi");
      endJourneyalertDialog(false,"auto");
    }
  }*/

  /*void endJourneyalertDialog(bool dismissable,String dialogtype) {
    Get.dialog(
      WillPopScope(
        onWillPop: ()=>Future.value(false),
        child: Column(
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
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "End Journey",
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
                          " End journey now!!",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ending KM',
                                hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400)),
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            controller: textfield_ending_km,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text('Cancel',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600)),
                                style: ElevatedButton.styleFrom(
                                  primary: loginCustomer,
                                  onPrimary: const Color(0xFFFFFFFF),
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                child: Text('End Now',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600)),
                                style: ElevatedButton.styleFrom(
                                  primary: loginEmployee,
                                  onPrimary: const Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Get.back();
                                  submitEndJourney(false);

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
      ),
      barrierDismissible: dismissable,
    );
  }*/
}
//https://stackoverflow.com/questions/60920079/location-onchange-function-keeps-getting-called-even-when-location-is-static-fl
