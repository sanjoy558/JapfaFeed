import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderResponse.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:japfa_feed_application/views/purchaseOrderMain_Screen.dart';

import '../controllers/purchaseOrderListController.dart';
import '../controllers/purchaseOrderListDetailsController.dart';

class PurchaseOrderListDetailsScreen extends StatefulWidget {
  const PurchaseOrderListDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseOrderListDetailsScreen> createState() => _PurchaseOrderListDetailsScreenState();
}

class _PurchaseOrderListDetailsScreenState extends State<PurchaseOrderListDetailsScreen> {
  final purchaseOrderListDetailsController = Get.put(PurchaseOrderListDetailsController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        purchaseOrderListDetailsController.pressBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*const Text(
                'Purchase Order Details',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${purchaseOrderListDetailsController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Gilroy"),
              ),
              ),
            ],
          ),
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: ListView(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0))),
                elevation: 4,
                child:Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Customer.',
                            style: TextStyle(
                                color: statgradient5,
                                fontSize: 14.0,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.customer!.firstName}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Gilroy",
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
                            'Payment Details.',
                            style: TextStyle(
                                color: statgradient5,
                                fontSize: 14.0,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.paymentRemark==null?"NA":purchaseOrderListDetailsController.purchase_order_object.paymentRemark}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Gilroy",
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
                            'Sap Id.',
                            style: TextStyle(
                                color: statgradient5,
                                fontSize: 14.0,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.sapId==null?'NA':purchaseOrderListDetailsController.purchase_order_object.sapId}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ) ,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0))),
                elevation: 4,
                child:Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'ProductList.',
                            style: TextStyle(
                                color: statgradient5,
                                fontSize: 14.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: ListView.builder(
                          itemCount:
                          purchaseOrderListDetailsController.itemsList.value.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var dataModel =
                            purchaseOrderListDetailsController.itemsList.value[index];
                            return GestureDetector(
                              onTap: () {
                                print(dataModel.productId);
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                                elevation: 5,
                                margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                                child: Container(
                                  color: statgradient5.withOpacity(0.1),
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
                                                      fontFamily: "Gilroy",
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
                                                                  color: statgradient5,
                                                                  fontSize: 14.0,
                                                                  fontFamily: "Gilroy",
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
                                                                  fontFamily: "Gilroy",
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
                                                                  color: statgradient5,
                                                                  fontSize: 14.0,
                                                                  fontFamily: "Gilroy",
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
                                                                  fontFamily: "Gilroy",
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
                        ),
                      )
                    ],
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
