import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/locationString.dart';
import 'package:japfa_feed_application/responses/CustomerCummulativeDataResponse.dart';
import 'package:japfa_feed_application/responses/CustomerPoAcceptCancelResponse.dart';
import 'package:japfa_feed_application/responses/FeedBackFlagResponse.dart';
import 'package:japfa_feed_application/responses/FeedBackSubmitResponse.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/responses/UserDetailsResponse.dart';
import 'package:japfa_feed_application/responses/UserGlobalResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/addplan_screen.dart';
import 'package:japfa_feed_application/views/customer/customerEditPurchaseOrderMain_Screen.dart';
import 'package:japfa_feed_application/views/customer/customerPurchaseOrderList_Screen.dart';
import 'package:japfa_feed_application/views/customer/goodsReceivedListCustomer_Screen.dart';
import 'package:japfa_feed_application/views/cutomerList_Screen.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:japfa_feed_application/views/loginScreen.dart';
import 'package:japfa_feed_application/views/purchaseOrderList_Screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:japfa_feed_application/utils/Constants.dart';

class CustomerDashboardController extends GetxController {
  var displayLoading = false.obs;
  var userType = "";
  var firstname = "";
  var tokenid = "";
  var userId = "";
  var login = "";
  var userlock = "".obs;
  var app_version = "".obs;
  var division_id = "".obs;
  var division_name = "".obs;

  var latitude = "".obs;
  var longitude = "".obs;
  late LocationSettings locationSettings;

  var userlocationlist = List<LocationString>.empty().obs;


  var customerPurchaseOrderList = List<PurchaseOrderResponse>.empty().obs;
  var customerPurchaseListDataFalg=false.obs;

  final textfiled_vehiclenumber = TextEditingController();
  final textfield_opening_km = TextEditingController();
  final textfield_remark = TextEditingController();
  var current_latitude = "".obs;
  var current_longitude = "".obs;
  late Future<void> _launched;
  DateTime currentBackPressTime = DateTime.now();
  /*var selected_dropdown_object = Data().obs;
  var selected_dropdown_string = "Select Customer".obs;*/


  var strig_current_year = "".obs;

  var cummulative_target = 0.0.obs;
  var cummulative_actual = 0.0.obs;


  Map<String, double> dataMap = {
    "Achived": 70000,
    "Pending": 30000,
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];

  Map<String, double> dataMap1 = {};

