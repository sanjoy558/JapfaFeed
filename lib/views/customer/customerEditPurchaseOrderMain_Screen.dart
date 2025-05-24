import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerEditPurchaseOrderMainController.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerPurchaseOrderMainController.dart';
import 'package:japfa_feed_application/responses/PlantResponse.dart';
import 'package:japfa_feed_application/responses/TempProductList.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class CustomerEditPurchaseOrderMainScreen extends StatefulWidget {

  bool  appbar_visibility1=false;

  CustomerEditPurchaseOrderMainScreen(bool appbar_visibility,{Key? key}){
    appbar_visibility1=appbar_visibility;
  }

  @override
  State<CustomerEditPurchaseOrderMainScreen> createState() =>
      _CustomerEditPurchaseOrderMainScreenState(appbar_visibility1);
}

class _CustomerEditPurchaseOrderMainScreenState extends State<CustomerEditPurchaseOrderMainScreen> {
  final purchaseOrderMainController = Get.put(CustomerEditPurchaseOrderMainController());

  bool appbarvisibility=false;

  _CustomerEditPurchaseOrderMainScreenState(bool appbar_visibility1){
    appbarvisibility=appbar_visibility1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: appbarvisibility?AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: const Text(
            'Purchase Order',
            style: TextStyle(
                fontFamily: 'Popins',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ):null,
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => purchaseOrderMainController.productlist.value.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
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
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
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
                                          items: purchaseOrderMainController.transportList.value
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
                                            purchaseOrderMainController.setSelectedTransportType(value!);
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
                          ),//transport type
                          Container(
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
                                            purchaseOrderMainController.setSelected(value!);
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
                          ),//plant
                          Container(
                            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              elevation: 4,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Column(children: [
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
                                          hintText: 'Enter Payment Details(If Any)',
                                          hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400)),
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      controller:
                                      purchaseOrderMainController.payment_details,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                      TextCapitalization.words,
                                    ),
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      myAlert();
                                    },
                                    child: Text('Upload Photo'),


                                  ),

                                  Center(
                                    child: Text(
                                      '${purchaseOrderMainController.imagename==""?"N/A":purchaseOrderMainController.image!.name}',
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


                                ],),
                              ),
                            ),
                          ),//payment details
                          Container(
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
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                            child: Obx(
                                                  () => Text(purchaseOrderMainController
                                                  .selected_dropdown_brand==""
                                                  ? "Select Brand"
                                                  : purchaseOrderMainController
                                                  .selected_dropdown_brand
                                                  .value
                                                  .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController.brandlist.value
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
                                            purchaseOrderMainController.setSelectedBrandvalue(value!);
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
                          ),//brand

                          Container(
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
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                            child: Obx(
                                                  () => Text(purchaseOrderMainController
                                                  .selected_dropdown_bird==""
                                                  ? "Select Bird"
                                                  : purchaseOrderMainController
                                                  .selected_dropdown_bird
                                                  .value
                                                  .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController.birdlist.value
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
                                            purchaseOrderMainController.setSelectedBirdvalue(value!);
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
                          ),//bird
                          Container(
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
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                            child: Obx(
                                                  () => Text(purchaseOrderMainController
                                                  .selected_dropdown_stage==""
                                                  ? "Select Stage"
                                                  : purchaseOrderMainController
                                                  .selected_dropdown_stage
                                                  .value
                                                  .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController.stagelist.value
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
                                            purchaseOrderMainController.setSelectedStagevalue(value!);
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
                          ),//stage
                          Container(
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
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerRight,
                                        child: DropdownButton<String>(
                                          hint: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                            child: Obx(
                                                  () => Text(purchaseOrderMainController
                                                  .selected_dropdown_matrial==""
                                                  ? "Select Material"
                                                  : purchaseOrderMainController
                                                  .selected_dropdown_matrial
                                                  .value
                                                  .toString()),
                                            ),
                                          ),
                                          items: purchaseOrderMainController.matriallist.value
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
                                            purchaseOrderMainController.selectmatrial(value!);
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
                          ),//matrial

                          Container(
                            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Row(
                              children: [
                                Expanded(child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                  elevation: 4,
                                  child:Container(
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
                                            height: MediaQuery.of(context).size.height/30,
                                            child: TextFormField(
                                              textAlignVertical: TextAlignVertical.bottom,
                                              cursorColor: Colors.black,
                                              textInputAction: TextInputAction.next,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0',
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
                                              purchaseOrderMainController.bags_qty,
                                              keyboardType: TextInputType.number,
                                              onChanged:(text) {
                                                purchaseOrderMainController.bagsqty.value=text.trim();
                                                purchaseOrderMainController.getqty();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ,
                                )),
                                Expanded(child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                                  elevation: 4,
                                  child:Container(
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
                                                .bags_in_kg==""
                                                ? "0"
                                                : purchaseOrderMainController
                                                .bags_in_kg
                                                .value
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
                                  ) ,
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.0,
                                child: ElevatedButton(
                                  onPressed: purchaseOrderMainController.submit,
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(15)),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.red),
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
                                        color: Colors.white,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0,),

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
    return GetBuilder<CustomerEditPurchaseOrderMainController>(builder: (controller){
          return Column(
            children: [
              ListView.builder(
                itemCount:
                purchaseOrderMainController.tempProductList.length,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                                    //deleteProductRecord(dataModel.productid);

                                    editBagDialog(dataModel,dataModel.productid);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 35.0,
                                  ),
                                ),
                              )),
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
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: purchaseOrderMainController.approveProduct,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
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
                        'Place Order',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
    });
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



  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    purchaseOrderMainController.setimage(img);
  }


  void editBagDialog(TempProductList productobject,String? productid) {
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
                            "Enter no. of bags",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                     /* Text(
                        "Enter no. of bags",
                        textAlign: TextAlign.center,
                      ),*/
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Bags Qty',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                          controller: purchaseOrderMainController.textfiled_no_of_bags,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Cancel',
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
                              child: Text('Ok',
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
                                purchaseOrderMainController.edtiBages(productobject,productid);

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
