import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/responses/CustomerPieChartResponse.dart';
import 'package:japfa_feed_application/responses/UserLocation.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/LocationNotifier.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/ServiceHelper.dart';
import 'package:japfa_feed_application/views/DailyPlanZrTabScreen.dart';
import 'package:japfa_feed_application/views/brochureList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanList_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:android_intent_plus/android_intent.dart';

class DashboardScreen extends StatelessWidget {
  final dashboardController = Get.put(DashboardController());
  final homeController = Get.find<HomeController>();
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Hi ${dashboardController.firstname}!",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Image.asset(
                            'assets/images/hand_gif.gif',
                            width: 25.0,
                            height: 25.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Lets track your sales...",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: letstrackcolor,
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              displayPunchInnPunchOutPatch(context),
              displayCumulativeData(context),
              /* Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: GestureDetector(
                    onTap: () async {
                      if (dashboardController.start_journey_flag.value ==
                          false) {
                        int planCount =
                            await dashboardController.getPlanListCount();

                        if (planCount > 0) {
                          showAlertDialog(context);
                        } else {
                          MainPresenter.getInstance()
                              .showErrorToast("Please Add Journey Plan");
                        }
                      } else if (dashboardController.start_journey_flag.value ==
                          true) {
                        endJourneyalertDialog();
                      }
                    },
                    child: Obx(() => dashboardController
                                .start_journey_flag.value ==
                            false
                        ? Card(
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 5.0),
                              decoration: BoxDecoration(
                                  color: startjourneyblue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Start Journey",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        : Card(
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 5.0),
                              decoration: BoxDecoration(
                                  color: planred,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "End Journey",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ))),
              ),

              SizedBox(
                height: 10.0,
              ),*/

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: 8.0, left: 13.0),
                child: Text(
                  "Manage",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.purchaseorder();
                        },
                        child: Card(
                          color: statgradient5.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin:
                                      EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Image.asset(
                                    'assets/images/vehicle.png',
                                    width: 25.0,
                                    height: 25.0,
                                    color: statgradient5,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 5.0, left: 5.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "PURCHASE ORDER",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: statgradient5,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.goTOCustomer();
                        },
                        child: Card(
                          color: statgradient8.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin:
                                      EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Icon(
                                    Icons.person_pin_rounded,
                                    size: 25.0,
                                    color: statgradient8,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 5.0, left: 5.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "CUSTOMERS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: statgradient8,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.goToGoodsRecived();
                        },
                        child: Card(
                          color: dccolor.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin:
                                      EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Image.asset(
                                    'assets/images/shipped.png',
                                    width: 25.0,
                                    height: 25.0,
                                    color: dccolor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 5.0, left: 5.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "GOODS RECEIVED",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: dccolor,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.gotoAddPlan();
                        },
                        child: Card(
                          color: statgradient3.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Image.asset(
                                    'assets/images/schedule.png',
                                    width: 25.0,
                                    height: 25.0,
                                    color: statgradient3,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 5.0, left: 5.0),
                                  child: const Text(
                                    "JOURNEY PLAN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: statgradient3,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => BrochureListScreen(true));
                        },
                        child: Card(
                          color: dashboarddata7.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Image.asset(
                                    'assets/images/brochure1.png',
                                    width: 30.0,
                                    height: 30.0,
                                    color: dashboarddata7,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5.0, right: 5.0, left: 5.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "BROCHURE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: dashboarddata7,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          dashboardController.trackCustomer();
                        },
                        child: Card(
                          color: startjourneyblue.withOpacity(0.1),
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Image.asset(
                                    'assets/images/track_customer1.png',
                                    width: 30.0,
                                    height: 30.0,
                                    color: startjourneyblue,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: 5.0, right: 5.0, left: 5.0),
                                  child: const Text(
                                    "TRACK CUSTOMER",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: startjourneyblue,
                                        fontSize: 12.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _displayProgress()
      ],
    );
  }

  Widget displayPunchInnPunchOutPatch(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Journey Start / End",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        if (dashboardController.designation.value == "ZO") {
                          Get.to(() => DailyPlanListScreen());
                        } else {
                          Get.to(() => DailyPlanZrTabScreen());
                        }
                      },
                      child: Text(
                        "View Plan",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            color: viewdetailcolor,
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: MediaQuery.of(context).size.height / 8,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [journeypatchcolor, journeypatchcolor]),
                  border: Border.all(color: bordercolor1,width: 2.0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  /*BorderRadius.circular(10),*/
                  ),
              child: Container(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Time",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Obx(
                                () => Text(
                                  "${dashboardController.punchinn_time.value}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End Time",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: Obx(
                                  () => Text(
                                    "${dashboardController.punchout_time.value}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          dashboardController.getTime();
                          if (dashboardController.start_journey_flag.value ==
                              false) {
                            int planCount =
                                await dashboardController.getPlanListCount();

                            if (planCount > 0) {
                              showAlertDialog(context);
                            } else {
                              MainPresenter.getInstance()
                                  .showErrorToast("Please Add Journey Plan");
                            }
                          } else if (dashboardController
                                  .start_journey_flag.value ==
                              true) {
                            endJourneyalertDialog();
                          }
                        },
                        child: Obx(() => dashboardController
                                    .start_journey_flag.value ==
                                false
                            ? Card(
                                elevation: 4,
                                color: dashboarddata7,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        startjourneyGradient1,
                                        startjourneyGradient2
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5.0),
                                          child: Icon(
                                            Icons.login,
                                            size: 35.0,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            "Start Journey",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Card(
                                elevation: 4,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: dashboarddata7,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5.0),
                                          child: Icon(
                                            Icons.logout,
                                            size: 35.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            "End Journey",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayCumulativeData(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      /*decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Statistics",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    homeController.changeTabIndex(0);
                    //dashboardController.getAllLocations();
                    //dashboardController.getAllPointsTravelled();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      "View Detail",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: viewdetailcolor,
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                    padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [statgradient2, statgradient1])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          child: Image.asset(
                            'assets/images/chart.png',
                            width: 30.0,
                            height: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Target (In MT)",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        Obx(
                          () => Text(
                            "# ${dashboardController.cummulative_target}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                    padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            colors: [statgradient3, statgradient4])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/chart.png',
                            width: 30.0,
                            height: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Actual (In MT)",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        Obx(
                          () => Text(
                            "# ${dashboardController.cummulative_actual}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      dashboardController.goTOCustomer();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                      padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient8, statgradient8])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.person_pin_rounded,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                                () => Text(
                              "# ${dashboardController.cummulative_total_customer.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.goTOCustomer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient8, statgradient8])),
                      margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                      padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.person_pin_rounded,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                            () => Text(
                              "# ${dashboardController.cummulative_total_customer.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      dashboardController.purchaseorder();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [statgradient5, statgradient6])),
                      margin: EdgeInsets.only(bottom: 5.0,right: 5.0),
                      padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.0, right: 5.0),
                            alignment: Alignment.topRight,
                            child:  Image.asset(
                              'assets/images/vehicle.png',
                              width: 30.0,
                              height: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Todays Orders",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                            () => Text(
                              "# ${dashboardController.todyas_purchase_order_count.value}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget displayCustomerList(BuildContext context) {
    return Obx(() => dashboardController.customerList.value.length > 0
        ? Container(
            padding: const EdgeInsets.only(left: 15.0),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.note_add_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<Data>(
                      hint: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Obx(
                          () => Text(
                              dashboardController.selected_dropdown_object ==
                                      null
                                  ? dashboardController
                                      .selected_dropdown_string.value
                                      .toString()
                                  : dashboardController
                                      .selected_dropdown_string.value
                                      .toString()),
                        ),
                      ),
                      items: dashboardController.customerList.value.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                              child: Text(e.id.toString())),
                        );
                      }).toList(),
                      onChanged: (value) {
                        dashboardController.setSelected(value!);
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container());
  }

  /*Widget displayPiechart1(BuildContext context) {
    return Obx(() => dashboardController.graphList.value.length > 0
        ? PieChart(
            dataMap: dashboardController.dataMap,
            animationDuration: const Duration(milliseconds: 1000),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: dashboardController.colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "Sales Target",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        : Container());
  }

  Widget displayPiechart(BuildContext context) {
    return Obx(() => dashboardController.customerList.value.length > 0
        ? PieChart(
            dataMap: dashboardController.dataMap1,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: dashboardController.colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "Sales Target",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        : Container());
  }*/

  Widget _displayProgress() {
    /* return Obx(() => dashboardController.displayLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : Container());*/

    return Obx(() => dashboardController.displayLoading.value == true
        ? Center(child: progressBarCommon())
        : Container());
  }

  Widget startJourneyAlertDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to remember?'),
              ),
              SizedBox(
                width: 320.0,
                child: Container(
                  color: Colors.red,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) async {
    dashboardController.textfiled_vehiclenumber.text = "";
    dashboardController.textfield_opening_km.text = "";
    dashboardController.textfield_remark.text = "";

    // set up the buttons
    /*Widget remindButton = TextButton(
      child: Text("Remind me later"),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget launchButton = TextButton(
      child: Text("Launch missile"),
      onPressed: () {},
    );*/

    // set up the AlertDialog

    if (await dashboardController.checkNotificationPermission()) {
      AlertDialog alert = AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text("Journey Details"),
        content: Wrap(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        elevation: 4,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10.0, top: 5.0, right: 5.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    hint: Obx(
                                      () => Text(dashboardController
                                                  .selected_dropdown_journeytype ==
                                              null
                                          ? dashboardController
                                              .selected_dropdown_journeytype
                                              .value
                                              .toString()
                                          : dashboardController
                                              .selected_dropdown_journeytype
                                              .value
                                              .toString()),
                                    ),
                                    items: dashboardController
                                        .journeyTypeList.value
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      dashboardController
                                          .selected_dropdown_journeytype
                                          .value = value.toString();
                                      /* dashboardController
                                        .setSelectedCustomerType(
                                        value!);*/
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Obx(
                      () => Visibility(
                        visible: dashboardController
                                    .selected_dropdown_journeytype.value ==
                                "Own Vehicle"
                            ? true
                            : false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Visite Date",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              dashboardController.initializeDate(),
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Vehicle Number",
                              style: TextStyle(color: Colors.red),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Vehicle Number',
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
                                    dashboardController.textfiled_vehiclenumber,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Opening KM",
                              style: TextStyle(color: Colors.red),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Opening KM',
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
                                    dashboardController.textfield_opening_km,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Remark",
                      style: TextStyle(color: Colors.red),
                    ),
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
                            hintText: 'Remark',
                            hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                        controller: dashboardController.textfield_remark,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: 320.0,
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            dashboardController.submitStartJourney(true);
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        actions: [
          /* remindButton,
        cancelButton,
        launchButton,*/
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      dashboardController.requestNotificationPermission(context);
    }
  }

  void endJourneyalertDialog() {
    dashboardController.textfield_ending_km.text = "";
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
                            "End Journey",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        " End journey now!!",
                        textAlign: TextAlign.center,
                      ),
                      /* const SizedBox(height: 5),
                      Text(
                        "Calculated Km : ${dashboardController.totalDistance.value}",
                        textAlign: TextAlign.center,
                      ),*/
                      const SizedBox(height: 15),
                      Visibility(
                        visible: dashboardController
                                    .selected_dropdown_journeytype.value ==
                                "Own Vehicle"
                            ? true
                            : false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ending KM',
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
                                    dashboardController.textfield_ending_km,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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
                              child: Text('End Now',
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
                                dashboardController.submitEndJourney(false);
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

  void getYearAdnMonth() {
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Select Year and Month",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      /*const Text(
                        "Are you sure you want to delete product?",
                        textAlign: TextAlign.center,
                      ),*/
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("Year",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                  () => NumberPicker(
                                    infiniteLoop: true,
                                    value: dashboardController
                                        .currentIntYear.value,
                                    minValue: 2020,
                                    maxValue: 2024,
                                    onChanged: (value) {
                                      dashboardController.currentIntYear.value =
                                          value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("Month",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                  () => NumberPicker(
                                    infiniteLoop: true,
                                    value: dashboardController
                                        .currentIntMonth.value,
                                    minValue: 0,
                                    maxValue: 12,
                                    onChanged: (value) {
                                      dashboardController
                                          .currentIntMonth.value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //Buttons
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
                              child: const Text('Ok',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                dashboardController
                                    .selectDateAndModifyPichart();
                                Get.back();
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

/*Widget setupAlertDialoadContainer() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      purchaseOrderMainController
                          .filterPlayer(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                    controller: purchaseOrderMainController
                        .addplan_name_customer_fliter,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                  purchaseOrderMainController.filteredCustomerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel = purchaseOrderMainController
                        .filteredCustomerList.value[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        purchaseOrderMainController.clerarfilterdTextfield();
                        purchaseOrderMainController.doneSelection(
                            dataModel.firstName.toString(),
                            dataModel.id.toString(),
                            dataModel.zone.toString());
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.firstName.toString()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}
