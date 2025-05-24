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
  bool appbar_visibility1 = false;

  PurchaseOrderMainScreen(bool appbar_visibility, {Key? key}) {
    appbar_visibility1 = appbar_visibility;
  }

  @override
  State<PurchaseOrderMainScreen> createState() =>
      _PurchaseOrderMainScreenState(appbar_visibility1);
}

class _PurchaseOrderMainScreenState extends State<PurchaseOrderMainScreen> {
  final purchaseOrderMainController = Get.put(PurchaseOrderMainController());

  bool appbarvisibility = false;

  _PurchaseOrderMainScreenState(bool appbar_visibility1) {
    appbarvisibility = appbar_visibility1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        alertDialog("Discard");
        return false;
      },
      child: Scaffold(
        appBar: appbarvisibility
            ? AppBar(
                backgroundColor: primaryColor,
                elevation: 0.0,
                title: Column(
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
                    Obx(
                      () => Text(
                        "DIV - ${purchaseOrderMainController.division_name.value}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontFamily: "Popins"),
                      ),
                    ),
                  ],
                ),
              )
            : null,
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
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                purchaseOrderMainController
                                                    .clerarfilterdTextfield();
                                                Get.back();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontFamily: "Popins",
                                                  color: Colors.black,
                                                ),
                                              )),
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
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: const Text(
                                          'Customers',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                // Place Expanded here
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 15.0,
                                                          bottom: 15.0),
                                                  child: Obx(
                                                    () => Text(
                                                      purchaseOrderMainController
                                                              .selected_customer_str
                                                              .isEmpty
                                                          ? 'Select'
                                                          : purchaseOrderMainController
                                                              .selected_customer_str
                                                              .value,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontFamily: "Popins",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign: TextAlign.left,
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
                                    ],
                                  ),
                                ),
                              )),
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  right: 5.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: const Text(
                                      'Transport Type',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: "Popins",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: DropdownButtonHideUnderline(
                                          // Hide the underline for consistency
                                          child: DropdownButton<String>(

                                            isExpanded: true,
                                            // Ensures the dropdown matches the parent width
                                            hint: Obx(
                                              () => Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: Text(
                                                  purchaseOrderMainController
                                                      .selected_transporttype_string
                                                      .value,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontFamily: "Popins",
                                                      fontWeight: FontWeight
                                                          .w600), // Handle long text
                                                ),
                                              ),
                                            ),
                                            items: purchaseOrderMainController
                                                .transportList.value
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.toString(),
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontFamily: "Popins",
                                                      fontWeight: FontWeight
                                                          .w600), // Prevent overflow
                                                ),
                                              );
                                            }).toList(),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                            ),
                                            onChanged: (value) {
                                              purchaseOrderMainController
                                                  .setSelectedTransportType(
                                                      value!);
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //transport type
                          GestureDetector(
                              onTap: () {
                                purchaseOrderMainController
                                    .selected_dropdown_string
                                    .value = "Select Plant";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Select Plant',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                purchaseOrderMainController
                                                    .clerarfilterdTextfieldPlant();
                                                Get.back();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Popins",
                                                ),
                                              )),
                                        ],
                                        content: setupAlertDialogPlant(),
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: const Text(
                                          'Plant',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 15.0,
                                                          bottom: 15.0),
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
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontFamily: "Popins",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign: TextAlign.left,
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
                                      )
                                    ],
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
                                margin: EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: const Text(
                                        'Payment Details',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontFamily: 'Popins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        cursorColor: Colors.black,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter Payment Details(If Any)',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Popins',
                                                fontSize: 16.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400)),
                                        style: const TextStyle(
                                            fontFamily: 'Popins',
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
                                    ElevatedButton(style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(statgradient5),
                                    ),
                                      onPressed: () {
                                        myAlert();

                                        //MainPresenter.getInstance().printLog("userid appbar_visibility", appbarvisibility);
                                      },
                                      child: Text(
                                        'Upload Photo',
                                        style: TextStyle(
                                            fontFamily: 'Popins',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '${purchaseOrderMainController.imagename == "" ? "N/A" : purchaseOrderMainController.image!.name}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14.0,
                                            fontFamily: 'Popins',
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
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  right: 5.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: const Text(
                                      'Brand',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: 'Popins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                            () => Text(
                                              purchaseOrderMainController
                                                      .selected_dropdown_brand
                                                      .value
                                                      .isEmpty
                                                  ? "Select Brand"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_brand
                                                      .value,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight
                                                      .w600), // Handle long text
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .brandlist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                    fontFamily: "Popins",
                                                    fontWeight: FontWeight
                                                        .w600), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedBrandvalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //brand

                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  right: 5.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: const Text(
                                      'Bird',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: "Popins",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                            () => Text(
                                              purchaseOrderMainController
                                                      .selected_dropdown_bird
                                                      .value
                                                      .isEmpty
                                                  ? "Select Bird"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_bird
                                                      .value,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: "Popins",
                                                fontWeight: FontWeight.w600,
                                              ), // Handle long text
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .birdlist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w600,
                                                ), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedBirdvalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //bird
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  right: 5.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: const Text(
                                      'Stage',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: 'Popins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                            () => Text(
                                              purchaseOrderMainController
                                                      .selected_dropdown_stage
                                                      .value
                                                      .isEmpty
                                                  ? "Select Stage"
                                                  : purchaseOrderMainController
                                                      .selected_dropdown_stage
                                                      .value,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: "Popins",
                                                fontWeight: FontWeight.w600,
                                              ), // Handle long text
                                            ),
                                          ),
                                          items: purchaseOrderMainController
                                              .stagelist.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w600,
                                                ), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .setSelectedStagevalue(value!);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //stage
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  right: 5.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: const Text(
                                      'Material',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: "Popins",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 5.0),
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              // Ensures the dropdown matches the parent width
                                              hint: Obx(
                                                () => Text(
                                                  purchaseOrderMainController
                                                          .selected_dropdown_matrial
                                                          .value
                                                          .isEmpty
                                                      ? "Select Material"
                                                      : purchaseOrderMainController
                                                          .selected_dropdown_matrial
                                                          .value,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                    fontFamily: "Popins",
                                                    fontWeight: FontWeight.w600,
                                                  ), // Handle long text
                                                ),
                                              ),
                                              items: purchaseOrderMainController
                                                  .matriallist.value
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e.toString(),
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontFamily: "Popins",
                                                      fontWeight: FontWeight.w600,
                                                    ), // Prevent overflow
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                purchaseOrderMainController
                                                    .selectmatrial(value!);
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5.0),
                                          child: Obx(() =>Visibility(
                                            visible: purchaseOrderMainController
                                                .selected_dropdown_matrial
                                                .value==""?false:true,
                                            child: Text(
                                              "${purchaseOrderMainController
                                                  .selected_dropdown_matrial_text.value}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  fontFamily: 'Popins',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ) ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //matrial

                          /*Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 50, // Set the height of the container to 50
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2), // Container border
                                borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                              ),
                              child: Row(
                                children: [
                                  Text('Enter Name: '), // The Text widget
                                  SizedBox(width: 10), // Space between the Text and TextFormField
                                  Expanded( // Make TextFormField take remaining space
                                    child: TextFormField(
                                      focusNode: purchaseOrderMainController.focusNode,
                                      decoration: InputDecoration(
                                        border: InputBorder.none, // No border for TextFormField
                                        // If the field is focused, label will be shown instead of hint
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                          Container(
                            margin: EdgeInsets.only(
                                left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        // Label for Bags Qty
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Bags Qty : ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontFamily: 'Popins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        // TextFormField for input
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1.0),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                height: 45,
                                                alignment: Alignment.center,
                                                // Aligns TextFormField to the right
                                                child: TextFormField(
                                                  cursorColor: Colors.black,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "Popins",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
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
                                              Container(
                                                child: Obx(() =>Visibility(
                                                  visible: purchaseOrderMainController
                                                      .bags_in_kg.value==""?false:purchaseOrderMainController
                                                      .bags_in_kg.value=="0"?false:true,
                                                  child: Text(
                                                    textAlign: TextAlign.end,
                                                    "${purchaseOrderMainController
                                                        .bags_in_kg.value} KG",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily: 'Popins',
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ) ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

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

                                              statgradient5),
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
        ? Center(child: progressBarCommon())
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
                                                      color: statgradient5,
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
                                                      color: statgradient5,
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
                          onTap: () {
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
                child: Obx(
                  () => ElevatedButton(
                    onPressed: purchaseOrderMainController.approveProduct,
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(getColor("")),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  ),
                ),
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
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: "Popins",
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
                        title: Text(
                          dataModel.firstName.toString(),
                          style: TextStyle(
                            fontFamily: "Popins",
                          ),
                        ),
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
                            fontFamily: "Popins",
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontFamily: "Popins",
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
                        title: Text(
                          dataModel.name.toString(),
                          style: TextStyle(
                            fontFamily: "Popins",
                          ),
                        ),
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

  void deleteProductRecord(String? productid) {
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
                                purchaseOrderMainController
                                    .removeProductFromTempList(productid);
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
      color = statgradient5;
    } else {
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
                            color: statgradient5,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${str_exit_logout}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Do you want to discard now?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Popins",
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text('Yes',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: "Popins",
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

                                purchaseOrderMainController
                                    .selected_dropdown_string
                                    .value = "Select Plant";
                                purchaseOrderMainController
                                    .selected_transporttype_string
                                    .value = "Select Transport";
                                purchaseOrderMainController
                                    .selected_customer_str.value = "Select Customer";
                                purchaseOrderMainController
                                    .selected_customer_id.value = "";
                                purchaseOrderMainController
                                    .selected_customer_zone.value = "";
                                purchaseOrderMainController
                                    .selected_dropdown_brand.value = "";
                                purchaseOrderMainController
                                    .selected_dropdown_bird.value = "";
                                purchaseOrderMainController
                                    .selected_dropdown_stage.value = "";
                                purchaseOrderMainController
                                    .selected_dropdown_matrial.value = "";
                                purchaseOrderMainController.bags_qty.text = "";
                                purchaseOrderMainController.bags_in_kg.value =
                                "";
                                purchaseOrderMainController.tempProductList
                                    .clear();
                                purchaseOrderMainController.changetab(0);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              child: const Text('No',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: "Popins",
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
