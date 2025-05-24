import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/addPlanController.dart';
import 'package:japfa_feed_application/controllers/addSalesTargetController.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddSalesTargetScreen extends StatefulWidget {
  const AddSalesTargetScreen({Key? key}) : super(key: key);

  @override
  State<AddSalesTargetScreen> createState() => _AddSalesTargetScreenState();
}

class _AddSalesTargetScreenState extends State<AddSalesTargetScreen> {
  final addSalesTargetController = Get.put(AddSalesTargetController());
  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration.zero, () => showAlertDialog(context));
    return WillPopScope(
      onWillPop: () async {


        alertDialog("Discard");
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text(
            'DIV - ${addSalesTargetController.appbar_name}',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Container(
                child:Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Container(
                      padding:
                      const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        elevation: 4,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10.0,
                              top: 5.0,
                              right: 5.0,
                              bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Year',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerRight,
                                  child: DropdownButton<String>(
                                    hint: Obx(
                                          () => Text(addSalesTargetController
                                          .selected_dropdown_year ==
                                          null
                                          ? addSalesTargetController
                                          .selected_dropdown_year
                                          .value
                                          .toString()
                                          : addSalesTargetController
                                          .selected_dropdown_year
                                          .value
                                          .toString()),
                                    ),
                                    items: addSalesTargetController
                                        .yearList.value
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString(),style: TextStyle(fontFamily: 'Gilroy'),),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addSalesTargetController
                                          .selected_dropdown_year.value=value.toString();
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

                    SizedBox(height: 10.0,),

                    Container(
                      padding:
                      const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        elevation: 4,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10.0,
                              top: 5.0,
                              right: 5.0,
                              bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Month',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerRight,
                                  child: DropdownButton<String>(
                                    hint: Obx(
                                          () => Text(addSalesTargetController
                                          .selected_dropdown_month ==
                                          null
                                          ? addSalesTargetController
                                          .selected_dropdown_month
                                          .value
                                          .toString()
                                          : addSalesTargetController
                                          .selected_dropdown_month
                                          .value
                                          .toString()),
                                    ),
                                    items: addSalesTargetController
                                        .monthList.value
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString(),style: TextStyle(fontFamily: 'Gilroy'),),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addSalesTargetController.selected_dropdown_month.value=value.toString();
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
                    SizedBox(height: 10.0,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border:
                          Border.all(color: Colors.white, width: 0.5),
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
                            child: TextFormField(
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Target',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400)),
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                              controller:
                              addSalesTargetController.et_add_sales_target,
                              keyboardType: TextInputType.number,
                              textCapitalization:
                              TextCapitalization.words,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {

                              if(addSalesTargetController.validateTargetData()){
                                alertDialogSubmitData("Submit Target");
                              }
                            },
                            style: ButtonStyle(
                                padding:
                                MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    dashbordhighlight_blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0),
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(5.0)),
                                    ))),
                            child: const Text(
                              'Add Target',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Gilroy',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ) ,
              ),
            ),
            _displayProgress()
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    /*if(!mounted)*/
    super.dispose();
  }





  Widget _displayProgress() {
    return Obx(() => addSalesTargetController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }






  void alertDialogSubmitData(String head) {
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
                            "${head}",
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
                        "${head} ??",
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
                                if(addSalesTargetController.validateTargetData()){
                                  addSalesTargetController.submitForm();
                                }

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
                        style: TextStyle(fontFamily: 'Gilroy'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [

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
                                addSalesTargetController.changetab(0);

                              },
                            ),
                          ),
                          const SizedBox(width: 10),
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
