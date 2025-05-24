import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/brochureListController.dart';
import '../controllers/dailyPlanListController.dart';

class BrochureListScreen extends StatefulWidget {
  bool appbar_visibility1=false;
  BrochureListScreen(bool appbar_visibility,{Key? key}){
    appbar_visibility1=appbar_visibility;
  }

  @override
  State<BrochureListScreen> createState() => _BrochureListScreenState();
}

class _BrochureListScreenState extends State<BrochureListScreen> {

  final brochureListController = Get.put(BrochureListController());

  @override
  Widget build(BuildContext context) {
    final currentViewWidth = MediaQuery.of(context).size.width;
    final currentViewHeight = MediaQuery.of(context).size.height;
    bool isLargeScreen = currentViewWidth > 1200;
    return WillPopScope(
      onWillPop: () async {
      Get.back();
        return false;
      },
      child: Scaffold(
        appBar: widget.appbar_visibility1?AppBar(
          backgroundColor: toolbarColor,
          title:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Text(
                'Brochure',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${brochureListController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Gilroy"),
              ),
              ),
            ],
          ),
        ):null,
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => brochureListController.brochureList.value.isEmpty
                  ? Container()
                  : ListView.builder(
                  itemCount: brochureListController.brochureList.value.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index){
                    var dataModel = brochureListController.brochureList.value[index];
                    return GestureDetector(
                      onTap: (){
                        brochureListController.launchURL(dataModel.fileName.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Image.asset(
                                    'assets/images/pdfnew.png',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),

                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${dataModel.fileName}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                                color: bordercolor1,
                              thickness: 2.0,
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),

              ),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => brochureListController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }
}
