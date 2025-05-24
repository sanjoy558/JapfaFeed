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
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
                    Obx(
                      () => Text(
                        "DIV - ${purchaseOrderMainController.division_name.value}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontFamily: "Gilroy"),
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
                                              fontFamily: "Gilroy",
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
                                                  fontFamily: "Gilroy",
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
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
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
                                                ? 'Select Customer'
                                                : purchaseOrderMainController
                                                .selected_customer_str
                                                .value,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: "Gilroy",
                                                fontWeight:
                                                FontWeight.w600),
                                            textAlign: TextAlign.left,
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
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    // Hide the underline for consistency
                                    child: DropdownButton<String>(

                                      isExpanded: true,
                                      // Ensures the dropdown matches the parent width
                                      padding: EdgeInsets.only(left: 15.0),
                                      hint: Obx(
                                            () => Container(
                                              padding: EdgeInsets.only(left: 10.0),
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            purchaseOrderMainController
                                                .selected_transporttype_string
                                                .value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: "Gilroy",
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
                                                fontFamily: "Gilroy",
                                                fontWeight: FontWeight
                                                    .w600), // Prevent overflow
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
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
                                              fontFamily: "Gilroy",
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
                                                  fontFamily: "Gilroy",
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
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Row(
                                    children: [

                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
                                      ),

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
                                                  fontFamily: "Gilroy",
                                                  fontWeight:
                                                  FontWeight.w600),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: bordercolor1,width: 2.0),
                            ),
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),

                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child:  Image.asset(
                                          'assets/images/paymentnew.png',
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: texteditbackgorund,
                                            borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            cursorColor: Colors.black,
                                            textInputAction: TextInputAction.done,
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.all(20.0),
                                                border: InputBorder.none,
                                                hintText:
                                                    'Enter Payment Details(If Any)',

                                                hintStyle: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 16.0,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400)),
                                            style: const TextStyle(
                                                fontFamily: 'Gilroy',
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
                                      ),
                                      Column(
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              myAlert();
                                            },
                                            child: Container(
                                              child:  Image.asset(
                                                'assets/images/uploadnew1.png',
                                                width: 100.0,
                                              ),
                                            ),
                                          ),
                                         /* ElevatedButton(style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(statgradient5),
                                          ),
                                            onPressed: () {
                                              myAlert();

                                              //MainPresenter.getInstance().printLog("userid appbar_visibility", appbarvisibility);
                                            },
                                            child: Text(
                                              'Upload Photo',
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: Colors.white),
                                            ),
                                          ),*/
                                          Visibility(
                                            visible: purchaseOrderMainController.imagename == "" ? true: false,
                                            child: Center(
                                              child: Text(
                                                '${purchaseOrderMainController.imagename == "" ? "N/A" : purchaseOrderMainController.image!.name}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: purchaseOrderMainController.imagename == "" ? false: true,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${purchaseOrderMainController.imagename == "" ? "N/A" : purchaseOrderMainController.image!.name}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                alertDialogRemoveImage("Discard Image");
                                              },
                                              child: Icon(Icons.delete, color: Colors.grey,size: 30.0,),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //payment details
                          Container(
                            padding:
                            const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      // Ensures the dropdown matches the parent width
                                      padding: EdgeInsets.only(left: 15.0),
                                      hint: Obx(
                                            () => Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: EdgeInsets.only(left: 10.0),
                                              child: Text(
                                          purchaseOrderMainController
                                                .selected_dropdown_brand
                                                .value
                                                .isEmpty
                                                ? "Select Brand"
                                                : purchaseOrderMainController
                                                .selected_dropdown_brand
                                                .value,
                                                textAlign: TextAlign.left,
                                          style: TextStyle(
                                                overflow:
                                                TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: "Gilroy",
                                                fontWeight: FontWeight
                                                    .w600), // Handle long text
                                        ),
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
                                                fontFamily: "Gilroy",
                                                fontWeight: FontWeight
                                                    .w600), // Prevent overflow
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
                                      ),
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
                            ),
                          ), //brand

                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      padding: EdgeInsets.only(left: 15.0),
                                      // Ensures the dropdown matches the parent width
                                      hint: Obx(
                                        () => Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            purchaseOrderMainController
                                                    .selected_dropdown_bird
                                                    .value
                                                    .isEmpty
                                                ? "Select Bird"
                                                : purchaseOrderMainController
                                                    .selected_dropdown_bird
                                                    .value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600,
                                            ), // Handle long text
                                          ),
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
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600,
                                            ), // Prevent overflow
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
                                      ),
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
                            ),
                          ), //bird
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      padding: EdgeInsets.only(left: 15.0),
                                      // Ensures the dropdown matches the parent width
                                      hint: Obx(
                                        () => Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            purchaseOrderMainController
                                                    .selected_dropdown_stage
                                                    .value
                                                    .isEmpty
                                                ? "Select Stage"
                                                : purchaseOrderMainController
                                                    .selected_dropdown_stage
                                                    .value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600,
                                            ), // Handle long text
                                          ),
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
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600,
                                            ), // Prevent overflow
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: dropdowncolor,
                                      ),
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
                            ),
                          ), //stage
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          padding: EdgeInsets.only(left: 15.0),
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                                () => Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                              purchaseOrderMainController
                                                    .selected_dropdown_matrial
                                                    .value
                                                    .isEmpty
                                                    ? "Select Material"
                                                    : purchaseOrderMainController
                                                    .selected_dropdown_matrial
                                                    .value,
                                                    textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                              ), // Handle long text
                                            ),
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
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                                ), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: dropdowncolor,
                                          ),
                                          onChanged: (value) {
                                            purchaseOrderMainController
                                                .selectmatrial(value!);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               /* Container(
                                  margin: EdgeInsets.only(top: 5.0,right: 10.0),
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
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ) ),
                                )*/
                              ],
                            ),
                          ), //matrial
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          padding: EdgeInsets.only(left: 15.0),
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                                () => Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                              purchaseOrderMainController
                                                    .selected_dropdown_materialText
                                                    .value
                                                    .isEmpty
                                                    ? "Select Material Text"
                                                    : purchaseOrderMainController
                                                    .selected_dropdown_materialText
                                                    .value,
                                                    textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                              ), // Handle long text
                                            ),
                                                ),
                                          ),
                                          items: purchaseOrderMainController
                                              .materialTextList.value
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
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                                ), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: dropdowncolor,
                                          ),
                                          onChanged: (value) {

                                            purchaseOrderMainController
                                                .selectmatrialText(value!);
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
                          ), //matrialText
                          Container(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          padding: EdgeInsets.only(left: 15.0),
                                          // Ensures the dropdown matches the parent width
                                          hint: Obx(
                                                () => Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                              purchaseOrderMainController
                                                    .selected_dropdown_Weight
                                                    .value
                                                    .isEmpty
                                                    ? "Select Weight"
                                                    : purchaseOrderMainController
                                                    .selected_dropdown_Weight
                                                    .value,
                                                    textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                              ), // Handle long text
                                            ),
                                                ),
                                          ),
                                          items: purchaseOrderMainController
                                              .productWeightList.value
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
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w600,
                                                ), // Prevent overflow
                                              ),
                                            );
                                          }).toList(),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: dropdowncolor,
                                          ),
                                          onChanged: (value) {

                                            purchaseOrderMainController
                                                .selectmatrialWeight(value!);
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
                          ), //matrial weight


                          Container(
                            padding:
                            const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  elevation: 4,
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    // Aligns TextFormField to the right
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0,right: 10.0),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            size: 25.0,
                                            Icons.numbers,
                                            color: dropdowncolor,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            cursorColor: Colors.black,
                                            textInputAction:
                                                TextInputAction.next,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            decoration: const InputDecoration(
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                              labelText: 'Bags Qty',
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: "Gilroy",
                                                color: Colors.black
                                              )
                                            ),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: "Gilroy",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.left,
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
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
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
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ) ),
                                )

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

                                              callbuttoncolor),
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
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                          colors: [startjourneyGradient1, startjourneyGradient2]),
                    ),
                    child: ElevatedButton(
                      onPressed: purchaseOrderMainController.approveProduct,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(getColor("")),
                          shadowColor:MaterialStateProperty.all<Color>(Colors.transparent) ,
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
              ),
            ],
          ),
        ],
      );
    });
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
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: "Gilroy",
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
                            fontFamily: "Gilroy",
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
                            fontFamily: "Gilroy",
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontFamily: "Gilroy",
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
                            fontFamily: "Gilroy",
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
                        Icon(Icons.image,color: Colors.white,),
                        SizedBox(width: 10.0,),
                        Text('From Gallery',style: TextStyle(
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),),
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
                        Icon(Icons.camera,color: Colors.white,),
                        SizedBox(width: 10.0,),
                        Text('From Camera',style: TextStyle(
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                        ),),
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
      color = Colors.transparent;
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
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Do you want to discard now?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Gilroy",
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
                                      fontFamily: "Gilroy",
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

                                purchaseOrderMainController.imagename.value="";
                                purchaseOrderMainController.base64img="";
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
                                      fontFamily: "Gilroy",
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
  void alertDialogRemoveImage(String str_exit_logout) {
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
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Do you want to discard image now?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Gilroy",
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
                                      fontFamily: "Gilroy",
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

                                purchaseOrderMainController.imagename.value="";
                                purchaseOrderMainController.base64img="";
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
                                      fontFamily: "Gilroy",
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
