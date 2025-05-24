import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerListByVisitorIdResponse.dart';
import 'package:japfa_feed_application/responses/NewAutoCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responses/CustomerListResponse.dart';

class AddPlanController extends GetxController {
  var displayLoading = false.obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var login = "";
  var division_name = "".obs;
  var division_id = "".obs;
  var visitorList = List<VisitorListResponse>.empty().obs;

  var newAutoCustomerList = List<NewAutoCustomerListResponse>.empty().obs;
  var filteredNewAutoCustomerList = List<NewAutoCustomerListResponse>.empty().obs;
  var customerList = List<CustomerListByVisitorIdResponse>.empty().obs;
  var customerList1 = List<CustomerListByVisitorIdResponse>.empty().obs;
  var selectedCustomerList = List<CustomerListByVisitorIdResponse>.empty().obs;
  var filteredCustomerList = List<CustomerListByVisitorIdResponse>.empty().obs;
  var selected_dropdown_object = VisitorListResponse().obs;
  var selected_dropdown_string = "Select Visitor".obs;


  late Future<void> _launched;

  var tabindex = 0.obs;
  var fromdate_str = "".obs;
  var todate_str = "".obs;
  var selected_customer_str = "".obs;

  FocusNode? focusNode;
  var autocomplettextfield = TextEditingController();
  final addplan_name = TextEditingController();
  final addplan_remark = TextEditingController();
  final addplan_name_customer_fliter = TextEditingController();
  final fromdate = TextEditingController();
  final todate = TextEditingController();
  var old_new_from=true.obs;




  var customerTypeList = List<String>.empty().obs;
  var selected_dropdown_customertype = "Select Type".obs;
  var selected_visitor_id="".obs;
  var selected_visitor_loginid="".obs;

  var customerVisiblityFlag=true.obs;
  TextEditingController autocompleteTextcontroller = TextEditingController();



  @override
  void onInit() {
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      login = MainPresenter.getInstance().userModel.login!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);

      selected_dropdown_customertype.value="Japfa Existing";

      if(selected_dropdown_customertype.value=="Japfa Existing"){
        customerVisiblityFlag.value=true;
      }else if(selected_dropdown_customertype.value=="Japfa New"){
        customerVisiblityFlag.value=false;
      }

      customerTypeList.clear();
      customerTypeList.add('Japfa Existing');
      customerTypeList.add('Japfa New');
      initializeDate();
      getNewCustomerList();
      getVisitorList();
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

