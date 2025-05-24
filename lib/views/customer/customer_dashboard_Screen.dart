import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerDashboardController.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerHomeController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MyElevatedButton.dart';
import 'package:japfa_feed_application/views/brochureList_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomerDashboardScreen extends StatelessWidget {
  final dashboardController = Get.put(CustomerDashboardController());

  final customerHomeController = Get.find<CustomerHomeController>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                const EdgeInsets.only(left: 15.0, top: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Hi ${dashboardController.firstname}!",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                        /*Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Image.asset(
                            'assets/images/hand_gif.gif',
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),*/
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Lets track your sales.",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              displayCumulativeData1(context),
              //displayCumulativeData(context),
              /*Row(
                children: [
                  Expanded(
                    child: Material(
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            dashboardController.purchaseorder();
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              height: 90.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Image.asset(
                                      'assets/images/shopify.png',
                                      width: 40.0,
                                      height: 40.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "PURCHASE ORDER",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        dashboardController.goToGoodsRecived();
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Container(
                          height: 90.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Image.asset(
                                  'assets/images/shipped.png',
                                  width: 40.0,
                                  height: 40.0,
                                  color: Colors.black,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "GOODS RECEIVED",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w500),
                                  ),
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
                        Get.to(() => BrochureListScreen(true));
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Container(
                          height: 90.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.book,
                                  size: 40.0,
                                  color: Colors.black,

                                ),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Brochure",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/

              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.purchaseorder();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                height: 100.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: bordercolor1,width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  /*BorderRadius.circular(10),*/
                                ),
                                child: Image.asset(
                                  'assets/images/purchsenew.png',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 5.0, left: 5.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "PURCHASE ORDER",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
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
                          dashboardController.goToGoodsRecived();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                height: 100.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: bordercolor1,width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  /*BorderRadius.circular(10),*/
                                ),
                                child: Image.asset(
                                  'assets/images/goodsreceivednew.png',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 5.0, left: 5.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "GOODS RECEIVED",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
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
                          Get.to(() => BrochureListScreen(true));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                height: 100.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: bordercolor1,width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  /*BorderRadius.circular(10),*/
                                ),
                                child: Image.asset(
                                  'assets/images/brochurenew.png',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 5.0, left: 5.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "BROCHURE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
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





              SizedBox(height: 10.0,),
              Container(
                color:hometoolbarcolor,
                margin: EdgeInsets.only(right: 5.0,left: 5.0),
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 10.0, right: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Recent ordres",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),

              Obx(() => dashboardController.customerPurchaseOrderList.value.isEmpty
                  ? dashboardController.customerPurchaseListDataFalg.value?noData():Container()
                  :SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ListView.builder(
                  itemCount: dashboardController.customerPurchaseOrderList.value.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var dataModel = dashboardController.customerPurchaseOrderList.value[index];
                    //print(dataModel.toJson());
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Container(

                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: bordercolor1, width: 2.0),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                    const EdgeInsets.all(5.0),
                                    child: Card(
                                      color: profilepinkcolor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            180),
                                      ),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${dataModel.type == "Customer" ? "Customer" : dataModel.exec!.firstName}',
                                      style: const TextStyle(
                                          color:
                                          textcolorpurchaseorder,
                                          fontSize: 14.0,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                              color: bordercolor1,
                              thickness: 2.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Po : ${dataModel.orderUUID}',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize:
                                                              14.0,
                                                              fontFamily:
                                                              'Gilroy',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            'Mob : ${dataModel.customer!.phone}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                14.0,
                                                                fontFamily:
                                                                'Gilroy',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    '${dataModel.customer!.firstName}',
                                                    style: const TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                        'Gilroy',
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    'Address : ${dataModel.customer!.addressLine2}',
                                                    style: const TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 10.0,
                                                        fontFamily:
                                                        'Gilroy',
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Status',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                        'Gilroy',
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                  Text(
                                                    '${dataModel.status}',
                                                    style: TextStyle(
                                                        color: getColor(
                                                            dataModel
                                                                .status!),
                                                        fontSize: 14.0,
                                                        fontFamily:
                                                        'Gilroy',
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Visibility(
                                    visible:dataModel.status=="Approved"||dataModel.status=="Cancelled"?false:true,
                                    child: Column(
                                      children: [

                                        Visibility(
                                          visible: dataModel.status=="Dispatched"?true:false,
                                          child: MyElevatedButton(
                                            width: MediaQuery.of(context).size.width-40,
                                            onPressed: () {
                                              alertDialog(
                                                  "Accept",
                                                  "Are you sure you want to accept order?",
                                                  dataModel.id,index);
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            child: Text('Accept',
                                              style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                        Visibility(
                                          visible: dataModel.status=="Created"?true:false,
                                          child:MyElevatedButton(
                                            width: MediaQuery.of(context).size.width-40,
                                            onPressed: () {
                                              alertDialog(
                                                  "Cancel",
                                                  "Are you sure you want to cancel order?",
                                                  dataModel.id,index);
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            child: Text('Cancel',
                                              style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                        Visibility(
                                          visible: dataModel.status=="Delivered"?true:false,
                                          child: MyElevatedButton(
                                            width: MediaQuery.of(context).size.width-40,
                                            onPressed: () {
                                              dashboardController.reOrder("Reorder", dataModel.id,dataModel);
                                              /*alertDialog(
                                                      "Reorder",
                                                      "Are you sure you want to Reorder order?",
                                                      dataModel.id);*/
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            child: Text('Reorder',
                                              style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              ),
              SizedBox(height: 20.0,),
            ],
          ),
        ),
        _displayProgress()
      ],
    );
  }


  Widget _displayProgress() {
    return Obx(() => dashboardController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  void alertDialog(String str_1, String str_2, int? id,int index) {
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
                            "${str_1}",
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
                        "${str_2}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('No',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
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
                              child: Text('Yes',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
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
                                Get.back();
                                dashboardController.processorder(
                                    str_1, id,index);
                                /*dashboardController.selectDateAndModifyPichart();*/

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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Statistics",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    customerHomeController.changeTabIndex(0);
                    //dashboardController.getAllLocations();
                    //dashboardController.getAllPointsTravelled();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      "View Detail",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: viewdetailcolor,
                          fontSize: 14.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
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
                        )
                      ],
                    ),
                  ),
                )
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

  Widget displayCumulativeData(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 10.0,left: 10.0),
      child: Card(
        elevation: 10.0,
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          padding: EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: dashbordhighlight_blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              )
            /*BorderRadius.circular(10),*/
          ),
          child: Column(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0))),
                color: dashbordhighlight_blue,
                child: Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
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
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                      Spacer(),


                      GestureDetector(
                        onTap: (){
                          customerHomeController.changeTabIndex(1);
                          //dashboardController.getAllLocations();
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 10.0,left: 10.0,top: 5.0,bottom: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "View Details",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )

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
                    Expanded(child: Text(
                      "Target",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500),
                    ),),
                    Expanded(child: Text(
                      "Actual",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500),
                    ),)
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
                    Expanded(child: Obx(() => Text(
                      "# ${dashboardController.cummulative_target}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600),
                    ),),),
                    Expanded(child: Obx(() => Text(
                      "# ${dashboardController.cummulative_actual}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600),
                    ),),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }





  Color getColor(String str) {
    Color color = new Color(0xFF000000);
    if (str == "Cancelled") {
      color = Colors.red;
    } else if (str == "Approved") {
      color = Colors.yellow;
    } else if (str == "Delivered") {
      color = Colors.green;
    } else if (str == "Dispatched") {
      color = Colors.blue;
    } else if (str == "Created") {
      color = dashbordhighlight_blue;
    } else {
      color = Colors.black;
    }
    return color;
  }
}
