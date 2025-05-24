import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/utils/Constants.dart';

import '../controllers/splashController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final controllerSplash = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/japfa_splash.gif',
        fit: BoxFit.fill,
      ),
    );
  }

 /* @override
  void initState() {
    controllerSplash.gotoNextPage();
  }*/
}
