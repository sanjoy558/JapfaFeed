import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/dailyPlanNewCustomerListController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/dailyPlanListController.dart';

class DailyPlanNewCustomerListScreen extends StatefulWidget {
  const DailyPlanNewCustomerListScreen({Key? key}) : super(key: key);

  @override
  State<DailyPlanNewCustomerListScreen> createState() =>
      _DailyPlanNewCustomerListScreenState();
}

class _DailyPlanNewCustomerListScreenState
    extends State<DailyPlanNewCustomerListScreen> {
  final dailyplanListController = Get.put(DailyPlanNewCustomerListController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
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
             /* const Text(
                'New Customer Daily Plan',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${dailyplanListController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Gilroy"),
              ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 8.0),
              child: Center(
                  child: Row(
                    children: [
                      Obx(
                            () => Text(
                          "${dailyplanListController.newCustomerVisitTotalCount.value}",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black, fontFamily: "Gilroy"),
                        ),
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black, fontFamily: "Gilroy"),
                      ),

                      Obx(
                            () => Text(
                          "${dailyplanListController.newCustomerVisitCount.value}",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black, fontFamily: "Gilroy"),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => dailyplanListController
                      .newCustomerVisitorList.value.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: ListView.builder(
                        itemCount: dailyplanListController
                            .newCustomerVisitorList.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel = dailyplanListController
                              .newCustomerVisitorList.value[index];
                          //print(dataModel.toJson());
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              elevation: 5,
                              margin: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: dataModel.status=="visited"?Colors.lightGreenAccent.withOpacity(0.4):dataModel.status=="canceled"?Colors.red[900]!.withOpacity(0.6):Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${dataModel.customerName}',
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                '${dataModel.remark}',
                                                style: const TextStyle(
                                                    fontSize: 10.0,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /*Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        //dailyplanListController.callCustomer(dataModel);
                                      },
                                      child: Container(
                                          margin:const EdgeInsets.all(5.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(180),
                                              //set border radius more than 50% of height and width to make circle
                                            ),
                                            elevation:3,
                                            child: Icon(Icons.phone, color: Colors.red,size: 25.0,),
                                          )
                                      ),
                                    ),
                                  ),*/
                                      ],
                                    ),
                                    /* Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        //dailyplanListController.callCustomer(dataModel);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10.0),
                                        child: const Text(
                                          'Zone',
                                          style: TextStyle(
                                              color: dashbordhighlight_blue,
                                              fontSize: 14.0,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),*/

                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: startjourneyblue,
                                            minimumSize:
                                            const Size.fromHeight(40),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      'Sure end visit?',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Gilroy',
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: dashbordhighlight_blue),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            dailyplanListController
                                                                .gotToFeedBack(dataModel,"visit");
                                                          },
                                                          child:
                                                          const Text('Yes'))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Text(
                                            /* api/update-delivery-status*/
                                            'End Visit',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Gilroy',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),

                                        SizedBox(width: 10.0,),
                                        Expanded(child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: planred,
                                            minimumSize:
                                            const Size.fromHeight(40),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      'Sure cancel visit?',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Gilroy',
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: dashbordhighlight_blue),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            dailyplanListController.
                                                            gotToFeedBack(dataModel,"cancel");
                                                          },
                                                          child:
                                                          const Text('Yes'))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Text(
                                            /* api/update-delivery-status*/
                                            'Cancel Visit',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Gilroy',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
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

  Widget old_new_form() {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () {
            //addplancontroller.changeform(true);
          },
          child: SizedBox(
            width: 150.0,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(loginCustomer),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ))),
              child: const Text(
                'Japfa Customer',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            //Get.to(() => NewCustomerFormScreen());
          },
          child: SizedBox(
            width: 150.0,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(loginEmployee),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ))),
              child: const Text(
                'New Customer',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayProgress() {
    return Obx(() => dailyplanListController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget _displayphoneIcon(bool showflag) {
    return Obx(() => showflag == true
        ? Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  elevation: 3,
                  child: Icon(
                    Icons.phone,
                    color: Colors.red,
                    size: 25.0,
                  ),
                )),
          )
        : Container());
  }
}
