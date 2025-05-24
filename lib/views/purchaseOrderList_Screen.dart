import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:japfa_feed_application/views/purchaseOrderMain_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/purchaseOrderListController.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  final purchaseOrderListController = Get.put(PurchaseOrderListController());
  var focusNode = FocusNode();
  Icon _searchIcon = new Icon(
    Icons.search,
    size: 30.0,
  );
  Icon _searchIconRemove = new Icon(
    Icons.close,
    size: 30.0,
  );

  Widget _appBarTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Text(
          'Purchase Order',
          style: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),*/
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

  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime(2022, 11, 15), end: DateTime(2022, 12, 24));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    /*purchaseOrderListController.fromdate_str.value=dateTimeRange.start as String;
    purchaseOrderListController.todate_str.value=dateTimeRange.end as String;*/
    return WillPopScope(
      onWillPop: () async {
        purchaseOrderListController.changetab(0);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: statgradient5,
          onPressed: () {
            purchaseOrderListController.goToMainPurchaseOrderScreen();
          },
        ),
        appBar: PreferredSize(
            child: _displayAppBar(), preferredSize: const Size.fromHeight(56)),
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  /* Wrap(
                            direction: Axis.horizontal,
                            children: [
                              purchaseOrderTab(0),
                              purchaseOrderTab(1),

                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),*/

                  /* Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      hint: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Obx(
                              () => Text(purchaseOrderListController
                              .dropdown_order_status_str ==
                              null
                              ? purchaseOrderListController
                              .dropdown_order_status_str
                              .value
                              .toString()
                              : purchaseOrderListController
                              .dropdown_order_status_str
                              .value
                              .toString()),
                        ),
                      ),
                      items: purchaseOrderListController.orderStatusList.value
                          .map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: SizedBox(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  .4,
                              child:
                              Text(e.toString())),
                        );
                      }).toList(),
                      onChanged: (value) {
                        //purchaseOrderListController.setSelectedAppType(value!);
                        purchaseOrderListController.filterPurchaseOrder("2",value!);
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                      },
                    ),
                  ),*/

                  Expanded(
                      child: Obx(
                    () => purchaseOrderListController
                            .filteredPurchaseOrderList.value.isEmpty
                        ? purchaseOrderListController.Data1.value
                            ? noDataPurchaseOrder()
                            : Container()
                        : SingleChildScrollView(
                            physics: ScrollPhysics(),
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
                                    purchaseOrderListController
                                        .purchaseOrderDetails(
                                            purchaseOrderListController
                                                .filteredPurchaseOrderList
                                                .value[index]);
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
                                                  /*Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        'Mob no. : ${dataModel.customer!.phone}',
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                            'OpenSans',
                                                            fontWeight:
                                                            FontWeight
                                                                .w600)),
                                                  ),*/
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
                                                    Column(
                                                      children: [
                                                        const Text(
                                                          'Sap id.',
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
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${dataModel.sapId}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.0,
                                                              fontFamily:
                                                                  'Gilroy',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )

                            /* Obx(() => purchaseOrderListController
                          .filteredPurchaseOrderList.value.isEmpty
                          ? Container():,)*/

                            ,
                          ),
                  )),
                ],
              ),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => purchaseOrderListController.displayLoading.value == true
        ? Center(child: progressBarCommon())
        : Container());
  }

  /*Widget _displayAppBar(){
    return AppBar(backgroundColor: dashbordhighlight_blue, title: _appBarTitle,
      actions: [
        PopupMenuButton<String>(
          onSelected:(value){
            //purchaseOrderListController.filterList(value);
            switch (value) {
              case 'Today':
                purchaseOrderListController.getTodaysData();
                break;
              case 'Old':
                pickDateRange();
                break;
              case 'All':
                purchaseOrderListController.getAllPurchaseOrder();
                break;
            }
          },
          icon: new Icon(Icons.filter_alt_rounded),
          itemBuilder: (BuildContext context) {
            return {'Today', 'Old','All'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),


      ],);
  }*/

  Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() => purchaseOrderListController.ontapSearchFalg.value == false
        ? AppBar(
            backgroundColor: toolbarColor,
            title: _appBarTitle(),
            actions: [
              Container(
                width: 30,
                height: 30,
                child: GestureDetector(
                  child: _searchIcon,
                  onTap: () {
                    purchaseOrderListController.ontapSearchFalg.value = true;
                    focusNode.requestFocus();
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    //purchaseOrderListController.filterList(value);
                    switch (value) {
                      case 'Today':
                        purchaseOrderListController.getTodaysData();
                        break;
                      case 'Old':
                        pickDateRange();
                        break;
                      /*   case 'All':
                  purchaseOrderListController.getAllPurchaseOrder();
                  break;*/
                    }
                  },
                  icon: new Icon(Icons.filter_alt_rounded),
                  itemBuilder: (BuildContext context) {
                    return {'Today', 'Old'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 5.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    //purchaseOrderListController.filterList(value);
                    switch (value) {
                      case 'Created':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Created");
                        break;
                      case 'Approved':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Approved");
                        break;
                      case 'Dispatched':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Dispatched");
                        break;
                      case 'Delivered':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Delivered");
                        break;
                      case 'Cancelled':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Cancelled");
                        break;
                    }
                  },
                  icon: new Icon(Icons.sort),
                  itemBuilder: (BuildContext context) {
                    return {
                      'Created',
                      'Approved',
                      'Dispatched',
                      'Delivered',
                      'Cancelled'
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList();
                  },
                ),
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
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400)),
              onChanged: (value) {
                purchaseOrderListController.filterPurchaseOrder(
                    "1", value.toString());
              },
            ),
            actions: [
              Container(
                width: 30,
                height: 30,
                child: GestureDetector(
                  child: _searchIconRemove,
                  onTap: () {
                    purchaseOrderListController.ontapSearchFalg.value = false;
                    purchaseOrderListController.clearFilter();
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                child: PopupMenuButton<String>(
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
              ),
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 5.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    //purchaseOrderListController.filterList(value);
                    switch (value) {
                      case 'Created':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Created");
                        break;
                      case 'Approved':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Approved");
                        break;
                      case 'Dispatched':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Dispatched");
                        break;
                      case 'Delivered':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Delivered");
                        break;
                      case 'Cancelled':
                        purchaseOrderListController.filterPurchaseOrder(
                            "2", "Cancelled");
                        break;
                    }
                  },
                  icon: new Icon(Icons.sort),
                  itemBuilder: (BuildContext context) {
                    return {
                      'Created',
                      'Approved',
                      'Dispatched',
                      'Delivered',
                      'Cancelled'
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
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

/*Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() => purchaseOrderListController.ontapSearchFalg.value == false
        ? AppBar(backgroundColor: dashbordhighlight_blue, title: _appBarTitle,
      */ /*actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child:
            _searchIcon,
            onTap: () {
              */ /**/ /*purchaseOrderListController.ontapSearchFalg.value=true;
              focusNode.requestFocus();*/ /**/ /*
            },
          ),
        ),
      ],*/ /*)
        : AppBar(
            backgroundColor: dashbordhighlight_blue,
            title: new TextField(
              focusNode: focusNode,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              controller: _filter,
              decoration: new InputDecoration(hintText: 'Search...',hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child:_searchIconRemove,
            onTap: () {
              //purchaseOrderListController.ontapSearchFalg.value=false;
            },
          ),
        ),
      ],));
  }*/

/*Widget purchaseOrderTab(int buttontype) {
    return Obx(() => buttontype == 1
        ? Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: purchaseOrderListController.ui_tabtypeflag.value == 1
              ? dashbordhighlight_blue
              : Colors.grey),
      height: 50,
      width: MediaQuery.of(context).size.width/2,
      child: GestureDetector(
        onTap: () {
          purchaseOrderListController.changePageTab(1);
        },
        child: Text(
          'Old',
          style: TextStyle(
              fontSize: 20.0,
              color: purchaseOrderListController.ui_tabtypeflag.value == 1
                  ? Colors.white
                  : Colors.black54,
              decoration: TextDecoration.none),
        ),
      ),
    )
        :Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: purchaseOrderListController.ui_tabtypeflag.value == 0
              ? dashbordhighlight_blue
              : Colors.grey),
      height: 50,
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          purchaseOrderListController.changePageTab(0);
        },
        child: Text(
          'Today',
          style: TextStyle(
            fontSize: 20.0,
            color: purchaseOrderListController.ui_tabtypeflag.value == 0
                ? Colors.white
                : Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    ));
  }*/
}
