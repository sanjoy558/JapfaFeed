import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerPurchaseOrderListDetailsController.dart';
import 'package:japfa_feed_application/utils/Constants.dart';


class CustomerPurchaseOrderListDetailsScreen extends StatefulWidget {
  const CustomerPurchaseOrderListDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerPurchaseOrderListDetailsScreen> createState() => _CustomerPurchaseOrderListDetailsScreenState();
}

class _CustomerPurchaseOrderListDetailsScreenState extends State<CustomerPurchaseOrderListDetailsScreen> {
  final purchaseOrderListDetailsController = Get.put(CustomerPurchaseOrderListDetailsController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        purchaseOrderListDetailsController.pressBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: toolbarColor,
          title: const Text(
            'Purchase Order Details',
            style: TextStyle(
                fontFamily: 'Popins',
                fontWeight: FontWeight.w600,
                color: Colors.black),
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
                                color: planred,
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.customer!.firstName}',
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
                      ),
                      Row(
                        children: [
                          const Text(
                            'Payment Details.',
                            style: TextStyle(
                                color: planred,
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.paymentRemark==null?"NA":purchaseOrderListDetailsController.purchase_order_object.paymentRemark}',
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
                      ),
                      Row(
                        children: [
                          const Text(
                            'Sap Id.',
                            style: TextStyle(
                                color: planred,
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '${purchaseOrderListDetailsController.purchase_order_object.sapId==null?'NA':purchaseOrderListDetailsController.purchase_order_object.sapId}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'OpenSans',
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
                                color: planred,
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'OpenSans',
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
