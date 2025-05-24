import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/controllers/goodsReceivedController.dart';
import 'package:japfa_feed_application/controllers/goodsReceivedDetailsController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GoodsReceivedListDetailsScreen extends StatefulWidget {
  const GoodsReceivedListDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GoodsReceivedListDetailsScreen> createState() =>
      _GoodsReceivedListDetailsScreenState();
}

class _GoodsReceivedListDetailsScreenState
    extends State<GoodsReceivedListDetailsScreen>
    with SingleTickerProviderStateMixin {
  final goodsReceivedDetailsController =
      Get.put(GoodsReceivedDetailsController());

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //goodsReceivedDetailsController.changetab(0);
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: toolbarColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Text(
                'DC : ${goodsReceivedDetailsController.dcnumber.value}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(
                () => Text(
                  "DIV - ${goodsReceivedDetailsController.division_name.value}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: "Gilroy"),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: bordercolor1,width: 2.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text(
                                            'DC NUMBER.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(height: 5.0,),
                                          const Text(
                                            'PO NUMBER.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              '${goodsReceivedDetailsController.dcnumber.value}',

                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 5.0,),
                                            Text(
                                              '${goodsReceivedDetailsController.pono}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          left: 5.0,
                          child: Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 20,
                              foregroundColor: Colors.white,
                              backgroundColor:
                              dccolor1 /*Color.fromRGBO(30, 60, 168, 1)*/,
                              child: Image.asset(
                                "assets/images/vehicle.png",
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              /* child: Icon(Icons.person, color: Colors.white)*/
                              //CircleAvatar(radius: 30, backgroundImage:  AssetImage(Helper.getAssetName("moryatoolslogo.png", "real"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  getDeliveryChallanData(context),
                  goodsReceivedDetailsData(),
                ],
              ),
            ),
            _displayProgress(),
          ],
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => goodsReceivedDetailsController.displayLoading.value == true
        ? Center(child: progressBarCommon())
        : Container());
  }

  Widget goodsReceivedDetailsData() {
    return Obx(
      () => ListView.builder(
        itemCount:
            goodsReceivedDetailsController.newPendingGoodsList.value.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var dataModel =
              goodsReceivedDetailsController.newPendingGoodsList.value[index];
          return GestureDetector(
            onTap: () {
              /* goodsReceivedController.callCustomer(dataModel);*/
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          'Customer Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400),
                        ),
                        Expanded(
                          child: Text(
                            '${dataModel.poNumber}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          'Material',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400),
                        ),
                        Expanded(
                          child: Text(
                            '${dataModel.material}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: bordercolor1,width: 2.0),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Act.Qty',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    '${dataModel.quantity} Bags',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(width: 10.0,),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: bordercolor1,width: 2.0),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Net Wgt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    '${dataModel.weight} KG',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0,right: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: bordercolor1,width: 2.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        /*Row(
                            children: [
                              const Text(
                                'PO NUMBER.',
                                style: TextStyle(
                                    color: planred,
                                    fontSize: 14.0,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Text(
                                  '${dataModel.pono}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),*/
                        Row(
                          children: [
                            const Text(
                              'Vehicle No.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400),
                            ),
                            Expanded(
                              child: Text(
                                '${dataModel.vehicleNumber}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Driver Name.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400),
                            ),
                            Expanded(
                              child: Text(
                                '${dataModel.driverName}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Driver Cell No.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400),
                            ),
                            Expanded(
                              child: Text(
                                '${dataModel.driverNumber}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0,right: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: bordercolor1,width: 2.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'CR Date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '${dataModel.crDate}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'CR Time',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                '${dataModel.crTime}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
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
                        width: 150,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                                colors: [startjourneyGradient1, startjourneyGradient2]),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Do you confirm you have received material?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600,
                                            color: dccolor),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: dccolor),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                              goodsReceivedDetailsController
                                                  .setPoRecived(dataModel);
                                            },
                                            child: const Text('Yes',
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    color: dccolor)))
                                      ],
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.transparent),
                                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
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
                              /*api/update-delivery-status*/
                              'Recived',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Gilroy',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getDeliveryChallanData(BuildContext context) {
    return Obx(
      () => goodsReceivedDetailsController.delivery_challan_table.value.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          /*BorderRadius.circular(10),*/
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(

                                    /*BorderRadius.circular(10),*/
                                    ),
                                child: Text(
                                  'Name',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                      left: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                ),
                                child: Text(
                                  'Po Qty\n (bags)',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  /*BorderRadius.circular(10),*/
                                ),
                                child: Text(
                                  'DC Qty\n (bags)',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(

                                    /*BorderRadius.circular(10),*/
                                    ),
                                child: Text(
                                  'Dif Qty\n (bags)',
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
                      ),
                      /*Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0)),
                        */ /*BorderRadius.circular(10),*/ /*
                      ),
                      child: Text(
                        'Name',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                      ),
                      child: Text(
                        'Po Qty',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                        */ /*BorderRadius.circular(10),*/ /*
                      ),
                      child: Text(
                        'DC Qty',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                        */ /*BorderRadius.circular(10),*/ /*
                      ),
                      child: Text(
                        'Dif Qty',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),*/
                      ListView.builder(
                        itemCount: goodsReceivedDetailsController
                            .delivery_challan_table.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel = goodsReceivedDetailsController
                              .delivery_challan_table.value[index];
                          //print(dataModel.toJson());
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          /* decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),*/
                                          child: Text(
                                            '${dataModel.material}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0),
                                                left: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0)),
                                          ),
                                          child: Text(
                                            '${dataModel.poNumber}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0)),
                                          ),
                                          child: Text(
                                            '${dataModel.quantity}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          /*decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),*/
                                          child: Text(
                                            '${getDifference(double.parse(dataModel.poNumber!), double.parse(dataModel.quantity!))}',
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String getDifference(double? poQTY, double? dcQTY) {
    double difference = poQTY! - dcQTY!;
    return difference.toStringAsFixed(0);
  }
}
