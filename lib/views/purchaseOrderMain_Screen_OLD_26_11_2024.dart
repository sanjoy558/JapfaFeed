import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/responses/PlantResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/purchaseOrderListController.dart';
import '../controllers/purchaseOrderMainController.dart';

class PurchaseOrderMainScreen extends StatefulWidget {
  bool  appbar_visibility1=false;
   PurchaseOrderMainScreen(bool appbar_visibility,{Key? key}){
     appbar_visibility1=appbar_visibility;
   }

  @override
  State<PurchaseOrderMainScreen> createState() =>
      _PurchaseOrderMainScreenState(appbar_visibility1);
}

class _PurchaseOrderMainScreenState extends State<PurchaseOrderMainScreen> {
  final purchaseOrderMainController = Get.put(PurchaseOrderMainController());

  bool appbarvisibility=false;
  _PurchaseOrderMainScreenState(bool appbar_visibility1){
    appbarvisibility=appbar_visibility1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {


        alertDialog("Discard");
        return false;
      },
      child: Scaffold(
        appBar: appbarvisibility?AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Text(
                'Purchase Order',
                style: TextStyle(
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${purchaseOrderMainController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Popins"),
              ),
              ),
            ],
          ),
        ):null,
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => purchaseOrderMainController.customerList.value.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                /* addplancontroller.selectedCustomerList.clear();
                          addplancontroller.selectedCustomerList.refresh();*/
                                purchaseOrderMainController
                                    .selected_customer_str.value = "";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Select Customers',
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w600,
                                              color: dashbordhighlight_blue),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                purchaseOrderMainController
                                                    .clerarfilterdTextfield();
                                                Get.back();
                                              },
                                              child: const Text('Cancel')),
                                          /* TextButton(
                                        onPressed: () {
                                          Get.back();
                                          purchaseOrderMainController
                                              .clerarfilterdTextfield();
                                          purchaseOrderMainController.doneSelection();
                                        },
                                        child: const Text('Done'))*/
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Customers',
                                          style: TextStyle(
                                              color: statgradient5,
                                              fontSize: 14.0,
                                              fontFamily: 'OpenSans',
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
                                                purchaseOrderMainController
                                                        .selected_customer_str
                                                        .isEmpty
                                                    ? 'Select'
                                                    : purchaseOrderMainController
                                                        .selected_customer_str
                                                        .value,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              )),
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                      'Transport Type',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Obx(
                                              () => Text(purchaseOrderMainController
                                                          .selected_transporttype_string ==
                                                      null
                                                  ? purchaseOrderMainController
                                                      .selected_transporttype_string
                                                      .value
                                                      .toString()
                                                  : purchaseOrderMainController
                                                      .selected_transporttype_string
                                                      .value
                                                      .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .transportList.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Text(e.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedTransportType(
                                                    value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //transport type
                          GestureDetector(
                              onTap: () {
                                purchaseOrderMainController
                                    .selected_dropdown_string.value = "";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Select Plant',
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w600,
                                              color: dashbordhighlight_blue),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                purchaseOrderMainController
                                                    .clerarfilterdTextfieldPlant();
                                                Get.back();
                                              },
                                              child: const Text('Cancel')),
                                        ],
                                        content: setupAlertDialogPlant(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Plant',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0,
                                              fontFamily: 'OpenSans',
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
                                                purchaseOrderMainController
                                                            .selected_dropdown_object ==
                                                        null
                                                    ? purchaseOrderMainController
                                                        .selected_dropdown_string
                                                        .value
                                                        .toString()
                                                    : purchaseOrderMainController
                                                        .selected_dropdown_string
                                                        .value
                                                        .toString(),
                                                style: const TextStyle(
                                                    color: dashbordhighlight_blue,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              )),

                          /* Container(
                            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0,top: 5.0,right: 5.0,bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Plant',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<PlantResponse>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                            child: Obx(
                                                  () => Text(purchaseOrderMainController
                                                  .selected_dropdown_object ==
                                                  null
                                                  ? purchaseOrderMainController
                                                  .selected_dropdown_string
                                                  .value
                                                  .toString()
                                                  : purchaseOrderMainController
                                                  .selected_dropdown_string
                                                  .value
                                                  .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController.plantlsit.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      .4,
                                                  child:
                                                  Text(e.name.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            */ /*purchaseOrderMainController.setSelected(value!);*/ /*
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),//plant*/
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: const Text(
                                        'Payment Details',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18.0,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        maxLines: 4,
                                        cursorColor: Colors.black,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter Payment Details(If Any)',
                                            hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400)),
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                        controller: purchaseOrderMainController
                                            .payment_details,
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.words,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        myAlert();

                                        //MainPresenter.getInstance().printLog("userid appbar_visibility", appbarvisibility);
                                      },
                                      child: Text('Upload Photo'),
                                    ),
                                    Center(
                                      child: Text(
                                        '${purchaseOrderMainController.imagename == "" ? "N/A" : purchaseOrderMainController.image!.name}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.0,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //payment details
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                      'Brand',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Obx(
                                              () => Text(purchaseOrderMainController
                                                          .selected_dropdown_brand ==
                                                      ""
                                                  ? "Select Brand"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_brand
                                                      .value
                                                      .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .brandlist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Text(e.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedBrandvalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //brand

                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                      'Bird',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Obx(
                                              () => Text(purchaseOrderMainController
                                                          .selected_dropdown_bird ==
                                                      ""
                                                  ? "Select Bird"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_bird
                                                      .value
                                                      .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .birdlist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Text(e.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedBirdvalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //bird
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                      'Stage',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Obx(
                                              () => Text(purchaseOrderMainController
                                                          .selected_dropdown_stage ==
                                                      ""
                                                  ? "Select Stage"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_stage
                                                      .value
                                                      .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .stagelist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Text(e.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedStagevalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //stage
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                      'Material',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Obx(
                                              () => Text(purchaseOrderMainController
                                                          .selected_dropdown_matrial ==
                                                      ""
                                                  ? "Select Material"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_matrial
                                                      .value
                                                      .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .matriallist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: Text(e.toString())),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .selectmatrial(value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //matrial

                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Bags Qty',
                                            style: TextStyle(
                                                color: planred,
                                                fontSize: 14.0,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            child: TextFormField(
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              cursorColor: Colors.black,
                                              textInputAction:
                                                  TextInputAction.next,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0',
                                                  hintStyle: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.start,
                                              controller:
                                                  purchaseOrderMainController
                                                      .bags_qty,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (text) {
                                                purchaseOrderMainController
                                                    .bagsqty
                                                    .value = text.trim();
                                                purchaseOrderMainController
                                                    .getqty();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'KG',
                                            style: TextStyle(
                                                color: planred,
                                                fontSize: 14.0,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            purchaseOrderMainController
                                                        .bags_in_kg ==
                                                    ""
                                                ? "0"
                                                : purchaseOrderMainController
                                                    .bags_in_kg.value
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.0,
                                child: ElevatedButton(
                                  onPressed: purchaseOrderMainController.submit,
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(15)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0)),
                                      ))),
                                  child: const Text(
                                    'Add Product',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),

                          addedList()
                        ],
                      ),
                    )),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => purchaseOrderMainController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }




  Widget addedList() {
    return GetBuilder<PurchaseOrderMainController>(builder: (controller) {
      return Column(
        children: [
          ListView.builder(
            itemCount: purchaseOrderMainController.tempProductList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var dataModel =
                  purchaseOrderMainController.tempProductList[index];
              return Stack(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    elevation: 5,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${dataModel.brand} ${dataModel.bird}\n ${dataModel.stage} ${dataModel.material} ',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'Bags',
                                                  style: TextStyle(
                                                      color: planred,
                                                      fontSize: 14.0,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  textAlign: TextAlign.end,
                                                  '${dataModel.noOfBags}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'Qty(Kgs)',
                                                  style: TextStyle(
                                                      color: planred,
                                                      fontSize: 14.0,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  textAlign: TextAlign.end,
                                                  '${dataModel.totalQuantity}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        elevation: 5,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: GestureDetector(
                          onTap: (){
                            deleteProductRecord(dataModel.productid);
                          },
                          child: Icon(
                            Icons.dangerous_outlined,
                            size: 35.0,
                          ),
                        ),
                      ))
                ],
              );

              /* return Dismissible(key: Key(dataModel!.productid.toString()),
                      background: Card(color: Colors.red,
                      child: Center(
                        child: Text("Deleted",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                        ),),
                      ),),
                      onDismissed: (direction){
                    print(direction);
                    purchaseOrderMainController.removeProductFromTempList(dataModel.productid);
                      },
                      direction: DismissDirection.endToStart,
                      child: GestureDetector(
                    onTap: () {
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      elevation: 5,
                      margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex:4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${dataModel.brand} ${dataModel.bird} ${dataModel.stage} ${dataModel.material} ',
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Bags',
                                                    style: TextStyle(
                                                        color: planred,
                                                        fontSize: 14.0,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    textAlign: TextAlign.end,
                                                    '${dataModel.noOfBags}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                          Expanded(child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Qty(Kgs)',
                                                    style: TextStyle(
                                                        color: planred,
                                                        fontSize: 14.0,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    textAlign: TextAlign.end,
                                                    '${dataModel.totalQuantity}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ],
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));*/
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                child:Obx(() => ElevatedButton(
                  onPressed: purchaseOrderMainController.approveProduct,
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(getColor("")),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                          ))),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),),
              ),
            ],
          ),
        ],
      );
    });
  }

  /*Widget addedList(){
    return
      Obx(() => purchaseOrderMainController.tempProductList.value.isEmpty
          ? Container() : ListView.builder(
            itemCount:
            purchaseOrderMainController.tempProductList.value.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var dataModel =
              purchaseOrderMainController.tempProductList.value[index];
              return GestureDetector(
                onTap: () {
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                  elevation: 5,
                  margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${dataModel.brand} ${dataModel.bird} ${dataModel.stage} ${dataModel.material} ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Bags',
                                                style: TextStyle(
                                                    color: planred,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                textAlign: TextAlign.end,
                                                '${dataModel.noOfBags}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Qty(Kgs)',
                                                style: TextStyle(
                                                    color: planred,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                textAlign: TextAlign.end,
                                                '${dataModel.totalQuantity}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ],
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ));

  }*/

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
                      purchaseOrderMainController
                          .filterPlayer(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                    controller: purchaseOrderMainController
                        .addplan_name_customer_fliter,
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
                  itemCount:
                      purchaseOrderMainController.filteredCustomerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel = purchaseOrderMainController
                        .filteredCustomerList.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        purchaseOrderMainController.clerarfilterdTextfield();
                        purchaseOrderMainController.doneSelection(
                            dataModel.firstName.toString(),
                            dataModel.id.toString(),
                            dataModel.zone.toString());
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.firstName.toString()),
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

  Widget setupAlertDialogPlant() {
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
                      purchaseOrderMainController.filterPlant(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Plant Name',
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                    controller:
                        purchaseOrderMainController.textEditPlantController,
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
                  itemCount:
                      purchaseOrderMainController.filteredplantlsit.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel = purchaseOrderMainController
                        .filteredplantlsit.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        purchaseOrderMainController
                            .clerarfilterdTextfieldPlant();
                        purchaseOrderMainController.setPlantSelected(dataModel);
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.name.toString()),
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

  void deleteProductRecord(String? productid){
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
                      const Text(
                        "Delete",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Are you sure you want to delete product?",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                'NO',
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
                                'YES',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                purchaseOrderMainController.removeProductFromTempList(productid);
                                FocusManager.instance.primaryFocus!.unfocus();
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




  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Color getColor(String str) {
    Color color = new Color(0xFFD6CCC2);
    if (purchaseOrderMainController.showButtonSubmitColor.value) {
      color = Colors.red;
    } else{
      color = noDatacolor2;
    }
    return color;
  }

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    purchaseOrderMainController.setimage(img);
  }

  void alertDialog(String str_exit_logout) {
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
                            color: dashbordhighlight_blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${str_exit_logout}",
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
                        "Do you want to discard now?",
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
                              child: Text('Yes',
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
                                Get.back();

                                purchaseOrderMainController.selected_dropdown_string.value="Select Plant";
                                purchaseOrderMainController.selected_transporttype_string.value="Select Transport";
                                purchaseOrderMainController.selected_customer_str.value="Select";
                                purchaseOrderMainController.selected_customer_id.value="";
                                purchaseOrderMainController.selected_customer_zone.value="";
                                purchaseOrderMainController.selected_dropdown_brand.value="";
                                purchaseOrderMainController.selected_dropdown_bird.value="";
                                purchaseOrderMainController.selected_dropdown_stage.value="";
                                purchaseOrderMainController.selected_dropdown_matrial.value="";
                                purchaseOrderMainController.bags_qty.text="";
                                purchaseOrderMainController.bags_in_kg.value="";
                                purchaseOrderMainController.tempProductList.clear();
                                purchaseOrderMainController.changetab(0);

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
