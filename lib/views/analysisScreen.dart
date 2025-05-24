import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/analysisController.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utils/Constants.dart';

class AnalysisScreen extends StatefulWidget {
  AnalysisScreen({Key? key}) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final analysisController = Get.put(AnalysisContoller());
  final dashboardController = Get.find<DashboardController>();

  /*@override
  void initState() {
  }*/

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              //displayCumulativeData(context),

             /* displayCumulativeData2(context),
              SizedBox(
                height: 10.0,
              ),*/
              Container(
                color: noDatacolor1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Card(
                                /*shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),*/
                                elevation: 4,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'My Statistics',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    /*Obx(() => analysisController.graphListBar3.isEmpty
                        ? analysisController.barGraphData1.value
                            ? noData()
                            : Container()
                        : stackDisplay(
                            GraphData1(), analysisController.barlist1)),*/
                    Obx(() => analysisController.graphListBar3.isEmpty
                        ? analysisController.barGraphData1.value
                        ? noData()
                        : Container()
                        : getCustomerWiseListData(context,"so")),
                  ],
                ),
              ),

              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0, right: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Pie Chart Analysis",
                              style: const TextStyle(
                                  color: dashbordhighlight_blue,
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
                                  onTap: () {
                                    getYearAdnMonth("1");
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
                      )),
                ),
              ),

              /*  SizedBox(
                height: 20.0,
              ),*/
              Visibility(visible: false, child: displayPiechart1(context)),
              /*  SizedBox(
                height: 20.0,
              ),*/

              SizedBox(
                height: 20.0,
                child: Container(
                  color: noDatacolor1,
                ),
              ),

              Container(
                color: noDatacolor2,
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
                            'Customer Statistics',
                            style: TextStyle(
                                color: Colors.black,
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
                              analysisController.selected_customer_str.value =
                                  "";
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Select Customers',
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              analysisController
                                                  .clerarfilterdTextfield();
                                              Get.back();
                                            },
                                            child: const Text('Cancel',style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),)),
                                      ],
                                      content: setupAlertDialoadContainer(),
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
                                        'Customers',
                                        style: TextStyle(
                                            color: Colors.black,
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
                                                      .selected_customer_str
                                                      .isEmpty
                                                  ? 'Select'
                                                  : analysisController
                                                      .selected_customer_str
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
                        Visibility(
                            visible: false,
                            child: Container(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getYearAdnMonth("2");
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
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    /*Obx(() =>
                        analysisController.graphListBarCustomerWise.isEmpty
                            ? analysisController.barGraphData2.value
                                ? noData()
                                : Container()
                            : stackDisplay(GraphData1(),
                                analysisController.barlist2)),*/

                    Obx(() =>
                        analysisController.graphListBarCustomerWise.isEmpty
                            ? analysisController.barGraphData2.value
                                ? noData()
                                : Container()
                            : getCustomerWiseListData(context,"customer")),
                  ],
                ),
              ),

              //product wise barchart
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
                                color: Colors.black,
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
                              analysisController.selected_customer_str2.value =
                              "";
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Select Customers',
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              analysisController
                                                  .clerarfilterdTextfield2();
                                              Get.back();
                                            },
                                            child: const Text('Cancel',style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),)),
                                      ],
                                      content: setupAlertDialoadContainer2(),
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
                                        'Customers',
                                        style: TextStyle(
                                            color: Colors.black,
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
                                                  .selected_customer_str2
                                                  .isEmpty
                                                  ? 'Select'
                                                  : analysisController
                                                  .selected_customer_str2
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
                                  getYearDialog("5");
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
                        Visibility(
                            visible: false,
                            child: Container(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getYearAdnMonth("2");
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
                            ))
                      ],
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
                                            child: const Text('Cancel',style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),)),
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
                                            color: Colors.black,
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
                        /* Container(
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
                        ),*/
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    /*Obx(() => analysisController.graphListProductWise.isEmpty
                        ? analysisController.barGraphData3.value
                            ? noData()
                            : Container()
                        : stackDisplay(
                            GraphData1(), analysisController.barlist3)),*/

                    Obx(() => analysisController.graphListProductWise.isEmpty
                        ? analysisController.barGraphData3.value
                        ? noData()
                        : Container()
                        : getCustomerWiseListData(context,"product")),
                  ],
                ),
              ),

              //displayPiechart2(context),
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

  Widget displayCumulativeData(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0),
      /*decoration: BoxDecoration(
            color: dashbordhighlight_blue,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Card(
        elevation: 10.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: dashbordhighlight_blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))
              /*BorderRadius.circular(10),*/
              ),
          child: Column(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0))),
                color: dashbordhighlight_blue,
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              "#${dashboardController.strig_current_year.value}Reports",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: dashbordhighlight_blue,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Target (In MT)",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Actual (In MT)",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: dashbordhighlight_blue,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(
                          "# ${dashboardController.cummulative_target}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          "# ${dashboardController.cummulative_actual}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: dashbordhighlight_blue,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total Customer",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Todays Orders",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: dashbordhighlight_blue,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.goTOCustomer();
                        },
                        child: Obx(
                          () => Text(
                            "# ${dashboardController.cummulative_total_customer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.purchaseorder();
                        },
                        child: Obx(
                          () => Text(
                            "# ${dashboardController.todyas_purchase_order_count.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 /* Widget displayCumulativeData1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      *//*decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*//*
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    color: dashboarddata1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.pie_chart,
                              size: 20.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            "Target (In MT)",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                                () => Text(
                              "# ${dashboardController.cummulative_target}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: dashboarddata2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.pie_chart,
                              size: 20.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            "Actual (In MT)",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                                () => Text(
                              "# ${dashboardController.cummulative_actual}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.goTOCustomer();
                    },
                    child: Card(
                      color: dashboarddata5,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 5.0, right: 5.0),
                              child: Icon(
                                Icons.pie_chart,
                                size: 20.0,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            Text(
                              "Total Customer",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            Obx(
                                  () => Text(
                                "# ${dashboardController.cummulative_total_customer.value}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.purchaseorder();
                    },
                    child: Card(
                      color: dashboarddata6,
                      elevation:0.0 ,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.0, right: 5.0),
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.pie_chart,
                                size: 20.0,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            Text(
                              "Todays Orders",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            Obx(
                                  () => Text(
                                "# ${dashboardController.todyas_purchase_order_count.value}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }*/

  Widget displayCumulativeData2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      /*decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0,right: 3.0),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/stat1.png',
                            height: 75.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
                          width: double.infinity,
                          height: 80.0,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(
                                  colors: [statgradient2, statgradient1.withOpacity(0.8)])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "TARGET (IN MT)",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700),
                              ),
                              Obx(
                                    () => Text(
                                  "# ${dashboardController.cummulative_target}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0,left: 3.0),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/stat1.png',
                            height: 75.0,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 80.0,
                          padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(
                                  colors: [statgradient3, statgradient4.withOpacity(0.8)])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "ACTUAL (IN MT)",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700),
                              ),
                              Obx(
                                    () => Text(
                                  "# ${dashboardController.cummulative_actual}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      dashboardController.goTOCustomer();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0,right: 3.0),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'assets/images/total_customersnew.png',
                              height: 75.0,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 80.0,
                            padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                gradient: LinearGradient(
                                    colors: [statgradient8, statgradient8.withOpacity(0.8)])),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "TOTAL CUSTOMER",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700),
                                ),
                                Obx(
                                      () => Text(
                                    "# ${dashboardController.cummulative_total_customer.value}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.goTOCustomer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient8, statgradient8])),
                      margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                      padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.person_pin_rounded,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                            () => Text(
                              "# ${dashboardController.cummulative_total_customer.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.purchaseorder();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0,left: 3.0),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'assets/images/stat1.png',
                              height: 75.0,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 80.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                gradient: LinearGradient(
                                    colors: [statgradient5, statgradient6.withOpacity(0.8)])),
                            padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Text(
                                  "TODAYS ORDERS",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700),
                                ),
                                Obx(
                                      () => Text(
                                    "# ${dashboardController.todyas_purchase_order_count.value}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
  Widget displayCumulativeData1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      /*decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Column(
        children: [

          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding:
                    EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [statgradient2, statgradient1])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          child: Image.asset(
                            'assets/images/chart.png',
                            width: 30.0,
                            height: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Target (In MT)",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        Obx(
                              () => Text(
                            "# ${dashboardController.cummulative_target}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [statgradient3, statgradient4])),
                    margin: EdgeInsets.all(5.0),
                    padding:
                    EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/chart.png',
                            width: 30.0,
                            height: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Actual (In MT)",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        Obx(
                              () => Text(
                            "# ${dashboardController.cummulative_actual}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.goTOCustomer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient8, statgradient8])),
                      margin: EdgeInsets.all(5.0),
                      padding:
                      EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.person_pin_rounded,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                                () => Text(
                              "# ${dashboardController.cummulative_total_customer.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.purchaseorder();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient5, statgradient6])),
                      margin: EdgeInsets.all(5.0),
                      padding:
                      EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            alignment: Alignment.topRight,
                            child:  Image.asset(
                              'assets/images/vehicle.png',
                              width: 30.0,
                              height: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Todays Orders",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                                () => Text(
                              "# ${dashboardController.todyas_purchase_order_count.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  void getYearDialog(String str_12) {
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
                          Expanded(
                            child: Column(
                              children: [
                                Text("Year",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                  () => NumberPicker(
                                    infiniteLoop: true,
                                    value: str_12 == "3" ? analysisController.barchartYear.value
                                        :str_12 == "4"? analysisController
                                            .barchartYearCustomerWise.value:analysisController
                                        .barchartYearCustomerWise2.value,
                                    minValue: 2023,
                                    maxValue: int.parse(analysisController.getYear()),
                                    onChanged: (value) {
                                      if (str_12 == "3") {
                                        analysisController.barchartYear.value =
                                            value;
                                      } else if (str_12 == "4") {
                                        analysisController
                                            .barchartYearCustomerWise
                                            .value = value;
                                      }
                                      else if (str_12 == "5") {
                                        analysisController
                                            .barchartYearCustomerWise2
                                            .value = value;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Cancel',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)),
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
                              child: const Text('Ok',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                analysisController
                                    .selectDateAndModifyPichart(str_12);
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

  void getYearAdnMonth(String str_12) {
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
                            "Select Year and Month",
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
                          Expanded(
                            child: Column(
                              children: [
                                Text("Year",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                  () => NumberPicker(
                                    infiniteLoop: true,
                                    value: str_12 == "1"
                                        ? analysisController
                                            .currentIntYear.value
                                        : analysisController
                                            .currentIntYear2.value,
                                    minValue: 2020,
                                    maxValue: 2024,
                                    onChanged: (value) {
                                      str_12 == "1"
                                          ? analysisController
                                              .currentIntYear.value = value
                                          : analysisController
                                              .currentIntYear2.value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("Month",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                  () => NumberPicker(
                                    infiniteLoop: true,
                                    value: str_12 == "1"
                                        ? analysisController
                                            .currentIntMonth.value
                                        : analysisController
                                            .currentIntMonth2.value,
                                    minValue: 1,
                                    maxValue: 12,
                                    onChanged: (value) {
                                      str_12 == "1"
                                          ? analysisController
                                              .currentIntMonth.value = value
                                          : analysisController
                                              .currentIntMonth2.value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Cancel',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)),
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
                              child: const Text('Ok',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                analysisController
                                    .selectDateAndModifyPichart(str_12);
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

  Widget displayPiechart1(BuildContext context) {
    return Obx(() => analysisController.graphList.value.length > 0
        ? PieChart(
            dataMap: analysisController.dataMap,
            animationDuration: const Duration(milliseconds: 1000),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: analysisController.colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "Sales Target",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
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
                      fontFamily: 'Gilroy',
                        fontSize: 14.0,
                        color: Colors.black,
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
                        title: Text('#${dataModel.productId.toString()} - ${dataModel.productFullName.toString()}',style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),),
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

  Widget setupAlertDialoadContainer() {
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
                      analysisController.filterPlayer(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
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
                    controller:
                        analysisController.filtered_customer_name_textEdit,
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
                  itemCount: analysisController.filteredCustomerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel =
                        analysisController.filteredCustomerList.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        analysisController.clerarfilterdTextfield();
                        analysisController.doneSelection(
                            dataModel.firstName.toString(),
                            dataModel.login.toString(),
                            dataModel.zone.toString());
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.firstName.toString(),style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),),
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

  Widget setupAlertDialoadContainer2() {
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
                      analysisController.filterPlayer2(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
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
                    controller:
                    analysisController.filtered_customer_name_textEdit2,
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
                  itemCount: analysisController.filteredCustomerList2.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel =
                    analysisController.filteredCustomerList2.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        analysisController.clerarfilterdTextfield2();
                        analysisController.doneSelection2(
                            dataModel.firstName.toString(),
                            dataModel.login.toString(),
                            dataModel.zone.toString());
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.firstName.toString(),style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),),
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

  Widget displayPiechart2(BuildContext context) {
    return Obx(() => analysisController.graphList2.value.length > 0
        ? PieChart(
            dataMap: analysisController.dataMap2,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: analysisController.colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "Sales Target",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        : Container());
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
              itemCount: (so_customer=="so")?analysisController.graphListBar3.value.length:
              (so_customer=="customer")?analysisController.graphListBarCustomerWise.value.length:analysisController.graphListProductWise.value.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var dataModel = (so_customer=="so")?analysisController.graphListBar3.value[index]:
                (so_customer=="customer")?analysisController.graphListBarCustomerWise.value[index]:
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
    for(var item in (so_customer=="so")?analysisController.graphListBar3.value:
    (so_customer=="customer")?analysisController.graphListBarCustomerWise.value:
    analysisController.graphListProductWise.value){
      total=total+item!.target!;
    }
    target=total.toStringAsFixed(1);
    return target;
  }
  String getTotalActual(String so_customer){
    double total=0.0;
    String actual="0.0";

    for(var item in (so_customer=="so")?analysisController.graphListBar3.value:
    (so_customer=="customer")?analysisController.graphListBarCustomerWise.value:
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
    for(var item in (so_customer=="so")?analysisController.graphListBar3.value:
    (so_customer=="customer")?analysisController.graphListBarCustomerWise.value:
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


}
