import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerPurchaseOrderListController.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MyElevatedButton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomerPurchaseOrderListScreen extends StatefulWidget {
  const CustomerPurchaseOrderListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerPurchaseOrderListScreen> createState() =>
      _CustomerPurchaseOrderListScreenState();
}

class _CustomerPurchaseOrderListScreenState
    extends State<CustomerPurchaseOrderListScreen> {
  final purchaseOrderListController =
      Get.put(CustomerPurchaseOrderListController());

  var focusNode = FocusNode();
  Icon _searchIcon = new Icon(Icons.search);
  Icon _searchIconRemove = new Icon(Icons.close);


  DateTimeRange dateTimeRange =
  DateTimeRange(start: DateTime(2022, 11, 15), end: DateTime(2022, 12, 24));

  Widget _appBarTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
              () => Text(
            "DIV - ${purchaseOrderListController.division_name.value}",
            style: TextStyle(
                fontSize: 18.0, color: Colors.black, fontFamily: "Gilroy"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        purchaseOrderListController.changetab(0);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add
          ,color: Colors.white,),
          backgroundColor: statgradient5,
          onPressed: () {
            purchaseOrderListController.goToMainPurchaseOrderScreen();
          },
        ),
        appBar:  PreferredSize(
            child: _displayAppBar(), preferredSize: const Size.fromHeight(56)),
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(
                      () => purchaseOrderListController
                      .filteredPurchaseOrderList.value.isEmpty
                      ? purchaseOrderListController.Data1.value
                      ? noDataPurchaseOrder()
                      : Container()
                  : SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: ListView.builder(
                        itemCount: purchaseOrderListController
                            .filteredPurchaseOrderList.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel = purchaseOrderListController
                              .filteredPurchaseOrderList.value[index];
                          //print(dataModel.toJson());
                          return GestureDetector(
                            onTap: () {
                              purchaseOrderListController.purchaseOrderDetails(
                                  purchaseOrderListController
                                      .filteredPurchaseOrderList.value[index]);
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
                                                child: Container(
                                                  width: double.infinity,
                                                    margin: EdgeInsets.only(right: 5.0),
                                                    child:MyElevatedButton(
                                                      width: double.infinity,
                                                      onPressed: () {
                                                        alertDialog(
                                                            "Accept",
                                                            "Are you sure you want to accept order?",
                                                            dataModel.id,dataModel,index);
                                                      },
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Text('Accept',
                                                        style: TextStyle(color: Colors.white),),
                                                    )
                                                ),
                                              ),
                                              Visibility(
                                                visible: dataModel.status=="Created"?true:false,
                                                child: Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(left: 2.0,right: 2.0),
                                                    child:
                                                    MyElevatedButton(
                                                      width: double.infinity,
                                                      onPressed: () {
                                                        alertDialog(
                                                            "Cancel",
                                                            "Are you sure you want to cancel order?",
                                                            dataModel.id,dataModel,index);
                                                      },
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Text('Cancel',
                                                        style: TextStyle(color: Colors.white),),
                                                    )
                                                ),
                                              ),
                                              Visibility(
                                                visible: dataModel.status=="Delivered"?true:false,
                                                child: Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(left: 5.0),
                                                    child: MyElevatedButton(
                                                      width: double.infinity,
                                                      onPressed: () {
                                                        /*alertDialog(
                                                            "Reorder",
                                                            "Are you sure you want to Reorder order?",
                                                            dataModel.id,dataModel);*/

                                                        purchaseOrderListController.reOrder(
                                                            "reorder", dataModel.id,dataModel);
                                                      },
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Text('Reorder',
                                                        style: TextStyle(color: Colors.white),),
                                                    )
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
                    )),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  void alertDialog(String str_1, String str_2, int? id, PurchaseOrderResponse dataModel,int index) {
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

                                purchaseOrderListController.processorder(
                                    str_1, id,index);
                                Get.back();

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

  Widget _displayProgress() {
    return Obx(() => purchaseOrderListController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }


  Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() => purchaseOrderListController.ontapSearchFalg.value == false
        ? AppBar(
      backgroundColor: toolbarColor,
      title: _appBarTitle(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child: _searchIcon,
            onTap: () {
              purchaseOrderListController.ontapSearchFalg.value = true;
              focusNode.requestFocus();
            },
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            //purchaseOrderListController.filterList(value);
            switch (value) {
              case 'Today':
                purchaseOrderListController.getTodaysData();
                break;
              case 'Old':
                pickDateRange();
                break;
             /* case 'All':
                purchaseOrderListController.getAllPurchaseOrder();
                break;*/
            }
          },
          icon: new Icon(Icons.filter_alt_rounded),
          itemBuilder: (BuildContext context) {
            return {'Today', 'Old'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    )
        : AppBar(
      backgroundColor: toolbarColor,
      title: new TextField(
        focusNode: focusNode,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        controller: purchaseOrderListController.filter_textedit,
        decoration: new InputDecoration(
          border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        onChanged: (value) {
          purchaseOrderListController
              .filterPurchaseOrder(value.toString());
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child: _searchIconRemove,
            onTap: () {
              purchaseOrderListController.ontapSearchFalg.value = false;
              purchaseOrderListController.clearFilter();
            },
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            //purchaseOrderListController.filterList(value);
            switch (value) {
              case 'Today':
                purchaseOrderListController.getTodaysData();
                break;
              case 'Old':
                pickDateRange();
                break;
             /* case 'All':
                purchaseOrderListController.getAllPurchaseOrder();
                break;*/
            }
          },
          icon: new Icon(Icons.filter_alt_rounded),
          itemBuilder: (BuildContext context) {
            return {'Today', 'Old'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    ));
  }

  Future pickDateRange() async {
    //https://www.youtube.com/watch?v=_G-JIdr2owQ
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (newDateTimeRange == null) return; //pressed'X'
    dateTimeRange = newDateTimeRange;
    if (newDateTimeRange != null) {
      purchaseOrderListController.getDataWithDateRange(dateTimeRange);
    }
  }

  Color getColor(String str) {
    Color color = new Color(0xFF000000);
    if (str == "Cancelled") {
      color = colorcancel;
    } else if (str == "Approved") {
      color = colorapproved;
    } else if (str == "Delivered") {
      color = Colors.black;
    } else if (str == "Dispatched") {
      color = colordispatched;
    } else if (str == "Created") {
      color = colorcreated;
    } else {
      color = Colors.black;
    }
    return color;
  }
}
