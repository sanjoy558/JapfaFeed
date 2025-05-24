import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/dailyPlanZrListController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/dailyPlanNewCustomerList_Screen.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/dailyPlanListController.dart';

class DailyPlanZrListScreen extends StatefulWidget {
  const DailyPlanZrListScreen({Key? key}) : super(key: key);

  @override
  State<DailyPlanZrListScreen> createState() => _DailyPlanZrListScreenState();
}

class _DailyPlanZrListScreenState extends State<DailyPlanZrListScreen> {

  final dailyplanZrListController = Get.put(DailyPlanZrListController());

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
              /*const Text(
                'Visit Plan',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${dailyplanZrListController.division_name.value}",
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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),

                    Visibility(
                      visible: dailyplanZrListController.visiblityflag=="1"?true:false,
                      child: Obx(() => dailyplanZrListController
                          .customerVisitorList.value.isEmpty
                          ? dailyplanZrListController.Data1.value
                          ? noData()
                          : Container(): ListView.builder(
                        itemCount:
                        dailyplanZrListController.customerVisitorList.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel =
                          dailyplanZrListController.customerVisitorList.value[index];
                          //print(dataModel.toJson());
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
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              dailyplanZrListController.callCustomer(dataModel);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 10.0),
                                              child: const Text(
                                                'Status',
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
                                              '${dataModel.status}',
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
                                    SizedBox(height: 5.0,),
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
                                              dailyplanZrListController.callCustomer(dataModel);
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
                                              dailyplanZrListController.callCustomer(dataModel);
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



                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    ),
                    Visibility(
                      visible: dailyplanZrListController.visiblityflag=="2"?true:false,
                      child: Obx(() => dailyplanZrListController
                          .newCustomerVisitorList.value.isEmpty
                          ? dailyplanZrListController.Data2.value
                          ? noData()
                          : Container(): SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: ListView.builder(
                          itemCount:
                          dailyplanZrListController.newCustomerVisitorList.value.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var dataModel =
                            dailyplanZrListController.newCustomerVisitorList.value[index];
                            //print(dataModel.toJson());
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          margin: const EdgeInsets.only(top: 10.0),
                                                          child: const Text(
                                                            'Status',
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
                                                          '${dataModel.status}',
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
                                                SizedBox(height: 5.0,),

                                                Text(
                                                  '${dataModel.customerName}',
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  '${dataModel.remark}',
                                                  style: const TextStyle(
                                                      fontSize: 10.0,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.w600),
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
                      )),
                    ),
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

  Widget _displayProgress() {

    return Obx(() => dailyplanZrListController.displayLoading.value == true
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
