
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse1.dart';
import 'package:japfa_feed_application/responses/ProductListResponse.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:http/http.dart' as http;

class CustomerAnalysisContoller extends GetxController {

  var displayLoading = false.obs;
  var userType = "";
  var firstname = "";
  var tokenid = "";
  var userId = "";
  var login = "";
  var division_id = "".obs;
  var division_name = "".obs;


  final filtered_customer_name_textEdit = TextEditingController();
  var customerList = List<CustomerListResponse>.empty().obs;
  var customerList1 = List<CustomerListResponse>.empty().obs;
  var filteredCustomerList = List<CustomerListResponse>.empty().obs;
  var selected_customer_str = "".obs;
  var selected_customer_id = "".obs;



  var barchartYear = 0.obs;
  var graphListBar3 = List<GraphData>.empty().obs;
  var graphDataFlag=false.obs;

  var barlist3 = List<GraphData1>.empty().obs;


  final filtered_product_textEdit = TextEditingController();
  var selected_product_str = "".obs;
  var selected_product_id = "".obs;
  var productlist = List<ProductListResponse>.empty().obs;
  var productlist1 = List<ProductListResponse>.empty().obs;
  var filteredProductList = List<ProductListResponse>.empty().obs;
  var graphListProductWise = List<GraphData>.empty().obs;

  var barGraphDataProduct=false.obs;
  var yearProductWise = 0.obs;


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
      tokenid = MainPresenter
          .getInstance()
          .userModel
          .tokenid!;

      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;

      MainPresenter.getInstance().printLog("userid tushar1", userId);
      getChartData("3",login, getYear().toString()+"/0");
      getProductList();

      barchartYear.value=int.parse(getYear());
      yearProductWise.value=int.parse(getYear());
      //getChartData("1",login, getDate().toString());
      /*barchartYear=getYear() as RxInt;*/
    }
  }


  void getChartData(String str12,String loginid, String stringDate) {
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET(
        'api/target-actual-master/get-division/$loginid/$stringDate/${division_id.value}', tokenid)
        .then((value) {
      http.Response response = value;
      graphDataFlag.value=true;
      if (response.statusCode == 200) {
        displayLoading.value = false;

        GraphDataResponse graphDataResponse =
        GraphDataResponse.fromJson(jsonDecode(response.body));
        if (graphDataResponse != null) {
          if(str12=="3"){
            graphListBar3.value = graphDataResponse.data!;
            print("graphListBar3 list ${graphListBar3.value.length}");

            barlist3.clear();
            for(var item in graphListBar3){
              barlist3.add(GraphData1(achived: getAchived(item.target, item.actual),
                  pending: getPending(item.target, item.actual),
                  overachived:getOverAchived(item.target, item.actual),
                  month: item.month));
            }
            print("barlist1 list ${barlist3.value.length}");

          }
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
      graphDataFlag.value=true;
      displayLoading.value = false;
      //openAndCloseLoadingDialog('User Data', 'Please try again');
    });
  }

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


  void clerarfilterdTextfield() {
    filtered_customer_name_textEdit.clear();
    filteredCustomerList.value = customerList1.value;
    filteredCustomerList.refresh();
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

  void doneSelection(String selectedName, String customerid_login, String zone) {
    selected_customer_str.value = selectedName;
    selected_customer_id.value = customerid_login.toString();
    print(selected_customer_id.value);
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
      getChartData("3",login, barchartYear.toString() + "/0");
    }
   if(str_12=="4" ){
     if(selected_product_id.value==""){
       MainPresenter.getInstance().showToast("Please select product");
     }else{
       getProductWiseChartData(login,selected_product_id.value);
     }

   }
  }


  void clerarfilterdTextfieldProduct() {
    filtered_product_textEdit.clear();
    filteredProductList.value = productlist1.value;
    filteredProductList.refresh();
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

  void doneProductSelection(String selectedName, String productid) {

    graphListProductWise.value.clear();
    barlist3.value.clear();
    selected_product_str.value = selectedName;
    selected_product_id.value = productid.toString();
    getProductWiseChartData(login,selected_product_id.value.toString());

  }

  void getProductList() {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/products-division?division=${division_id.value}', tokenid!)
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
    ApiService()
        .executeWithBearerTokenGET(
        'api/target-actual-product-master/division/${login.toString()}/${yearProductWise.value.toString()}/${productid}/${division_id.value}', tokenid)
        .then((value) {
      http.Response response = value;
      barGraphDataProduct.value=true;
      displayLoading.value = false;
      if (response.statusCode == 200) {
        GraphDataResponse graphDataResponse =
        GraphDataResponse.fromJson(jsonDecode(response.body));
        if (graphDataResponse != null) {
          graphListProductWise.value = graphDataResponse.data!;
          print("graphListProductWise list ${graphListProductWise.value.length}");
         /* for(var item in graphListProductWise.value){
            barlistproduct.add(GraphData1(achived: getAchived(item.target, item.actual),
                pending: getPending(item.target, item.actual),
                overachived:getOverAchived(item.target, item.actual),
                month: item.month));
          }*/
          print("barlist3 list ${barlist3.value.length}");
        }
      }else {
        graphListProductWise.value.clear();
        barGraphDataProduct.value=true;
        refresh();
        //openAndCloseLoadingDialog('User Data', "Invalid Data..");
      }
    }).catchError((onError) {
      print(onError);
      MainPresenter.getInstance().printLog("tuhsar", onError);
      graphListProductWise.value.clear();
      barGraphDataProduct.value=false;
      displayLoading.value = false;
      update();
    });
  }
}