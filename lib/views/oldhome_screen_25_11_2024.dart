/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/responses/DivisionResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/location_service.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:japfa_feed_application/views/analysisScreen.dart';
import 'package:japfa_feed_application/views/analysisScreen1.dart';
import 'package:japfa_feed_application/views/dashboard_Screen.dart';
import 'package:japfa_feed_application/views/purchaseOrderMain_Screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  //final dashboardController = Get.find<DashboardController>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return WillPopScope(
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Obx(
                      () => homeController.division_Id == ""
                          ? Container()
                          : IndexedStack(
                              index: controller.tabIndex,
                              children: [
                                DashboardScreen(),
                                Obx(() =>
                                    homeController.designation.value == "ZO"
                                        ? AnalysisScreen()
                                        : AnalysisScreen1()),
                                PurchaseOrderMainScreen(false)
                              ],
                            ),
                    ),
                    _displayProgress()
                  ],
                ),
              ),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover, // Adjust fit as needed
                        image: AssetImage('assets/images/app_bar.png'),
                      ),
                    ),
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.white),

                title: GestureDetector(
                  onTap: () {
                    if (homeController.division_visibility.value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Select Division',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: dashbordhighlight_blue),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      */
/* analysisController
                                        .clerarfilterdTextfield2();*//*

                                      Get.back();
                                    },
                                    child: const Text('Cancel',style: TextStyle(
                                      fontFamily: 'Poppins'
                                    ),)),
                              ],
                              content: setupAlertDialoadContainer2(context),
                            );
                          });
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     */
/* const Text(
                        "Japfa Feed",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "Poppins",fontWeight: FontWeight.w600),
                      ),*//*

                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            Obx(() => Text(
                                "${homeController.division_name.value}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Obx(() => Visibility(
                              visible: homeController.division_visibility.value,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  */
/*Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Center(
                        child: Row(
                      children: [
                        Obx(
                          () => Text(
                            "Km.${controller.total_km}",
                            style: TextStyle(
                              fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white, fontFamily: "OpenSans"),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                  ),*//*

                ],
              ),
              drawer: NavagationDrawerWidget(),
              onDrawerChanged: (val) {
                controller.navigation_drawer_open_close = val;

                print(
                    'drawer value ${homeController.navigation_drawer_open_close}');
              },
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                selectedItemColor: startjourneyGradient1,
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0),
                selectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600, fontSize: 12.0),
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,

                items: [
                  controller.tabIndex == 0
                      ? const BottomNavigationBarItem(
                          icon: Icon(
                            CupertinoIcons.home,
                            color: startjourneyGradient1,
                          ),
                          label: 'Home',
                        )
                      : const BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.home, color: Colors.black),
                          label: 'Home',
                        ),
                  controller.tabIndex == 1
                      ? const BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.chart_bar_fill,
                              color: startjourneyGradient1),
                          label: 'Statistics',
                        )
                      : const BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.chart_bar_fill,
                              color: Colors.black),
                          label: 'Statistics',
                        ),
                  controller.tabIndex == 2
                      ? BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/history1.png",
                            height: 25,
                            width: 25,
                            color: startjourneyGradient1,
                          ),
                          label: 'New Order',
                        )
                      : BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/history0.png",
                            height: 25,
                            width: 25,
                          ),
                          label: 'New Order',
                        ),
                  controller.tabIndex == 3
                      ? BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/profile1.png",
                            height: 25,
                            width: 25,
                            color: startjourneyGradient1,
                          ),
                          label: 'Profile',
                        )
                      : BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/profile0.png",
                            height: 25,
                            width: 25,
                          ),
                          label: 'Profile',
                        ),
                ],
              ),
            ),
            onWillPop: () async {
              if (homeController.navigation_drawer_open_close) {
                Navigator.of(context).pop();
              } else if (homeController.tabIndex != 0) {
                if (homeController.tabIndex == 2) {
                  alertDialog("Discard");
                } else {
                  homeController.changeTabIndex(0);
                }
              } else {
                controller.alertDialog("Exit");
                */
/* controller.exit();*//*

              }
              */
/* Get.offAll(() => VendorListScreen(),arguments: {'userId': MainPresenter.getInstance().userId.value});*//*

              return false;
            });
      },
    );
  }

  Widget _displayProgress() {
    return Obx(() => homeController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget setupAlertDialoadContainer2(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 300.0,
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.divisionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel = homeController.divisionList.value[index];
                    return GestureDetector(
                      onTap: () {
                        homeController.setDivisionData(index);
                        Get.back();
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(dataModel.divisionName.toString(),style: TextStyle(
                          fontFamily: "Poppins",
                        ),),
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
  }

  void alertDialog(String str_exit_logout) {
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
                            "${str_exit_logout}",
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
                        "Do you want to discard now?",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('No',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                primary: loginCustomer,
                                onPrimary: const Color(0xFFFFFFFF),
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
                              child: Text('Yes',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                primary: loginEmployee,
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                Get.back();
                                homeController.changeTabIndex(0);
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
*/
