import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/dailyPlanZrController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/DailyPlanReportScreen.dart';
import 'package:japfa_feed_application/views/dailyPlanNewCustomerList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanZrList_Screen.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/dailyPlanListController.dart';

class DailyPlanZrScreen extends StatefulWidget {
  const DailyPlanZrScreen({Key? key}) : super(key: key);

  @override
  State<DailyPlanZrScreen> createState() => _DailyPlanZrScreenState();
}

class _DailyPlanZrScreenState extends State<DailyPlanZrScreen> {

  final dailyplanzrController = Get.put(DailyPlanZrController());

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
              /*Text(
                '${dailyplanzrController.appbarname}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${dailyplanzrController.division_name.value}",
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

                    Obx(() => dailyplanzrController.visitorList.value.isEmpty?
                    Container():
                    ListView.builder(
                      itemCount:
                      dailyplanzrController.visitorList.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var dataModel =
                        dailyplanzrController.visitorList.value[index];
                        //print(dataModel.toJson());
                        return GestureDetector(
                          onTap: () {
                            if(dailyplanzrController.screen_type=="plan"){
                              alertDialog(dataModel.login.toString());
                            }else if(dailyplanzrController.screen_type=="report"){
                              alertDialogReportType(dataModel.login.toString());
                            }

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
                                              '${dataModel.email}',
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
                                            dailyplanzrController.callCustomer(dataModel);
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
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

  void alertDialog(String strlogin_id) {
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
                            "Select Customer type.",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          ElevatedButton(
                            child: const Text('Japfa Customers',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy',
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
                              Get.to(DailyPlanZrListScreen(),arguments: {'customertype': "old_customer",'loginid': "${strlogin_id}"});
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            child: Text('New Customers',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy',
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
                              Get.to(DailyPlanZrListScreen(),arguments: {'customertype': "new_customer",'loginid': "${strlogin_id}"});
                            },
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

  Widget old_new_form(){
    return Wrap(
      direction: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: (){
            //addplancontroller.changeform(true);
          },
          child: SizedBox(
            width: 150.0,
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
        SizedBox(width: 10.0,),
        GestureDetector(
          onTap: (){
            Get.to(() => DailyPlanNewCustomerListScreen());
          },
          child: SizedBox(
            width: 150.0,
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
      ],
    );
  }

  Widget _displayProgress() {
    return Obx(() => dailyplanzrController.displayLoading.value == true
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

  void alertDialogReportType(String login_str) {
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
                            "Report type",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Select report type!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Existing Customer',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
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
                                Get.to(DailyPlanReportScreen(),arguments: {
                                  'login': '${login_str}',
                                  'report_type': 'existing_customer',
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text('New Customer',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Gilroy',
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
                                Get.to(DailyPlanReportScreen(),arguments: {
                                  'login': '${login_str}',
                                  'report_type': 'new_customer',
                                });

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