  void getVisitorList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });

    Map<String, dynamic> paramsMaps = {
      'divisionId': division_id.value,
    };

    ApiService()
        .executeWithBearerTokenGET('api/users/web/my-visitors-division?divisionId=${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          visitorList.value =
              list.map((e) => VisitorListResponse.fromJson(e)).toList();
          MainPresenter.getInstance()
              .printLog("visitorList", visitorList.value.length);
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

  void getCustomerList(String visitorid) {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    /*Map<String, dynamic> paramsMaps = {
      'divisionId': division_id.value,
    };*/

    ApiService()
        .executeWithBearerTokenGET('api/web/${visitorid}/customers-division/${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value = list
              .map((e) => CustomerListByVisitorIdResponse.fromJson(e))
              .toList();

          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
          for (var abc in customerList.value) {
            abc.checked = false;
            customerList1.add(abc);
          }
          filteredCustomerList.value = customerList1.value;
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Error', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Error', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Error', 'Please try again');
    });
  }
  void getNewCustomerList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/customer-enquiry-list-division/${login}/${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          newAutoCustomerList.value = list
              .map((e) => NewAutoCustomerListResponse.fromJson(e))
              .toList();

          MainPresenter.getInstance()
              .printLog("newAutoCustomerList", newAutoCustomerList.value.length);

          filteredNewAutoCustomerList.value = newAutoCustomerList.value;
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

  void changetab(int i) {
    Get.off(HomeScreen());
  }

  void callCustomer(CustomerListResponse dataModel) {
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

  void initializeDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print("todyas date is : ${formattedDate}");
    fromdate_str.value = formattedDate;
    todate_str.value = formattedDate;
    fromdate.text = fromdate_str.value;
    todate.text = todate_str.value;
  }

  String formatDate(DateTime dateTime) {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  DateTime selectedDate = DateTime.now();

  void selectDate(BuildContext context, String datetype) async {
    String dialogHead = "";

    if (datetype == "from") {
      dialogHead = "Select From Date";
    } else {
      dialogHead = "Select To Date";
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        helpText: dialogHead,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: statgradient3, // Header background color// Accent color
            colorScheme: ColorScheme.light(
              primary: statgradient3,   // Selected dates and header color
              onPrimary: Colors.white, // Text color on selected dates/header
              surface: Colors.white,   // Background color of the calendar
              onSurface: Colors.black, // Text color on the calendar
            ),
            dialogBackgroundColor: Colors.white, // Background color of the dialog
            textTheme: TextTheme(
              headlineMedium: TextStyle(
                color: Colors.black,
                fontFamily: 'Popins', // Replace with your font family name
              ),
              bodyLarge: TextStyle(
                color: Colors.black,
                fontFamily: 'Popins', // Replace with your font family name
              ),
              labelLarge: TextStyle(
                color: Colors.black,
                fontFamily: 'Popins', // Replace with your font family name
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      if (datetype == "from") {
        fromdate_str.value = formatDate(picked);
        fromdate.text = fromdate_str.value;
        update();
      } else {
        todate_str.value = formatDate(picked);
        todate.text = todate_str.value;
        update();
      }
    }
  }

  void doneSelection() {
    for (var abc in filteredCustomerList.value) {
      if (abc.checked == true) {
        selectedCustomerList.add(abc);
        selected_customer_str.value =
            selected_customer_str.value + "\n" + abc.firstName.toString();
      }
    }
  }

  void clerarfilterdTextfield() {
    addplan_name_customer_fliter.clear();
    filteredCustomerList.value = customerList1.value;
    filteredCustomerList.refresh();
  }

  void filterPlayer(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<CustomerListByVisitorIdResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList1;
    } else {
      results = customerList1
          .where((element) => element.firstName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredCustomerList.value = results;
  }

  addPlan() {

    if(selected_dropdown_customertype.value=="Japfa Existing"){
      if (validateAddplan()) {
        MainPresenter.getInstance()
            .printLog("selected dropdown", jsonEncode(selected_dropdown_object));
        /*MainPresenter.getInstance().printLog("selected customer", jsonEncode(selectedCustomerList.value.map((e) => e.id).toList()));*/
        List testList = [];
        for (var item in selectedCustomerList) {
          Map<String, dynamic> testMap = new Map();
          testMap.addAll({'id': "${item.id.toString()}"});
          testList.add(testMap);
        }
        print(testList);

        sendAddPlanDataToServer(
            selected_dropdown_object.value, testList);
      }

    }else if(selected_dropdown_customertype.value=="Japfa New"){
      if(validateAddplan2()){
        submitForm(selected_visitor_id.value.toString(),selected_visitor_loginid.value.toString());
      }
    }

  }

  void setSelected(VisitorListResponse value) {
    MainPresenter.getInstance().printLog("TAG", value.firstName.toString());
    selected_dropdown_string.value = value.firstName.toString();
    selected_dropdown_object.value = value;
    refresh();
    selected_visitor_id.value=value.id.toString();
    selected_visitor_loginid.value=value.login.toString();
    /*if( customerVisiblityFlag.value=true){
      getCustomerList(value.id.toString());
    }*/

    if(selected_dropdown_customertype.value=="Japfa Existing"){
      getCustomerList(value.id.toString());
    }
  }

  bool validateAddplan() {
    if (addplan_name.value.text.toString().trim().length < 2) {
      openAndCloseLoadingDialog('Name ', 'Please enter valid user name');
      return false;
    } else if (addplan_remark.value.text.toString().trim().length < 2) {
      openAndCloseLoadingDialog('Password', 'Please enter valid remark');
      return false;
    } else if (selected_dropdown_string.value == "Select Visitor") {
      openAndCloseLoadingDialog(
          'Select Visitor', 'Please select valid visitor');
      return false;
    } else if (selected_customer_str.value.isEmpty) {
      openAndCloseLoadingDialog(
          'Select Customer', 'Please select valid customer');
      return false;
    } else {
      return true;
    }
  }

  bool validateAddplan2() {
    if (addplan_name.value.text.toString().trim().length < 2) {
      openAndCloseLoadingDialog('Name ', 'Please enter valid user name');
      return false;
    } else if (addplan_remark.value.text.toString().trim().length < 2) {
      openAndCloseLoadingDialog('Remark', 'Please enter valid remark');
      return false;
    }else if (selected_dropdown_string.value == "Select Visitor") {
      openAndCloseLoadingDialog(
          'Select Visitor', 'Please select valid visitor');
      return false;
    } else {
      return true;
    }
  }

  bool validateCustomerList() {
    if (selected_dropdown_string.value == "Select Visitor") {
      openAndCloseLoadingDialog(
          'Select Visitor', 'Please select valid visitor');
      return false;
    }
    return true;
  }

  void sendAddPlanDataToServer(VisitorListResponse dropdownSelect, List testList) {
    //print("getCustomerList : ${addplan_name.toString().trim()}");
    displayLoading.value = true;
    final dropdownvalue = {
      'createdDate': dropdownSelect.createdDate,
      'id': dropdownSelect.id,
      'login': dropdownSelect.login,
      'firstName': dropdownSelect.firstName,
      'lastName':dropdownSelect.lastName,

    };
     final body = {
      'fromDate': fromdate_str.value,
      'toDate': fromdate_str.value,
      'name': addplan_name.text.toString().trim(),
      'remark': addplan_remark.text.toString().trim(),
      'visitor':dropdownvalue,
      'customers': testList,
       'divisionId':division_id.value
    };
    print("body : ${body}");
    ApiService()
        .executeRawPOST1('api/track-targets',  jsonEncode(body), tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200 || response.statusCode == 201) {
        displayLoading.value = false;
        MainPresenter.getInstance().showToast("Form Successfully Submited");
        Get.back();
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Error', "Invalid..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Error', 'Please try again');
    });
  }

  changeform(bool bool) {
    MainPresenter.getInstance().printLog("changeform tab", bool);
    old_new_from.value=bool;
  }

  void setSelectedCustomerType(String s) {
      MainPresenter.getInstance()
          .printLog("TAG customer type", s.toString());
      selected_dropdown_customertype.value = s.toString();
      refresh();

      if(selected_dropdown_customertype.value=="Japfa Existing"){
        customerVisiblityFlag.value=true;
      }else if(selected_dropdown_customertype.value=="Japfa New"){
        customerVisiblityFlag.value=false;
      }
  }

/* List getList(List<CustomerListByVisitorIdResponse> value) {

    jsonEncode(value.map((e) => e.id));
    List<> newList=[];



    for(var abc in selectedCustomerList.value){
      newList.add(abc.id.toString());
    }
    return newList;
  }*/


  void submitForm(String userid1,String loginid1) {
    displayLoading.value = true;
    final body = jsonEncode({
      'cash_discount': "",
      'company_name': "",
      'customer_name': addplan_name.text,
      'customer_type': "",
      'district': "",
      'feed_buying_from': "",
      'feed_buying_type': "",
      'firm_name': "",
      'id': selected_visitor_id.value,
      'login': selected_visitor_loginid.value,
      'mobile_number': "",
      'monthly_feed_sales': "",
      'monthly_sales': "",
      'monthly_scheme_per_bag': "",
      'monthly_target': "",
      'monthly_total_feed_sales': "",
      'payment_terms': "",
      'remark': addplan_remark.text,
      'state': "",
      'tehsil': "",
      'top_selling_sku': "",
      'top_selling_sku_name': "",
      'top_selling_sku_price': "",
      'top_selling_sku_monthly_sales':
      "",
      'top_sku_selling_price_bag':
      "",
      'village': "",
      'fromDate':fromdate_str.value,
      'toDate': fromdate_str.value,
      'divisionId':division_id.value
    });
    ApiService()
        .executeRawPOSTCustomerForm('api/customer-enquiry', body, tokenid)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        MainPresenter.getInstance().showToast("Form Successfully Submited");
        selected_visitor_loginid.value="";
        selected_visitor_id.value="";
        selected_dropdown_string.value = "Select Visitor";
        //Get.offAll(PgMain());
        Get.offAll(HomeScreen());
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
}
