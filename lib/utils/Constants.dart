import 'dart:ui';

import 'package:flutter/material.dart';

//const String BASE_URL = "http://feedsap.japfaindia.com:8084/";//live production
//const String BASE_URL = "http://123.201.101.73:8084/";//live production
//const String BASE_URL = "http://123.201.101.73:8083/";//live_test
//const String BASE_URL = "http://10.104.2.119:8085/";
const String BASE_URL = "http://feedsap.japfaindia.com:8084/"; //s4hana live

//const String BASE_URL = "http://cgfsap.japfaindia.com:8084/";
//const String BASE_URL = "http://10.104.2.83:8084/";
//const String BASE_URL = "http://103.181.15.69:8084/";//quality
//const String BASE_URL = "http://103.181.15.69:8085/";//quality s4hana

const String appversion = "App version 1.0.5"; //live
const String appversion_version = "1.0.5"; //live

//const String appversion = "App version 1.0.4";//quality
//const String appversion_version = "1.0.4";//quality
//const Color primaryColor = Color(0xFF6262FF);
const Color primaryColor = Colors.transparent;
const Color toolbarColor = Color(0xFFFFFFFF);
const Color toolbarColorWhite = Color(0xFFFFFFFF);
const Color purchaseblue = Color(0xFF259EF5);
const Color customerred = Color(0xFFC62E2E);
const Color goodsgreen = Color(0xFF4C9540);
const Color planred = Color(0xFFEC0000);
const Color startjourneyblue = Color(0xFF2B4484);
const Color loginCustomer = Color(0xFFF5C64C);
const Color loginEmployee = Color(0xFF5FA5E5);
const Color dashboarddata1 = Color(0xFFFFC727);
const Color dashboarddata2 = Color(0xFF10B981);
const Color dashboarddata3 = Color(0xFFFFF9E9);
const Color dashboarddata4 = Color(0xFFE7F8F2);
const Color dashboarddata5 = Color(0xFFF34235);
const Color dashboarddata6 = Color(0xFF9529AB);
const Color dashboarddata7 = Color(0xFFFC8948);
const Color noDatacolor1 = Color(0xFFEDEDE9);
const Color noDatacolor2 = Color(0xFFD6CCC2);
const Color noDatacolor3 = Color(0xFFF1DECC);
const Color noabc2 = Color(0xFF1E81B0);
const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
const Color dashbordhighlight_blue = Color(0xFF00B2EB);
const Color progressbarColor = Colors.redAccent;
const Color startjourneyGradient1 = Color(0xFFFE3C33);
const Color startjourneyGradient2 = Color(0xFFFF8E4C);
const Color viewcolordashboard = Color(0xFF2A4989);
const Color statgradient1 = Color(0xFFFBDD57);
const Color statgradient2 = Color(0xFFFE914C);
const Color statgradient3 = Color(0xFF0F93AA);
const Color statgradient4 = Color(0xFF75D45E);
const Color statgradient5 = Color(0xFF0C4CB0);
const Color statgradient6 = Color(0xFFBE6AE3);
const Color statgradient7 = Color(0xFFBE6AE3);
const Color statgradient8 = Color(0xFFE56211);
const Color viewdetailcolor = Color(0xFF004AAD);
const Color letstrackcolor = Color(0xFFE56211);
const Color dccolor = Colors.green;
const Color dccolor1 = Color(0xFFC1022C);
const Color bordercolor1 = Color(0xFFBEB6B8);
const Color textcolorgoods = Color(0xFF086778);
const Color callbuttoncolor = Color(0xFFFF0000);
const Color textcolorpurchaseorder = Color(0xFF004AAD);
const Color profilepinkcolor = Color(0xFFFF498A);
const Color colorapproved = Color(0xFF7ED957);
const Color colorcancel = Color(0xFFEF3842);
const Color colordispatched = Color(0xFFFF914D);
const Color colorcreated = Color(0xFF359CE0);
const Color dropdowncolor = Color(0xFFE32526);
const Color journeypatchcolor = Color(0xFFE75656);
const Color hometoolbarcolor = Color(0xFFF26829);
const Color trackcustomerpink = Color(0xFFFF66C4);
const Color trackcustomeryellow = Color(0xFFFFDE59);
const Color texteditbackgorund = Color(0xFFF9F6F6);

const double padding = 10;
const double avatarRadius = 45;
bool feedbackdialog = false;

class MyColors {
  static const MaterialColor primaryColor = MaterialColor(
    0xFFFF8E4C,
    <int, Color>{
      50: Color(0xFFFF8E4C),
      100: Color(0xFFFF8E4C),
      200: Color(0xFFFF8E4C),
      300: Color(0xFFFF8E4C),
      400: Color(0xFFFF8E4C),
      500: Color(0xFFFF8E4C),
      600: Color(0xFFFF8E4C),
      700: Color(0xFFFF8E4C),
      800: Color(0xFFFF8E4C),
      900: Color(0xFFFF8E4C),
    },
  );
}
//flutter kotlin to flutter java
//https://stackoverflow.com/questions/58579774/convert-an-existing-flutter-kotlin-project-to-flutter-java-project
