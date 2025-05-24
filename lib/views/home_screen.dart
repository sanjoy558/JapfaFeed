import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/responses/DivisionResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/location_service.dart';
import 'package:japfa_feed_application/views/DailyPlanReportScreen.dart';
import 'package:japfa_feed_application/views/DailyReportZrTabScreen.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:japfa_feed_application/views/analysisScreen.dart';
import 'package:japfa_feed_application/views/analysisScreen1.dart';
import 'package:japfa_feed_application/views/brochureList_Screen.dart';
import 'package:japfa_feed_application/views/dashboard_Screen.dart';
import 'package:japfa_feed_application/views/profile_Screen.dart';
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
                              index: controller.tabIndex.value,
                              children: [
                                Obx(() =>
                                    homeController.designation.value == "ZO"
                                        ? AnalysisScreen()
                                        : AnalysisScreen1()),
                                PurchaseOrderMainScreen(false),
                                DashboardScreen(),
                                BrochureListScreen(false),
                                ProfileScreen()
                              ],
                            ),
                    ),
                    _displayProgress()
                  ],
                ),
              ),
              appBar: AppBar(
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Image.asset(
                        'assets/images/drawerham.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: hometoolbarcolor,
                      border: Border.all(color: bordercolor1,width: 2.0),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
                      // image: DecorationImage(
                      //   fit: BoxFit.cover, // Adjust fit as needed
                      //   image: AssetImage('assets/images/app_bar.png'),
                      // ),
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
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      /* analysisController
                                        .clerarfilterdTextfield2();*/
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color:Colors.black,fontFamily: 'Gilroy',fontWeight: FontWeight.w500,),
                                    )),
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
                      Container(
                        alignment: Alignment.topLeft,
                       /* margin: EdgeInsets.only(bottom: 15.0),*/
                        child: Row(
                          children: [
                            Obx(
                              () => Text(
                                "DIV - ${homeController.division_name.value}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontFamily: "Gilroy",
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Obx(() => Visibility(
                                  visible:
                                      homeController.division_visibility.value,
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
                actions: [],
              ),
              drawer: NavagationDrawerWidget(),
              onDrawerChanged: (val) {
                controller.navigation_drawer_open_close = val;

                print(
                    'drawer value ${homeController.navigation_drawer_open_close}');
              },
              bottomNavigationBar: Obx(()=>bottomNav()),
            ),
            onWillPop: () async {
              if (homeController.navigation_drawer_open_close) {
                Navigator.of(context).pop();
              } else if (homeController.tabIndex != 2) {
                if (homeController.tabIndex == 1) {
                  alertDialog("Discard");
                } else {
                  homeController.navigationController?.value = 2;
                  homeController.changeTabIndex(2);
                }
              } else {
                controller.alertDialog("Exit");
                /* controller.exit();*/
              }
              /* Get.offAll(() => VendorListScreen(),arguments: {'userId': MainPresenter.getInstance().userId.value});*/
              return false;
            });
      },
    );
  }

  Widget _displayProgress() {
    return Obx(() => homeController.displayLoading.value == true
        ? Center(child: progressBarCommon())
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
                        title: Text(
                          dataModel.divisionName.toString(),
                          style: TextStyle(
                            fontFamily: "Gilroy",
                          ),
                        ),
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

  Widget bottomNav() {
    return CircularBottomNavigation(
      homeController.tabItems,
      controller: homeController.navigationController,
      selectedPos: homeController.tabIndex.value,
      barHeight: homeController.bottomNavBarHeight,
      // use either barBackgroundColor or barBackgroundGradient to have a gradient on bar background
      barBackgroundColor: Colors.white,
      // barBackgroundGradient: LinearGradient(
      //   begin: Alignment.bottomCenter,
      //   end: Alignment.topCenter,
      //   colors: [
      //     Colors.blue,
      //     Colors.red,
      //   ],
      // ),
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        homeController.tabIndex.value = selectedPos ?? 0;
        homeController.changeTabIndex(homeController.tabIndex.value);
      },
    );
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
                                fontFamily: 'Gilroy',
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
                                homeController.navigationController?.value = 2;
                                homeController.changeTabIndex(2);
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
/*
IconButton(
onPressed: () {
Scaffold.of(context).openDrawer();
},
icon: Image.asset(
'assets/images/drawerham.png',
fit: BoxFit.cover,
),
)*/
