import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerHomeController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:japfa_feed_application/views/DailyPlanReportScreen.dart';
import 'package:japfa_feed_application/views/DailyPlanZrTabScreen.dart';
import 'package:japfa_feed_application/views/DailyReportZrTabScreen.dart';
import 'package:japfa_feed_application/views/add_sales_target_screen.dart';
import 'package:japfa_feed_application/views/changePassword_Screen.dart';
import 'package:japfa_feed_application/views/brochureList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanList_Screen.dart';
import 'package:japfa_feed_application/views/dailyPlanZr_Screen.dart';


class NavagationDrawerWidget extends StatefulWidget {
  final homeController = Get.put(HomeController());
  @override
  _NavagationDrawerWidgetState createState() => _NavagationDrawerWidgetState();
}

class _NavagationDrawerWidgetState extends State<NavagationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  bool isLoading = false;
  var userId = "";
  var login = "";
  var firstname = "";

  final controller = Get.find<HomeController>();
  var usertype="".obs;
  var designation="".obs;

  @override
  void initState() {

    if (MainPresenter.getInstance().userModel.userId == null) {
      userId = "";
    } else {
      usertype.value=MainPresenter.getInstance().userModel.usertype!;
      designation.value=MainPresenter.getInstance().userModel.designation!;
     /* if(MainPresenter.getInstance().userModel.usertype=="Customer"){
        controller=Get.find<CustomerHomeController>();
      }else{
        controller=Get.find<HomeController>();
      }*/

      userId = controller.userId;
      login = controller.login;
      firstname = controller.firstname;
      MainPresenter.getInstance().printLog("userid tushar123", userId);
      MainPresenter.getInstance().printLog("userid designation", designation.value);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    final urlImage = '' /*Utilities.profileImage*/;
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            /*createDrawerHeader(),*/
            buildHeader(
                urlImage: urlImage,
                name: login,
                email: firstname,
                height:height,
                onClicked: () {
                    }),

          createDrawerBodyItem(
              icon: Icons.event_note,
              text: 'Visit Plan',
              onTap: () => selectedItem(context, 2),
            ),
            createDrawerBodyItem(
              icon: Icons.event_note,
              text: 'Visit Report',
              onTap: () => selectedItem(context, 5),
            ),
            createDrawerBodyItem(
              icon: Icons.event_note,
              text: 'Sales Target',
              onTap: () => selectedItem(context, 7),
            ),
            createDrawerBodyItem(
              icon: Icons.contact_phone,
              text: 'Brochure',
              onTap: () => selectedItem(context, 3),
            ),
            createDrawerBodyItem(
              icon: Icons.key_sharp,
              text: 'Change Password',
              onTap: () => selectedItem(context, 4),
            ),
            createDrawerBodyItem(
              icon: Icons.share,
              text: 'Share',
              onTap: () => selectedItem(context, 6),
            ),
            createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () => selectedItem(context,
                  8) /*Navigator.pushReplacementNamed(context, pageRoutes.contact)*/,
            ),
            ListTile(
              //title: const Text('App version 1.0.0'),
              //05/12/2023
              title: const Text(appversion,style: TextStyle(
                fontFamily: 'Gilroy'
              ),),
              onTap: () => selectedItem(context, 5),
            ),
            ListTile(
              //title: const Text('App version 1.0.0'),
              //05/12/2023
              title: const Text('Connected with SAP-ECQ',style: TextStyle(
                fontFamily: 'Gilroy'
              ),),
              onTap: () => selectedItem(context, 5),
            ),
          ],
        ),
      ),
    );
  }

  createDrawerHeader() {
    return const DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/splash_screen_logo.png',
            ),
          ),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to Flutter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget buildHeader({
    String? urlImage,
    String? name,
    String? email,
    VoidCallback? onClicked, required double height,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          margin: EdgeInsets.only(top: height),
          color: startjourneyGradient2.withOpacity(0.3),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  /* List<ProductImages> oneImageList=new List();
                  oneImageList.clear();
                  oneImageList.add(new ProductImages(image: urlImage));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewPageScreen(0,oneImageList)));*/
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor:
                  startjourneyGradient2.withOpacity(0.3) /*Color.fromRGBO(30, 60, 168, 1)*/,
                  backgroundImage:const AssetImage('assets/images/profile1.png')
                  /* child: Icon(Icons.person, color: Colors.white)*/
                  //CircleAvatar(radius: 30, backgroundImage:  AssetImage(Helper.getAssetName("moryatoolslogo.png", "real"),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name!,
                        style: const TextStyle(fontSize: 12, color: Colors.black,fontFamily: 'Gilroy',fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email!,
                        style: const TextStyle(fontSize: 10, color: Colors.black,fontFamily: 'Gilroy',fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
             /* CircleAvatar(
                radius: 18,
                backgroundColor: MyColors.dashbordhighlight_blue,
                child: GestureDetector(
                    onTap: () {
                      print('tushar');
                      Navigator.of(context).pop();
                      *//*if(Utilities.userType=="Guest"){
                      Utilities.showLongToast(context, "Login First");
                    }else if(Utilities.userType=="User"){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile()));
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DealerProfile()));
                    }*//*
                    },
                    child:
                        const Icon(Icons.add_comment_outlined, color: Colors.white)),
              )*/
            ],
          ),
        ),
      );

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    final hoverColor = dashbordhighlight_blue;

    return SizedBox(
      height: 45,
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.black,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    text!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            const Expanded(
              child: Divider(),
            )
          ],
        ),
        onTap: onTap,
        hoverColor: hoverColor,
      ),
    );
  }

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => DealerRegistration()));*/
        break;
      case 2:

        /*Get.to(() => DailyPlanListScreen());*/
        if(designation.value=="ZO"){
          Get.to(() => DailyPlanListScreen());
        }else{
          Get.to(() => DailyPlanZrTabScreen());
        }
        break;
      case 3:
        Get.to(() => BrochureListScreen(true));
        break;
      case 4:
        Get.to(() => ChangePasswordScreen());
        //https://medium.flutterdevs.com/share-data-to-another-application-in-flutter-6c92cec275e6
        //shareLink(context,"Morya Tools \n \n app url");
        break;
      case 5:
        if(designation.value=="ZO"){
          //Get.to(DailyPlanReportScreen());
          alertDialogReportType();
        }else{
          Get.to(() => DailyReportZrTabScreen());
        }

        break;
      case 7:
        Get.to(()=>AddSalesTargetScreen());
        break;
      case 8:
        logout();

        break;
      case 9:
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductFeedbackScreen()));*/
        break;

      case 10:
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankScreen()));*/
        break;
      case 11:


        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactusScreen()));*/
        break;
    }
  }

  shareLink(BuildContext context, String link) async {
    final RenderObject? box = context.findRenderObject();

    /*return await Share.share(
        link,
        subject: "BlogMarch Link",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/

    /*await Share.share(
        link,
        subject: "subject",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);*/
  }

/* Future<String> getClearSharedPrefKey(String str) async {
    SharePrefsHelper prefs = await SharePrefsHelper.getInstance(context);
    prefs.clearKey(str);

    SharePrefsHelper.getInstance(context)
        .saveStringValue(SharePrefsHelper.phone_varified, "0");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginUser()),
            (route) => false);
  }

  */
  void logout() {
    controller.alertDialog("Logout");
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



}
