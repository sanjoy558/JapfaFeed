import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/trackCustomerListController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TrackCustomerListScreen extends StatefulWidget {
  const TrackCustomerListScreen({Key? key}) : super(key: key);

  @override
  State<TrackCustomerListScreen> createState() => _TrackCustomerListScreenState();
}

class _TrackCustomerListScreenState extends State<TrackCustomerListScreen> {
  final trackCustomerListController = Get.put(TrackCustomerListController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        trackCustomerListController.changetab(0);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text(
            '${trackCustomerListController.actionbartitle}',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => trackCustomerListController
                  .trackcustomerlist.value.isEmpty
                  ? trackCustomerListController.Data1.value
                  ? noData() : Container() : SingleChildScrollView(
                physics: const ScrollPhysics(),
                    child: ListView.builder(
                        itemCount:
                        trackCustomerListController.trackcustomerlist.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel =
                          trackCustomerListController.trackcustomerlist.value[index];
                          //print(dataModel.toJson());
                          return GestureDetector(
                            onTap: () {
                              trackCustomerListController.callCustomer(dataModel);
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              elevation: 5,
                              margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex:4,
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${dataModel.firstName}',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '${dataModel.addressLine2},${dataModel.addressLine1}',
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin:const EdgeInsets.all(5.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(180),
                                                //set border radius more than 50% of height and width to make circle
                                              ),
                                              elevation:3,
                                              child: Icon(Icons.phone, color: Colors.red,size: 25.0,),
                                            )

                                           /* Card(
                                              shape:  RoundedRectangleBorder(),
                                              child:  Icon(Icons.phone, color: Colors.red,size: 30.0,),
                                            )*/
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text('${dataModel.phone}',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  )),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => trackCustomerListController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }
}
