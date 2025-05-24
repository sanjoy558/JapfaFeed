import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/controllers/trackCustomerController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:numberpicker/numberpicker.dart';

class TrackCustomerScreen extends StatefulWidget {
  const TrackCustomerScreen({Key? key}) : super(key: key);

  @override
  State<TrackCustomerScreen> createState() => _TrackCustomerScreenState();
}

class _TrackCustomerScreenState extends State<TrackCustomerScreen> {
  final trackCustomerController = Get.put(TrackCustomerController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Text(
                'Track Customer',
                style: TextStyle(
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${trackCustomerController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Popins"),
              ),
              ),
            ],
          ),
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
             /* Obx(() => trackCustomerController.activeCustomer.value.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                physics: const ScrollPhysics(),
                    child: displayCumulativeData(context),
                  )),
              _displayProgress()*/

              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: displayCumulativeData(context),
              ),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget displayCumulativeData(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 20.0),
      /*decoration: BoxDecoration(
            color: dashbordhighlight_blue,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [statgradient2, Colors.red]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                  /*BorderRadius.circular(10),*/
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Customer (Last month billed customer )",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),
                    Obx(() => Text(
                      "# ${trackCustomerController.zactCust1.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),),
                  ],
                ),
              ),


              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [statgradient3, statgradient4]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                  /*BorderRadius.circular(10),*/
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Customer (Current Month Billed + New Customers)",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("billed");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  )
                                /*BorderRadius.circular(10),*/
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Current Month Billed",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Obx(() =>Text(
                                    "# ${trackCustomerController.zbillCust.value}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w600),
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("unbilled");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  )
                                /*BorderRadius.circular(10),*/
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "New Customer",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w500),
                                  ),

                                  Obx(()=>Text(
                                    "# ${trackCustomerController.znewCust.value}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(

                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w600),
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),


              SizedBox(
                height: 10.0,
              ),


              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [statgradient5, statgradient6]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                  /*BorderRadius.circular(10),*/
                ),
                child: Column(
                  children: [
                    Text(
                      "Current Month Unbilled Customer",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w500),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),
                    Obx(() =>Text(
                      "# ${trackCustomerController.zunBill.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(

                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),),
                  ],
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.yellow]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                  /*BorderRadius.circular(10),*/
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Current Month Active Customer",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w500),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),
                    Obx(() =>Text(
                      "# ${trackCustomerController.currentMonthActiveCustomer.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Popins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0),
                    child: Card(
                      /*shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),*/
                      elevation: 4,
                      child: Container(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                        margin: EdgeInsets.only(
                            left: 10.0,
                            top: 5.0,
                            right: 5.0,
                            bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'My Sales Target',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontFamily: 'Popins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        getYearAdnMonth("str_12");
                        //https://pub.dev/packages/stacked_chart
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Obx(() => trackCustomerController.salestargetlist.isEmpty
              ? trackCustomerController.salestargetlistData1.value
              ? noData()
              : Container()
              : getCustomerWiseListData(context)),


        ],
      ),
    );
  }


  Widget displayCumulativeData1(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 20.0),
      /*decoration: BoxDecoration(
            color: dashbordhighlight_blue,
            borderRadius: BorderRadius.all(Radius.circular(10.0)
            )
        ),*/
      child: Column(
        children: [
          Card(
            elevation: 10.0,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              padding: EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: startjourneyblue.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  )
                /*BorderRadius.circular(10),*/
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: Text(
                          "New customer",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.w500),
                        ),),
                        Spacer()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: Obx(() => Text(
                          "# ${trackCustomerController.newCustomer.value}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.w600),
                        ),),),
                        Spacer()
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("billed");
                            },
                            child: Text(
                            "Billed Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w500),
                          ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("unbilled");
                            },
                            child: Text(
                            "Unbilled Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w500),
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            trackCustomerController.goToListScreen("billed");
                          },
                          child: Obx(() =>Text(
                            "# ${trackCustomerController.billedCustomer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w600),
                          ),),
                        ),),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            trackCustomerController.goToListScreen("unbilled");
                          },
                          child: Obx(()=>Text(
                            "# ${trackCustomerController.unbilledCustomer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(

                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w600),
                          ),),
                        ),),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("active");
                            },
                            child: Text(
                            "Active Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w500),
                          ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("lost");
                            },
                            child: Text(
                            "Lost Customer",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w500),
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            trackCustomerController.goToListScreen("active");
                          },
                          child: Obx(() =>Text(
                            "# ${trackCustomerController.activeCustomer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(

                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w600),
                          ),),
                        ),),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            trackCustomerController.goToListScreen("lost");
                          },
                          child: Obx(()=>Text(
                            "# ${trackCustomerController.lostCustomer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(

                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontWeight: FontWeight.w600),
                          ),),
                        ),),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              trackCustomerController.goToListScreen("nop");
                            },
                            child: Text(
                              "Nop Customer",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Popins',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            trackCustomerController.goToListScreen("nop");
                          },
                          child: Obx(() =>Text(
                            "# ${trackCustomerController.nopCustomer.value}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Popins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),),
                        ),),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0),
                    child: Card(
                      /*shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),*/
                      elevation: 4,
                      child: Container(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                        margin: EdgeInsets.only(
                            left: 10.0,
                            top: 5.0,
                            right: 5.0,
                            bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'My Sales Target',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontFamily: 'Popins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        getYearAdnMonth("str_12");
                        //https://pub.dev/packages/stacked_chart
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Obx(() => trackCustomerController.salestargetlist.isEmpty
              ? trackCustomerController.salestargetlistData1.value
              ? noData()
              : Container()
              : getCustomerWiseListData(context)),


        ],
      ),
    );
  }


  Widget _displayProgress() {
    return Obx(() => trackCustomerController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  void getYearAdnMonth(String str_12) {
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
                                fontFamily: 'Popins',
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
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                      () => NumberPicker(
                                        textStyle: TextStyle(fontFamily: "Popins",color: Colors.black),
                                    selectedTextStyle:TextStyle(fontFamily: "Popins",color: startjourneyblue,fontWeight: FontWeight.w600,fontSize: 20.0),
                                    infiniteLoop: true,
                                    value: trackCustomerController.currentIntYear.value,

                                    minValue: 2024,
                                    maxValue: 2026,
                                    onChanged: (value) {
                                      trackCustomerController.currentIntYear.value= value;
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
                                        fontFamily: 'Popins',
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 10),
                                Obx(
                                      () => NumberPicker(
                                        textStyle: TextStyle(fontFamily: "Popins",color: Colors.black),
                                        selectedTextStyle:TextStyle(fontFamily: "Popins",color: startjourneyblue,fontWeight: FontWeight.w600,fontSize: 20.0),
                                    infiniteLoop: true,
                                    value: trackCustomerController.currentIntMonth.value,
                                    minValue: 1,
                                    maxValue: 12,
                                    onChanged: (value) {
                                      trackCustomerController.currentIntMonth.value=value;
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
                                      fontFamily: 'Popins',
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
                                      fontFamily: 'Popins',
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
                                trackCustomerController
                                    .getSalesTargetList();
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

  Widget getCustomerWiseListData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Year',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Month',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))
                      /*BorderRadius.circular(10),*/
                    ),
                    child: Text(
                      'Target',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: trackCustomerController.salestargetlist.value.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var dataModel = trackCustomerController.salestargetlist.value[index];
                //print(dataModel.toJson());
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${dataModel.year}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Popins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${DateFormat('MMM').format(DateTime(0, int.parse(dataModel.month!)))}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Popins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  '${dataModel.target}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Popins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
