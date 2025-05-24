
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerAnalysisController.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse1.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pie_chart/pie_chart.dart';


class CustomerAnalysisScreen extends StatefulWidget {

  CustomerAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<CustomerAnalysisScreen> createState() => _CustomerAnalysisScreenState();
}

class _CustomerAnalysisScreenState extends State<CustomerAnalysisScreen> {
  final analysisController = Get.put(CustomerAnalysisContoller());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.only( left: 10.0),
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "My Statistics",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  getYearDialog("3");
                                  //https://pub.dev/packages/stacked_chart
                                },
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Obx(() => analysisController.graphListBar3.isEmpty?
              analysisController.graphDataFlag.value? noData():Container()
                  : getCustomerWiseListData(context,"customer")),

              SizedBox(
                height: 10.0,
              ),
              Container(
                color: noDatacolor3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Card(
                        /*shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),*/
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 10.0, top: 5.0, right: 5.0, bottom: 5.0),
                          child: const Text(
                            'Product Statistics',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              analysisController.selected_product_str.value =
                              "";
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Select Product',
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              analysisController
                                                  .clerarfilterdTextfieldProduct();
                                              Get.back();
                                            },
                                            child: const Text('Cancel',style: TextStyle(fontFamily: 'Gilroy'),)),
                                      ],
                                      content:
                                      setupAlertDialoadContainerProduct(),
                                    );
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                elevation: 4,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Product',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                          child: Obx(
                                                () => Text(
                                              analysisController
                                                  .selected_product_str
                                                  .isEmpty
                                                  ? 'Select'
                                                  : analysisController
                                                  .selected_product_str
                                                  .value,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getYearDialog("4");
                                  //https://pub.dev/packages/stacked_chart
                                },
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    /*Obx(() => analysisController.graphListProductWise.isEmpty
                        ? analysisController.barGraphData3.value
                        ? noData()
                        : Container()
                        : getCustomerWiseListData(context,"product")),*/
                  ],
                ),
              ),

              Obx(() => analysisController.graphListProductWise.isEmpty?
              analysisController.barGraphDataProduct.value? noData():Container()
                  : getCustomerWiseListData(context,"product")),
            ],
          ),
        ),
        _displayProgress()
      ],
    );
  }

  Widget _displayProgress() {
    return Obx(() => analysisController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget setupAlertDialoadContainerProduct() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      analysisController.filterProduct(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Product Name',
                        hintStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                    controller: analysisController.filtered_product_textEdit,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: analysisController.filteredProductList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel =
                    analysisController.filteredProductList.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        analysisController.clerarfilterdTextfieldProduct();
                        analysisController.doneProductSelection(
                            dataModel.productFullName.toString(),
                            dataModel.productId.toString());
                      },
                      child: ListTile(
                        title: Text('#${dataModel.productId.toString()} - ${dataModel.productFullName.toString()}',style: TextStyle(fontFamily: 'Gilroy'),),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget getCustomerWiseListData(BuildContext context,String so_customer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Month',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Target in MT',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Actual in MT',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      '% of achivement',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: (so_customer=="customer")?analysisController.graphListBar3.value.length:
              analysisController.graphListProductWise.value.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var dataModel = (so_customer=="customer")?analysisController.graphListBar3.value[index]:
                analysisController.graphListProductWise.value[index];
                //print(dataModel.toJson());
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${DateFormat('MMM').format(DateTime(0, dataModel.month!.toInt()))}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${dataModel.target}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${dataModel.actual}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${getPercentage(dataModel.target,dataModel.actual)} %',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      'YTD',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      '${getTotalTarget(so_customer)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      '${getTotalActual(so_customer)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      '${getYearlyPercentage(so_customer)} %',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }

  String getTotalTarget(String so_customer){
    double total=0.0;
    String target="0.0";
    for(var item in (so_customer=="customer")?analysisController.graphListBar3.value:
    analysisController.graphListProductWise.value){
      total=total+item!.target!;
    }
    target=total.toStringAsFixed(1);
    return target;
  }
  String getTotalActual(String so_customer){
    double total=0.0;
    String actual="0.0";

    for(var item in (so_customer=="customer")?analysisController.graphListBar3.value:
    analysisController.graphListProductWise.value){
      total=total+item!.actual!;
    }
    actual=total.toStringAsFixed(1);
    return actual;
  }
  String getYearlyPercentage(String so_customer){


    double total_target=0.0;
    double total_actual=0.0;
    double total_percent=0.0;
    String total_percent_str="0.0";
    for(var item in (so_customer=="customer")?analysisController.graphListBar3.value:
    analysisController.graphListProductWise.value){
      total_target=total_target+item!.target!;
      total_actual=total_actual+item!.actual!;
    }

    total_percent=(total_actual!/total_target!)*100;
    total_percent_str=total_percent.toStringAsFixed(2);
    return total_percent_str;
  }


  String getPercentage(double? target,double? actual){
    double percent=0.0;
    String percentstr="0.0";
    percent=(actual!/target!)*100;
    percentstr=percent.toStringAsFixed(2);
    return percentstr;
  }

  void getYearDialog(String str_12){
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Select Year",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      /*const Text(
                        "Are you sure you want to delete product?",
                        textAlign: TextAlign.center,
                      ),*/
                      Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                              Text(
                                  "Year",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)
                              ),
                              const SizedBox(height: 10),
                              Obx(() => NumberPicker(
                                infiniteLoop: true,
                                value:str_12=="3"?analysisController.barchartYear.value:analysisController.yearProductWise.value,
                                minValue: 2023,
                                maxValue: int.parse(analysisController.getYear()),
                                onChanged: (value){

                                  if(str_12=="3"){
                                    analysisController.barchartYear.value=value;
                                  }else if( str_12=="4"){
                                    analysisController.yearProductWise.value=value;
                                  }

                                },
                              ),),
                            ],
                          ),),



                        ],
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                  'Cancel',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
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
                              child: const Text(
                                  'Ok',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                analysisController.selectDateAndModifyPichart(str_12);
                                Get.back();
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



}




