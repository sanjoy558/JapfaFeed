import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/changePasswordController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/brochureListController.dart';
import '../controllers/dailyPlanListController.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final changPasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
      Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Obx(() =>  Text("DIV - ${changPasswordController.division_name.value}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: "Gilroy"),
          ),
          ),
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0,left: 30.0),
                          child:Container(
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
                                  hintText: 'Old Password',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              controller: changPasswordController.oldpassword,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0,left: 30.0),
                          child:Container(
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
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              controller: changPasswordController.newpassword,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0,left: 30.0),
                          child:Container(
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
                                  hintText: 'Confirm New Password',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              controller: changPasswordController.confirm_newpassword,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:width/1.5,
                              child: ElevatedButton(
                                onPressed: (){
                                  changPasswordController.changePassword();
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        dashbordhighlight_blue),
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
                                  'Change Password',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                _displayProgress()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => changPasswordController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }
}
