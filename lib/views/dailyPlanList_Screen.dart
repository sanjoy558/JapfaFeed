import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/dailyPlanNewCustomerList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanNewCustomerUpdateList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanZr_Screen.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/dailyPlanListController.dart';

class DailyPlanListScreen extends StatefulWidget {
  const DailyPlanListScreen({Key? key}) : super(key: key);

  @override
  State<DailyPlanListScreen> createState() => _DailyPlanListScreenState();
}

class _DailyPlanListScreenState extends State<DailyPlanListScreen> {

  final dailyplanListController = Get.put(DailyPlanListController());

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
          title:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Text(
                'Visit Plan',
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
                            "${dailyplanListController.customerVisitTotalCount.value}",
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
                            "${dailyplanListController.customerVisitCount.value}",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black, fontFamily: "Gilroy"),
                          ),
                        ),
                      ],
                    ),),
              ),
          ],
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    old_new_form(),
                    const SizedBox(
                      height: 10.0,
                    ),



                    Obx(() =>ListView.builder(
                      itemCount:
                      dailyplanListController.customerVisitorList.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var dataModel =
                        dailyplanListController.customerVisitorList.value[index];
                        //print(dataModel.toJson());
                        return GestureDetector(
                          onTap: () {

                          },
                          child: Card(

                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            elevation: 5,
                            margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: dataModel.status=="visited"?Colors.white:
                                dataModel.status=="canceled"?Colors.white:Colors.white,
                              ),
                              padding:  EdgeInsets.all(10.0),
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
                                              '${dataModel.firstName}',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '${dataModel.addressLine2},${dataModel.addressLine1}',
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),),


                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: (){
                                            dailyplanListController.callCustomer(dataModel);
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
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text('${dataModel.phone}',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            dailyplanListController.callCustomer(dataModel);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(top: 10.0),
                                            child:  Text(
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
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 20.0),
                                          child:  Text(
                                            '${dataModel.zone!.isEmpty?"N/A":dataModel.zone}',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10.0,
                                  ),

                                  Row(
                                    children: [
                                      Expanded(child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: startjourneyblue,
                                          minimumSize: const Size.fromHeight(40),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Sure end visit?',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight: FontWeight.w600,
                                                        color: dashbordhighlight_blue),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text('Cancel')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                          dailyplanListController.gotToFeedBack(dataModel);
                                                        },
                                                        child: const Text('Yes'))
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
                                      SizedBox(width: 5.0,),

                                      Expanded(child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: planred,
                                          minimumSize: const Size.fromHeight(40),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Are you sure to cancel visit?',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight: FontWeight.w600,
                                                        color: dashbordhighlight_blue),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text('Cancel')),
                                                    TextButton(
                                                        onPressed: () {

                                                          dailyplanListController.cancelVisit(dataModel);
                                                        },
                                                        child: const Text('Yes'))
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
                                      )),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    )
                  ],
                ),
              ),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget old_new_form(){
    return Row(

      children: [
        SizedBox(width: 5.0,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              //addplancontroller.changeform(true);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        loginCustomer),
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
        ),
        SizedBox(width: 5.0,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Get.to(() => DailyPlanNewCustomerListScreen());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: ElevatedButton(
                onPressed:null ,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        loginEmployee),
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
        ),
        SizedBox(width: 5.0,),
        /*Expanded(
          child: GestureDetector(
            onTap: (){
              Get.to(() => DailyPlanNewCustomerUpdateList_Screen());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: ElevatedButton(
                onPressed:null ,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        dashbordhighlight_blue),
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
                  'New Update',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5.0,),*/
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
    )
        : Container());
  }


}
