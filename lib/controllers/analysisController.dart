
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse1.dart';
import 'package:japfa_feed_application/responses/ProductListResponse.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:http/http.dart' as http;

class AnalysisContoller extends GetxController {

  var displayLoading = false.obs;
  var division_id = "".obs;
  var division_name = "".obs;
  var userType = "";
  var firstname = "";
  var tokenid = "";
  var userId = "";
  var login = "";
  var designation = "";


  var graphList = List<GraphData>.empty().obs;
  Map<String, double> dataMap = {};


  var currentIntMonth = 1.obs;
  var currentIntYear = 2023.obs;

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
  ];

  final filtered_visitor_name_textEdit = TextEditingController();
  var visitorList = List<VisitorListResponse>.empty().obs;
  var visitorList1 = List<VisitorListResponse>.empty().obs;
  var filteredvisitorList = List<VisitorListResponse>.empty().obs;
  var selected_visitor_str = "".obs;
  var selected_visitor_id = "".obs;
  var selected_visitor_login = "".obs;


  final filtered_customer_name_textEdit = TextEditingController();
  var customerList = List<CustomerListResponse>.empty().obs;
  var customerList1 = List<CustomerListResponse>.empty().obs;
  var filteredCustomerList = List<CustomerListResponse>.empty().obs;
  var selected_customer_str = "".obs;
  var selected_customer_id = "".obs;



  var barchartYear = 0.obs;
  var graphListBar3 = List<GraphData>.empty().obs;

  var barchartYearCustomerWise = 0.obs;
  var graphListBarCustomerWise = List<GraphData>.empty().obs;




  Map<String, double> dataMap2 = {};
  var currentIntMonth2 = 1.obs;
  var currentIntYear2 = 2023.obs;
  var graphList2 = List<GraphData>.empty().obs;

  var barGraphData1=false.obs;
  var barGraphData2=false.obs;
  var barGraphData3=false.obs;

  var barlist1 = List<GraphData1>.empty().obs;
  var barlist2 = List<GraphData1>.empty().obs;
  var barlist3 = List<GraphData1>.empty().obs;

  var showEmpListFlag=false.obs;



  final filtered_product_textEdit = TextEditingController();
  var selected_product_str = "".obs;
  var selected_product_id = "".obs;
  var productlist = List<ProductListResponse>.empty().obs;
  var productlist1 = List<ProductListResponse>.empty().obs;
  var filteredProductList = List<ProductListResponse>.empty().obs;
  var graphListProductWise = List<GraphData>.empty().obs;


  final filtered_customer_name_textEdit2 = TextEditingController();
  var customerList2 = List<CustomerListResponse>.empty().obs;
  var customerList22 = List<CustomerListResponse>.empty().obs;
  var filteredCustomerList2 = List<CustomerListResponse>.empty().obs;
  var selected_customer_str2 = "".obs;
  var selected_customer_id2 = "".obs;
  var barchartYearCustomerWise2 = 0.obs;


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
      login = MainPresenter
          .getInstance()
          .userModel
          .login!;
      userType = MainPresenter
          .getInstance()
          .userModel
          .usertype!;
      firstname = MainPresenter
          .getInstance()
          .userModel
          .firstName!;

      designation = MainPresenter
          .getInstance()
          .userModel
          .designation!;
      tokenid = MainPresenter
          .getInstance()
          .userModel
          .tokenid!;

      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      MainPresenter.getInstance().printLog("userid tushar1", userId);
      MainPresenter.getInstance().printLog("userid tushar1", MainPresenter
          .getInstance()
          .userModel
          .designation!);
      getChartData("3","so",login, getYear().toString()+"/0");
      //getChartData("1",login, getDate().toString());

      barchartYear.value=int.parse(getYear());
      barchartYearCustomerWise.value=int.parse(getYear());
      barchartYearCustomerWise2.value=int.parse(getYear());

      if(MainPresenter
          .getInstance()
          .userModel
          .designation=="ZO"){
        showEmpListFlag.value=true;
      }else{
        showEmpListFlag.value=false;
      }
      print(showEmpListFlag);

      getVisitorList();
      getCustomerList();
      getProductList();

    }
  }


  void getChartData(String str12,String so_customer,String loginid, String stringDate) {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
        so_customer=="so"?
        'api/target-actual-master/getByLS/$loginid/$stringDate':'api/target-actual-master/get/$loginid/$stringDate', tokenid)
        .then((value) {
      http.Response response = value;
      if(str12=="3"){
        barGraphData1.value=true;
      }
      if(str12=="4"){
        barGraphData2.value=true;
      }

      if (response.statusCode == 200) {
        displayLoading.value = false;

        GraphDataResponse graphDataResponse =
        GraphDataResponse.fromJson(jsonDecode(response.body));
        if (graphDataResponse != null) {
          if(str12=="3"){
            graphListBar3.value = graphDataResponse.data!;
            print("graphListBar3 list ${graphListBar3.value.length}");
            barlist1.clear();
            for(var item in graphListBar3){
              barlist1.add(GraphData1(
              achived: getAchived(item.target, item.actual),
              pending: getPending(item.target, item.actual),
              overachived:getOverAchived(item.target, item.actual),
              month: item.month));
            }
            print("barlist1 list ${barlist1.value.length}");

          }else if(str12=="4"){
            graphListBarCustomerWise.value = graphDataResponse.data!;
            print("graphListBar4 list ${graphListBarCustomerWise.value.length}");
            barlist2.clear();
            for(var item in graphListBarCustomerWise){
              barlist2.add(GraphData1(
                  achived: getAchived(item.target, item.actual),
                  pending: getPending(item.target, item.actual),
                  overachived:getOverAchived(item.target, item.actual),
                  month: item.month));
            }
            print("barlist2 list ${barlist2.value.length}");
          }
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('User Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('User Data', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      if(str12=="3"){
        barGraphData1.value=true;
      }
      if(str12=="4"){
        barGraphData2.value=true;
      }
      //openAndCloseLoadingDialog('User Data', 'Please try again');
    });
  }

  /*String getyear() {
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
  }*/

  double getAchived(double? target, double? actual){

    double? result=0.0;
    if((target!)>(actual!)){
      result=actual;
    }else if(target<actual){
      result=target;
    }else if(target==actual){
      result=actual;
    }
    return result!;
  }

  double getPending(double? target, double? actual){
    double? result=0.0;
    if(target==actual){
      result=0.0;
    }else if((target!)>(actual!)){
      result=target-actual;
    }else if(target<actual){
      result=0.0;
    }
    return result!;
  }

  double getOverAchived(double? target, double? actual){
    double? result=0.0;
     if(target==actual){
    result=0.0;
    }else if((target!)>(actual!)){
      result=0.0;
    }else if((target)<(actual)){
      result=actual-target;
    }
    return result!;
  }

  void getCustomerList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
   /* final body = jsonEncode({
      *//* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*//*
    });*/
    String url="";
    if(MainPresenter
        .getInstance()
        .userModel
        .designation=="ZO"){
      url="api/mobile/my-customers/division/${division_id.value}";
    }else{
      url="api/mobile/my-customers/${selected_visitor_id.value}";
    }
    ApiService()
        .executeWithBearerTokenGET('$url', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => CustomerListResponse.fromJson(e)).toList();
          customerList2.value =
              list.map((e) => CustomerListResponse.fromJson(e)).toList();


          filteredCustomerList.value = customerList.value;
          customerList1.value = customerList.value.toSet().toList();

          filteredCustomerList2.value = customerList.value;
          customerList22.value = customerList.value.toSet().toList();
          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Customer Data', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Customer Data', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }

  void clerarfilterdTextfield1() {
    filtered_visitor_name_textEdit.clear();
    filteredvisitorList.value = visitorList1.value;
    filteredvisitorList.refresh();
  }

  void clerarfilterdTextfield() {
    filtered_customer_name_textEdit.clear();
    filteredCustomerList.value = customerList1.value;
    filteredCustomerList.refresh();
  }

  void clerarfilterdTextfield2() {
    filtered_customer_name_textEdit2.clear();
    filteredCustomerList2.value = customerList22.value;
    filteredCustomerList2.refresh();
  }

  void clerarfilterdTextfieldProduct() {
    filtered_product_textEdit.clear();
    filteredProductList.value = productlist1.value;
    filteredProductList.refresh();
  }

  void filterPlayer(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<CustomerListResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList1;
    } else {
      results = customerList1
          .where((element) =>
          element.firstName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredCustomerList.value = results;
  }

  void filterPlayer2(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<CustomerListResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList22;
    } else {
      results = customerList22
          .where((element) =>
          element.firstName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredCustomerList2.value = results;
  }

  void filterVisitor(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<VisitorListResponse> results = [];
    if (playerName.isEmpty) {
      results = visitorList1;
    } else {
      results = visitorList1
          .where((element) =>
          element.firstName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredvisitorList.value = results;
  }

  void filterProduct(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<ProductListResponse> results = [];
    if (playerName.isEmpty) {
      results = productlist1;
    } else {
      results = productlist1
          .where((element) =>
          element.productFullName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()) ||
              element.productId
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase())

      ).toList();
    }
    filteredProductList.value = results;
  }

  void doneSelection(String selectedName, String customerid_login, String zone) {
    selected_customer_str.value = selectedName;
    selected_customer_id.value = customerid_login.toString();

    getChartData("4","customer",selected_customer_id.value, barchartYearCustomerWise.toString() + "/0");
    print(selected_customer_id.value);
  }

  void doneSelection2(String selectedName, String customerid_login, String zone) {
    selected_customer_str2.value = selectedName;
    selected_customer_id2.value = customerid_login.toString();
    print(selected_customer_id2.value);
    selected_product_str.value = "";
    selected_product_id.value="";

    graphListProductWise.value.clear();
    barGraphData3.value=false;
    update();
    /*graphListProductWise.value.clear();*/
  }
  void doneVisitorSelection(String selectedName, String customerid_login) {
    selected_visitor_str.value = selectedName;
    selected_visitor_id.value = customerid_login.toString();
    print(selected_visitor_id.value);
    getChartData("3","so",selected_visitor_id.value, getYear().toString()+"/0");
    getCustomerList();
  }

  void doneProductSelection(String selectedName, String productid) {

    if(selected_customer_id2.value==""){
      MainPresenter.getInstance().showToast("Please select customer under porduct analysis.");
    }else{
      graphListProductWise.value.clear();
      barlist3.value.clear();
      selected_product_str.value = selectedName;
      selected_product_id.value = productid.toString();
      print(selected_visitor_id.value);
      getProductWiseChartData(login,selected_product_id.value.toString());
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

  void iniliseFirstPieChart(String str12) {
    if (graphList.length > 0) {

      if(str12=="1"){
        dataMap.addAll({
          'Achived': graphList[0].actual!.toDouble(),
          'Pending': graphList[0].target!.toDouble() -
              graphList[0].actual!.toDouble()
        });
      }else if(str12=="2"){
        dataMap2.addAll({
          'Achived': graphList2[0].actual!.toDouble(),
          'Pending': graphList2[0].target!.toDouble() -
              graphList[0].actual!.toDouble()
        });
      }

    }
  }

  String getDate() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy/MM');
    String todays_date = formatter.format(now);
    //todays_date
    print("todyas date is : ${todays_date}");
    return todays_date;
  }
  String getYear() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy');
    String todays_date = formatter.format(now);
    //todays_date
    print("todyas year is : ${todays_date}");
    return todays_date;
  }

  void selectDateAndModifyPichart(String str_12) {
     if(str_12=="3" ){
      getChartData("3","so",login, barchartYear.toString() + "/0");
    } else if(str_12=="4" ){
      getChartData("4","customer",selected_customer_id.value, barchartYearCustomerWise.toString() + "/0");
    }else if(str_12=="5" ){
      if(selected_product_id.value!=""){
        getProductWiseChartData(selected_customer_id2.value,selected_product_id.value.toString());
      }
      /*getChartData("3",selected_visitor_id.value, barchartYearCustomerWise.toString() + "/0");*/
    }
  }

  void selectDateAndModifyPichart1(String str_12) {
    if(str_12=="3" ){
      getChartData("3","so",selected_visitor_id.value, barchartYear.toString() + "/0");
    } else if(str_12=="4" ){
      getChartData("4","customer",selected_customer_id.value, barchartYearCustomerWise.toString() + "/0");
    }else if(str_12=="5" ){
      if(selected_product_id.value!=""){
        getProductWiseChartData(selected_customer_id2.value,selected_product_id.value.toString());
      }
      /*getChartData("3",selected_visitor_id.value, barchartYearCustomerWise.toString() + "/0");*/
    }
  }


  void getVisitorList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });

    ApiService()
        .executeWithBearerTokenGET('api/web/my-visitors', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          visitorList.value =
              list.map((e) => VisitorListResponse.fromJson(e)).toList();
          visitorList1.value=visitorList.value;
          filteredvisitorList.value=visitorList.value;
          MainPresenter.getInstance()
              .printLog("visitorList", visitorList.value.length);


        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('visitorList', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('visitorList', "Invalid Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('visitorList', 'Please try again');
    });
  }


  void getProductList() {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/products', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          productlist.value =
              list.map((e) => ProductListResponse.fromJson(e)).toList();
          filteredProductList.value=productlist.value;
          productlist1.value=productlist.value;



          MainPresenter.getInstance()
              .printLog("productlist", productlist.value[0].productFullName);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Product List', "Server error1");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Product List', "Server error2");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Product List', 'Please try again');
    });
  }


  void getProductWiseChartData(String loginid,String productid) {
    displayLoading.value = true;
    /*graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 1,year: 2024,actual: 100,target: 200,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 2,year: 2024,actual: 200,target: 300,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 3,year: 2024,actual: 400,target: 500,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 4,year: 2024,actual: 600,target: 700,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 5,year: 2024,actual: 800,target: 900,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 6,year: 2024,actual: 1000,target: 1100,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 7,year: 2024,actual: 1200,target: 1300,type: "test"));
    graphListProductWise.add(GraphData(id: 1,login: "test",name: "test",month: 8,year: 2024,actual: 1400,target: 1500,type: "test"));*/
    ApiService()
        .executeWithBearerTokenGET(
        'api/target-actual-product-master/division/${selected_customer_id2.value.toString()}/${barchartYearCustomerWise2.value.toString()}/${productid}/${division_id.value}', tokenid)
        .then((value) {
      http.Response response = value;
      barGraphData3.value=true;
      displayLoading.value = false;
      if (response.statusCode == 200) {
        GraphDataResponse graphDataResponse =
        GraphDataResponse.fromJson(jsonDecode(response.body));
        if (graphDataResponse != null) {
          graphListProductWise.value = graphDataResponse.data!;
          print("graphListProductWise list ${graphListProductWise.value.length}");
          for(var item in graphListProductWise.value){
            barlist3.add(GraphData1(achived: getAchived(item.target, item.actual),
                pending: getPending(item.target, item.actual),
                overachived:getOverAchived(item.target, item.actual),
                month: item.month));
          }
          print("barlist3 list ${barlist3.value.length}");
        }
      }else {
        graphListProductWise.value.clear();
        barGraphData3.value=true;
        refresh();
        //openAndCloseLoadingDialog('User Data', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      MainPresenter.getInstance().printLog("tuhsar", onError);
      graphListProductWise.value.clear();
      barGraphData3.value=false;
      displayLoading.value = false;
      update();
    });
  }
}