  final colorList1 = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];

  String deviceid="";

  var flagShowFeedbackDialog=false.obs;
  final customer_remarkTextEdit = TextEditingController();
  var feedbackRating=0.0.obs;

  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      userType = MainPresenter.getInstance().userModel.usertype!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      login = MainPresenter.getInstance().userModel.login!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);

      FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

      _firebaseMessaging.getToken().then((token){
        print("token is $token");
        deviceid=token.toString();
      });

      /*initDb();*/
    }
    //loginUserDetails();
    getyear();
    initDb();
    getUserGlobalData();
    /*getCustomerPieChartData();*/
    getCustomerPurchaseList();
    getCummulativeData();
    //getl();

    if(!feedbackdialog){
      getFeedBackFlagResponse();
    }

  }

  void initDb() async {
    await LocalDataBase.instance?.database;

    print(
        "database created or not : ${await LocalDataBase.instance!.databaseExists()}");
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
        UserDetailsResponse userDetailsResponse = UserDetailsResponse.fromJson(jsonDecode(response.body));
        if (userDetailsResponse.id != null) {

          if(userDetailsResponse.deviceid==deviceid){

          }else
          {
            SharePrefsHelper.clearAll();
            await LocalDataBase.instance!.cleanDatabase(0);
            Get.offAll(() => LoginScreen());
          }
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

  void goTOCustomer() {
    Get.to(() => CustomerListScreen());
  }

  void goToGoodsRecived() {
    Get.to(() => GoodsReceivedListCustomerScreen());
  }

  void gotoAddPlan() {
    Get.to(() => AddPlanScreen());
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*void getl() async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    //await BackgroundLocation.setAndroidConfiguration(1000);
    BackgroundLocation.startLocationService();
    await BackgroundLocation.setAndroidConfiguration(1000);
    BackgroundLocation.getLocationUpdates((location) {
      latitude.value = location.latitude.toString();
      longitude.value = location.longitude.toString();

      print('''\n
                        Latitude1:  $latitude
                        Longitude1: $longitude
                      
                ''');

      insertlocation(latitude.value, longitude.value);
    });
  }*/

  void purchaseorder() {
    Get.to(() => CustomerPurchaseOrderListScreen());
    //MainPresenter.getInstance().printLog("userlocation get data: ",userlocationlist.value.toString());
  }

 /* void getAllLocations() async {
    await LocalDataBase.instance!.getAllUserLocation().then((value) {
      userlocationlist.value = value;
    }).catchError((e) => debugPrint(e.toString()));
  }*/

 /* void insertlocation(String latitude1, String longitude1) async {
    LocationString locationString =
        new LocationString(userlatitude: latitude1, userlongitude: longitude1);
    print('tushar');
    print(locationString.toString());
    if (locationString != null) {
      await LocalDataBase.instance!.insertLocation(todo: locationString);
    }
  }*/

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print("todyas date is : ${formattedDate}");
    return formattedDate.toString();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  late Position currentLocation;

  getUserLocation() async {
    displayLoading.value = true;
    currentLocation = await locateUser();
    current_latitude.value = currentLocation.latitude.toString();
    current_longitude.value = currentLocation.longitude.toString();
    if (current_latitude != null) {
      displayLoading.value = false;
    }
    print('current_latitude :  ${current_latitude.value}');
    print('current_longitude :  ${current_longitude.value}');
  }

  void submitStartJourney() {
    getUserLocation();
    print(textfiled_vehiclenumber.text.toString());
    print(textfield_opening_km.text.toString());
    print(textfield_remark.text.toString());
  }

  /*void getCustomerPieChartData() {
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

        }
      } else {
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;

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

 /* void iniliseSecondPieChart() {
    if (customerList.length > 0) {
      dataMap1.addAll({
        'Achived': customerList[0].achieveTarget!.toDouble(),
        'Pending': customerList[0].pendingTarget!.toDouble()
      });
    }
  }*/

  /*void setSelected(Data data) {
    selected_dropdown_string.value = data.id.toString();
    dataMap1.clear();
    dataMap1.addAll({
      'Achived': data.achieveTarget!.toDouble(),
      'Pending': data.pendingTarget!.toDouble()
    });
  }*/

  void getCustomerPurchaseList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        /*.executeWithBearerTokenGET('api/mobile/purchase-order-hds-paging?size=5', tokenid!)*/
        .executeWithBearerTokenGET('api/mobile/purchase-order-hds-paging-division?division=${division_id}&size=5', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        customerPurchaseListDataFalg.value=true;
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerPurchaseOrderList.value =
              list.map((e) => PurchaseOrderResponse.fromJson(e)).toList();

          MainPresenter.getInstance()
              .printLog("customerlist1", customerPurchaseOrderList.value.length);
        } else {
          displayLoading.value = false;

        }
      } else {
        customerPurchaseListDataFalg.value=true;
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print(onError);
      customerPurchaseListDataFalg.value=true;
      displayLoading.value = false;

    });
  }

  void getCummulativeData() {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
        'api/target-actual-master/get-aggregate/${login}/${strig_current_year.value}',
        tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        CustomerCummulativeDataResponse cummulativeDataResponse =
        CustomerCummulativeDataResponse.fromJson(jsonDecode(response.body));
        if (cummulativeDataResponse != null) {
          //print(userGlobalResponse.data!.version);
          cummulative_target.value = cummulativeDataResponse.data![0].target!;
          cummulative_actual.value = cummulativeDataResponse.data![0].actual!;
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

  String getyear() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy');
    var formatter_date = new DateFormat('yyyy-MM-dd');

    String year = formatter.format(now);
    String todays_date = formatter_date.format(now);
    //todays_date
    strig_current_year.value = year;
   /* fromdate_str.value = todays_date;
    todate_str.value = todays_date;*/
    print("year is : ${year} and date : ${todays_date}");
    return todays_date;
  }

  void processorder(String str_1, int? id,int position) {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(str_1=="Accept"?'api/mobile/purchase-order-hds-update/${id}/Accepted'
        :"api/mobile/purchase-order-hds-update/${id}/Cancel", tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {

          CustomerPoAcceptCancelResponse cancelResponse=CustomerPoAcceptCancelResponse.fromJson(jsonDecode(response.body));

          if(cancelResponse.message=="Success"){
            if(str_1=="Accept"){
              customerPurchaseOrderList.value[position].status=="Delivered";
              MainPresenter.getInstance().showToast("Order Successfully Accepted");
              update();
            }else if(str_1=="Cancel"){
              customerPurchaseOrderList.value[position].status=="Cancelled";
              MainPresenter.getInstance().showToast("Order Successfully Canceled");
              update();
            }
          }else{
            MainPresenter.getInstance().showToast("Server Error");
          }

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

  void reOrder(String str_1, int? id, PurchaseOrderResponse dataModel) {
    Get.to(() => CustomerEditPurchaseOrderMainScreen(true),
        arguments: {'purchase_order': dataModel});
  }


  void getFeedBackFlagResponse() {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET("api/feedback_customer_form/${login}/${getDate()}", tokenid!)
        .then((value) {
      http.Response response = value;
        displayLoading.value = false;
        feedbackdialog=true;
        if (response.body != null) {
          FeedBackFlagResponse feedBackFlagResponse=FeedBackFlagResponse.fromJson(jsonDecode(response.body));
          if(feedBackFlagResponse.success==true){
            flagShowFeedbackDialog.value=false;
          }else{
            DateTime currentDate = DateTime.now();
            if (currentDate.day >= 1 && currentDate.day <= 24) {
              flagShowFeedbackDialog.value=true;
              displayFeedbackAlertDialog("abc");
            }else{
              flagShowFeedbackDialog.value=false;
            }
            flagShowFeedbackDialog.value=false;
          }
        } else {
          displayLoading.value = false;

        }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      feedbackdialog=true;
    });
  }
  void displayFeedbackAlertDialog(String abc) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            color: dashbordhighlight_blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Feedback",
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
                        "How Was Your Experience?",
                        textAlign: TextAlign.center,
                      ),

                      Container(
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              feedbackRating.value=rating;
                            },
                          )
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
                              hintText: 'Remark',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                          controller: customer_remarkTextEdit,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text('Submit',
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
                                submitAppFeedbackForm();


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

  void submitAppFeedbackForm() {
    displayLoading.value = true;
    final body = jsonEncode({
      "comment": customer_remarkTextEdit.text,
      "created_date": getDate(),
      "cust_id": login,
      "rating": feedbackRating.value.toString()
    });
    ApiService()
        .executeRawPOSTCustomerForm('api/feedback_customer_form_save_data', body, tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        //FeedBackSubmitResponse feedBackSubmitResponse=FeedBackSubmitResponse.fromJson(jsonDecode(response.body));
        MainPresenter.getInstance().showToast("Feedback Successfully Submited");
        Get.back();
        customer_remarkTextEdit.text="";
      } else {
        displayLoading.value = false;

      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;

    });
  }



}
