import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/DailyPlanZrTabController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/DailyPlanReportScreen.dart';
import 'package:japfa_feed_application/views/dailyPlanList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanZr_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DailyReportZrTabScreen extends StatefulWidget {
  @override
  _DailyReportZrTabScreenState createState() => _DailyReportZrTabScreenState();
}

class _DailyReportZrTabScreenState extends State<DailyReportZrTabScreen> {
  final dailyPlanZrTabController = Get.put(DailyPlanZrTabController());

  @override
  void dispose() {
    //dailyPlanZrTabController.tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, // Setting app bar background color
        elevation: 0.0,
        title: Text(
          'Visit Report',
          style: TextStyle(color: Colors.black, fontFamily: "Gilroy"),
        ),
      ),
      body: Stack(
        children: [
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width,),
                GestureDetector(
                  onTap: (){
                    //addplancontroller.changeform(true);
                    //Get.to(DailyPlanReportScreen());

                    alertDialogReportType();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                startjourneyblue),
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
                          'My Report',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0,),
                GestureDetector(
                  onTap: (){
                    Get.to(DailyPlanZrScreen(), arguments: {
                      'screen_type': 'report',
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed:null ,
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                planred),
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
                          'Team Report',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          displayProgress()
        ],
      ),
    );
  }

  Widget displayProgress() {

    return Obx(() => dailyPlanZrTabController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  void alertDialogReportType() {
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
                                  'login':dailyPlanZrTabController.login,
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
                                  'login':dailyPlanZrTabController.login,
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
