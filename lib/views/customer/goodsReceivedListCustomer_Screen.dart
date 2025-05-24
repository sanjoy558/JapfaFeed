import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/controllers/goodsReceivedController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/customer_controller/goodsReceivedCustomerController.dart';

class GoodsReceivedListCustomerScreen extends StatefulWidget {
  const GoodsReceivedListCustomerScreen({Key? key}) : super(key: key);

  @override
  State<GoodsReceivedListCustomerScreen> createState() =>
      _GoodsReceivedListCustomerScreenState();
}

class _GoodsReceivedListCustomerScreenState extends State<GoodsReceivedListCustomerScreen>
    with SingleTickerProviderStateMixin {
  final goodsReceivedController = Get.put(GoodsReceivedCustomerController());
  final pageviewController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );
  bool isLastPage = false;

  var focusNode = FocusNode();
  Icon _searchIcon = new Icon(Icons.search,size: 30.0,);
  Icon _searchIconRemove = new Icon(Icons.close,size: 30.0,);
  Widget _appBarTitle(){
    return Obx(
          () => Text(
        "DIV - ${goodsReceivedController.division_name.value}",
        style: TextStyle(
            fontSize: 18.0, color: Colors.black, fontFamily: "Gilroy"),
      ),
    );
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    double appbarheight = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: () async {
        goodsReceivedController.changetab(0);
        return false;
      },
      child: Scaffold(
        appBar:PreferredSize(
            child: _displayAppBar(), preferredSize: const Size.fromHeight(56)),
        body: Stack(
          children: [

            Obx(() => goodsReceivedController.filteredPendingGoodsList.value.isEmpty
                ? Container()
                : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: ListView.builder(
                itemCount:
                goodsReceivedController.filteredPendingGoodsList.value.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var dataModel =
                  goodsReceivedController.filteredPendingGoodsList.value[index];
                  return GestureDetector(
                    onTap: () {
                      goodsReceivedController.goToGoodsDetailsScreen(dataModel.dcNumber,dataModel.pono);
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: bordercolor1, width: 2.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      elevation: 0.0,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10.0,left: 10.0,bottom: 5.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                    dccolor1 /*Color.fromRGBO(30, 60, 168, 1)*/,
                                    child: Image.asset(
                                      "assets/images/vehicle.png",
                                      height: 30,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    /* child: Icon(Icons.person, color: Colors.white)*/
                                    //CircleAvatar(radius: 30, backgroundImage:  AssetImage(Helper.getAssetName("moryatoolslogo.png", "real"),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Expanded(
                                    flex:2,
                                    child: Text(
                                      '${dataModel.poNumber}',
                                      style: const TextStyle(
                                          color: textcolorgoods,
                                          fontSize: 14.0,
                                          fontFamily: "Gilroy",
                                          fontWeight: FontWeight.w700),

                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                              color: bordercolor1,
                              thickness: 2.0,
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'D.C Number - ${dataModel.dcNumber}',
                                          style: const TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600),
                                        ), const SizedBox(
                                          height: 5.0,
                                        ),

                                        Text(
                                          'P.O Number - ${dataModel.pono}',
                                          style: const TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: "Gilroy",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'CR Date',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontFamily: "Gilroy",
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${dataModel.crDate}',
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            fontFamily: "Gilroy",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
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
    );
  }

  Widget _displayProgress() {
    return Obx(() => goodsReceivedController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget _recivedGoodsheader() {
    return Obx(() => goodsReceivedController.pendingGoodsList.value.isEmpty
        ? Container()
        :ListView.builder(
      itemCount:1,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            children: [
              Container(
                width: 100,
                child: const Text(
                  'Dc Number',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Customer Name',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 100,
                child: const Text(
                  'CR Date',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600),
                ),
              ),

            ],
          ),
        );
      },
    ) );
  }

  Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() =>
    goodsReceivedController.ontapSearchFalg.value == false
        ? AppBar(
      backgroundColor: toolbarColor,
      title: _appBarTitle(),
      actions: [
        Container(
          width: 30,
          height: 30,
          child: GestureDetector(
            child: _searchIcon,
            onTap: () {
              goodsReceivedController.ontapSearchFalg.value = true;
              focusNode.requestFocus();
            },
          ),
        ),
      ],
    )
        : AppBar(
      backgroundColor: toolbarColor,
      title: new TextField(
        focusNode: focusNode,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        controller: goodsReceivedController.filter_textedit,
        decoration: new InputDecoration(
          border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        onChanged: (value) {
          goodsReceivedController
              .filterGoodsRec("", value.toString());
        },
      ),
      actions: [
        Container(
          width: 30,
          height: 30,
          child: GestureDetector(
            child: _searchIconRemove,
            onTap: () {
              goodsReceivedController.ontapSearchFalg.value = false;
              goodsReceivedController.clearFilter();
            },
          ),
        ),
      ],
    ));
  }

}

