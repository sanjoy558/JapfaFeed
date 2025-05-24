import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/dailyPlanReportController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DailyPlanReportScreen extends StatefulWidget {
  const DailyPlanReportScreen({Key? key}) : super(key: key);

  @override
  State<DailyPlanReportScreen> createState() => _DailyPlanReportScreenState();
}

class _DailyPlanReportScreenState extends State<DailyPlanReportScreen> {
  final dailyPlanReportController = Get.put(DailyPlanReportController());

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
          title: Text(
            'DIV - ${dailyPlanReportController.appbar_name}',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  DateWidget(context),
                  Obx(() => dailyPlanReportController.daily_plan_report_list.value.isEmpty
                      ? dailyPlanReportController.daillyplanDataTrue_false.value
                      ? noData()
                      : Container()
                      : getDailyPlanReportData(context))
                ],
              ),
              /*SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    DateWidget(context),
                    Obx(() => dailyPlanReportController.daily_plan_report_list.value.isEmpty
                        ? dailyPlanReportController.daillyplanDataTrue_false.value
                        ? noData()
                        : Container()
                        : getDailyPlanReportData(context))
                    
                  ],
                ),
              ),*/
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget DateWidget(BuildContext context){
    return Container(
      margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                          color: dashbordhighlight_blue,
                          fontSize: 14.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        dailyPlanReportController.selectDate(context, "from");
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left:5.0),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                                color: Colors.white, width: 0.5),
                            borderRadius:
                            BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'From Date',
                                    hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                controller:
                                dailyPlanReportController.fromdate,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                TextCapitalization.words,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                          color: dashbordhighlight_blue,
                          fontSize: 14.0,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        dailyPlanReportController.selectDate(context, "to");
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                                color: Colors.white, width: 0.5),
                            borderRadius:
                            BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'To Date',
                                    hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                controller:
                                dailyPlanReportController.todate,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                TextCapitalization.words,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          Container(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: dailyPlanReportController.submitDate,
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(dashbordhighlight_blue),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => dailyPlanReportController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget getDailyPlanReportData(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1.0),borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)
              ),),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0)),
                            /*BorderRadius.circular(10),*/
                          ),
                          child: Text(
                            'Date',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                          ),
                          child: Text(
                            'Customers',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),right: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                            /*BorderRadius.circular(10),*/
                          ),
                          child: Text(
                            'Visited',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0),left: BorderSide(color: Colors.grey,width: 1.0)),
                            /*BorderRadius.circular(10),*/
                          ),
                          child: Text(
                            'Canceled',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: dailyPlanReportController.daily_plan_report_list.value.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var dataModel = dailyPlanReportController.daily_plan_report_list.value[index];
                      //print(dataModel.toJson());
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      /* decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),*/
                                      child: Text(
                                        '${dataModel.visitDate}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      decoration: BoxDecoration(
                                        border: Border(right: BorderSide(color: Colors.grey,width: 1.0),left:BorderSide(color: Colors.grey,width: 1.0) ),
                                      ),
                                      child: Text(
                                        '${dataModel.totalCustomers}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      decoration: BoxDecoration(
                                        border: Border(right: BorderSide(color: Colors.grey,width: 1.0) ),
                                      ),
                                      child: Text(
                                        '${dataModel.totalVisitedCustomers}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      /*decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),*/
                                      child: Text(
                                        '${dataModel.totalCancelCustomers}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Gilroy',
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
          ),
        ),
      ),
    );
  }
}
