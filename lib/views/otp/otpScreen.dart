import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/otpController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final controllerOtp = Get.put(OtpController());
  final focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: borderColor),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 50.0, right: 20.0, left: 20.0),
                      width: double.infinity,
                      height: 200,
                      child: Image.asset(
                        'assets/images/japfa_logo1.png',
                      ),
                    ),
                    Obx(()=>controllerOtp.flagDisplayId==true?displayLoginIdScreen():displayOtpScreen())
                  ],
                ),
              ),
              _displayProgress()
            ],
          ),
        ),
      ),
        onWillPop: () async {
        if(controllerOtp.flagDisplayId==false){
          controllerOtp.flagDisplayId.value=true;
        }else{
          Get.back();
        }
      return false;
    });



  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)));
  }

  @override
  void initState() {

  }

  Widget displayOtpScreen(){
    return Center(
      child: Container(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0,top: 20.0),
              child: Text(
                "Otp",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
              ),),

            Container(
              margin: EdgeInsets.only(bottom: 20.0,top: 5.0),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    "${controllerOtp.userloginid.text}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: (){
                      controllerOtp.editAgainLoginId();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )



            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,top: 5.0),
              child: Text(
                "Enter the code sent to the registered number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
              ),),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                // onSubmit: (String pin) => _showSnackBar(pin),
                focusNode: focusNode,
                controller: controllerOtp.pinputcontroller,
                pinAnimationType: PinAnimationType.fade,
                keyboardType: TextInputType.number,

                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: dashbordhighlight_blue),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: dashbordhighlight_blue),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
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
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: (){
                      controllerOtp.VerifyOtp();
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
                      'Validate',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
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
    );
  }
  Widget displayLoginIdScreen(){
    return Center(
      child: Container(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0,top: 20.0),
              child: Text(
                "Username",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
              ),),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,top: 5.0),
              child: Text(
                "Enter username",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
              ),),
            Padding(
              padding: const EdgeInsets.all(30.0),
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
                  controller: controllerOtp.userloginid,
                  keyboardType: TextInputType.number,
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
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: (){
                      controllerOtp.getLoginId();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            startjourneyGradient1),
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
                      'Validate',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
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
    );
  }




  Widget _displayProgress() {
    return Obx(() => controllerOtp.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }
}
