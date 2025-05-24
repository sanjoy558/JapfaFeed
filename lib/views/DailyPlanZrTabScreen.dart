import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/DailyPlanZrTabController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/dailyPlanList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanZr_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DailyPlanZrTabScreen extends StatefulWidget {
  @override
  _DailyPlanZrTabScreenState createState() => _DailyPlanZrTabScreenState();
}

class _DailyPlanZrTabScreenState extends State<DailyPlanZrTabScreen> {
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /* Text(
              'Visit Plan',
              style: TextStyle(color: Colors.black, fontFamily: "Gilroy"),
            ),*/
            Obx(() =>  Text("DIV - ${dailyPlanZrTabController.division_name.value}",
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
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width,),
                GestureDetector(
                  onTap: (){
                    //addplancontroller.changeform(true);
                    Get.to(DailyPlanListScreen());
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
                          'My Plan',
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
                    /*Get.to(() => DailyPlanNewCustomerListScreen());*/

                    Get.to(DailyPlanZrScreen(), arguments: {
                      'screen_type': 'plan',
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
                          'Team Plan',
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

}
