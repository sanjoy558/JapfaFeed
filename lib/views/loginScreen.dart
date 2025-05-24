import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/loginController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenScreenState();
}

//0010005275 A D M POULTRY FARM 10028884
//0010002417 A & V POULTRY SERVICES 10027445
//0010004058// under tambekar
//https://icon.kitchen/
//https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html#foreground.type=image&foreground.space.trim=1&foreground.space.pad=0.1&foreColor=rgba(96%2C%20125%2C%20139%2C%200)&backColor=rgb(255%2C%20255%2C%20255)&crop=0&backgroundShape=square&effects=none&name=ic_launcher

class _LoginScreenScreenState extends State<LoginScreen> {
  final controllerLogin = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [_screenBody(context), _displayProgress()],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [

                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: controllerLogin.login,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(startjourneyGradient1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_right_alt_outlined, // Choose the icon you want
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  //alertDialog();
                  controllerLogin.otpScreen();
                },
                child: const Text(
                  "Forget Password",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14.0,
                      color: startjourneyGradient1,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controllerLogin.launchSocial("1");
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0))),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/linkedin.png',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controllerLogin.launchSocial("2");
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0))),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/fb_2.png',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controllerLogin.launchSocial("3");
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0))),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/insta_2.png',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/5,
                        width: double.infinity,
                        child: Image.asset(
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          'assets/images/farm_back.png',
                        ),
                      ),
                      /*Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controllerLogin.launchSocial("1");
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/images/linkedin.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controllerLogin.launchSocial("2");
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/images/fb_2.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controllerLogin.launchSocial("3");
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/images/insta_2.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                    ],
                  ),
                  Obx(() => Container(
                    padding: EdgeInsets.all(2.0),
                    color: primaryColor,
                    height: 20.0,
                    child: Marquee(
                      text: '${controllerLogin.morquee_str.value}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: startjourneyGradient2,
                          fontSize: 16.0),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      startPadding: 50.0,
                      accelerationCurve: Curves.linear,
                    ),
                  ))
                ],
              ),


              /*Obx(() => Container(
                    padding: EdgeInsets.all(2.0),
                    color: dashbordhighlight_blue,
                    height: 20.0,
                    child: Marquee(
                      text: '${controllerLogin.morquee_str.value}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      startPadding: 50.0,
                      accelerationCurve: Curves.linear,
                    ),
                  ))*/
            ],
          ),
        ],
      ),
    );
  }

  Widget _screenBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/japfa_feed.png',
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/feed.png',
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    ],
                  ),
                  /* Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width: double.infinity,
                        height: 40,
                        child: Image.asset(
                          'assets/images/japfa_logo1.png',
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        child: Image.asset(
                          'assets/images/feed.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),*/

                  Container(
                    child: const Text(
                      "${appversion}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                    child: const Text(
                      "Manage Your Sales Easily!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person,
                          color: startjourneyGradient1,),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'User Id.',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              controller: controllerLogin.userName,
                              /*keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,*/
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                      child: Obx(() => Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            margin:
                                const EdgeInsets.only(left: 5, right: 5, top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.password,
                                  color: startjourneyGradient1,
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child:  /*TextFormField(
                                    cursorColor: Colors.grey,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: controllerLogin.togglePasswordView,
                                            child: Icon(
                                              controllerLogin.isHidden.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: dashbordhighlight_blue,
                                            ),
                                          ),),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                    controller: controllerLogin.userPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controllerLogin.isHidden.value,
                                    textCapitalization: TextCapitalization.words,
                                  ),*/

                                  TextFormField(
                                    cursorColor: Colors.black,
                                    textInputAction: TextInputAction.done,
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password.',
                                        hintStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                    controller: controllerLogin.userPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controllerLogin.isHidden.value,
                                    /*textCapitalization: TextCapitalization.words,*/
                                  )
                                ),
                              ],
                            ),
                          ))),

                ],
              ),
            ),
          ),
          /*Align(
           alignment: Alignment.bottomCenter,
           child: GestureDetector(
             onTap: () {},
             child: Container(
               color: dashbordhighlight_blue,
               height: 20.0,
               child: Marquee(
                 text: '${controllerLogin.morquee_str.value}',
                 style: TextStyle(
                     fontWeight: FontWeight.bold, color: Colors.white),
                 scrollAxis: Axis.horizontal,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 blankSpace: 20.0,
                 velocity: 100.0,
                 startPadding: 50.0,
                 accelerationCurve: Curves.linear,
               ),
             ),
           ),
         )*/
        ],
      ),
    );
  }

  @override
  void initState() {
/*
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.orange
    ));*/
  }

  Widget _displayProgress() {
    return Obx(() => controllerLogin.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  void alertDialog() {
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
                            "Forget Password",
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
                        "Enter Username!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
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
                              hintText: 'USERNAME',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                          controller: controllerLogin.userloginid,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Cancel',
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
                              child: Text('Get Otp',
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
                                controllerLogin.validateUserid();
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
