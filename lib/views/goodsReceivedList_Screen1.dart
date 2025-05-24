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

class GoodsReceivedListScreen extends StatefulWidget {
  const GoodsReceivedListScreen({Key? key}) : super(key: key);

  @override
  State<GoodsReceivedListScreen> createState() =>
      _GoodsReceivedListScreenState();
}

class _GoodsReceivedListScreenState extends State<GoodsReceivedListScreen>
    with SingleTickerProviderStateMixin {
  final goodsReceivedController = Get.put(GoodsReceivedController());
  final pageviewController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );
  bool isLastPage = false;

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
        appBar: AppBar(
          backgroundColor: dashbordhighlight_blue,
          title: const Text(
            'Pending Delivery',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: PageView(
                physics: CustomPageViewScrollPhysics(),
                controller: pageviewController,
                pageSnapping: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 1;
                    goodsReceivedController.tabindex.value = index;
                  });
                },
                children: [
                  buildPage(
                      urlImage: "assets/images/joker.png",
                      title: "",
                      discription: ""),
                  buildPage(
                      urlImage: "assets/images/joker.png",
                      title: "",
                      discription: ""),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Expanded(child: logintype(0)),
                  Expanded(child: logintype(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => goodsReceivedController.displayLoading.value == true
        ?  Center(child:progressBarCommon())
        : Container());
  }

  Widget logintype(int buttontype) {
    return Obx(() => buttontype == 0
        ? Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: goodsReceivedController.tabindex.value == 0
                    ? dashbordhighlight_blue
                    : Colors.grey,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            height: 50,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Customer',
                style: TextStyle(
                  fontSize: 20.0,
                  color: goodsReceivedController.tabindex.value == 0
                      ? Colors.white
                      : Colors.black54,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: goodsReceivedController.tabindex.value == 1
                    ? dashbordhighlight_blue
                    : Colors.grey,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            height: 50,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Employee',
                style: TextStyle(
                    fontSize: 20.0,
                    color: goodsReceivedController.tabindex.value == 1
                        ? Colors.white
                        : Colors.black54,
                    decoration: TextDecoration.none),
              ),
            ),
          ));
  }

  Widget buildPage(
          {required String urlImage,
          required String title,
          required String discription}) =>
      Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Stack(
          children: [
            Obx(() => goodsReceivedController.pendingGoodsList.value.isEmpty
                ? Container()
                : SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: ListView.builder(
                      itemCount:
                      goodsReceivedController.pendingGoodsList.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var dataModel =
                        goodsReceivedController.pendingGoodsList.value[index];
                        return GestureDetector(
                          onTap: () {
                            /*goodsReceivedController.callCustomer(dataModel);*/
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            elevation: 5,
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${dataModel.dcNumber}',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '${dataModel.quantity}',
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: const EdgeInsets.all(5.0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          180),
                                                ),
                                                elevation: 3,
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Colors.red,
                                                  size: 25.0,
                                                ),
                                              ))),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${dataModel.vehicleNumber}',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w600),
                                        ),
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
      );
}


class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 80,
    stiffness: 100,
    damping: 1,
  );
}

