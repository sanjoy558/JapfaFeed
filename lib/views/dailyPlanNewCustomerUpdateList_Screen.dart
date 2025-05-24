import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/controllers/dailyPlanNewCustomerUpdateController.dart';
import 'package:japfa_feed_application/controllers/goodsReceivedController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DailyPlanNewCustomerUpdateList_Screen extends StatefulWidget {
  const DailyPlanNewCustomerUpdateList_Screen({Key? key}) : super(key: key);

  @override
  State<DailyPlanNewCustomerUpdateList_Screen> createState() =>
      _DailyPlanNewCustomerUpdateList_ScreenState();
}

class _DailyPlanNewCustomerUpdateList_ScreenState extends State<DailyPlanNewCustomerUpdateList_Screen>
    with SingleTickerProviderStateMixin {
  final dailyPlanNewCustomerUpdateController = Get.put(DailyPlanNewCustomerUpdateController());

  bool isLastPage = false;

  var focusNode = FocusNode();
  Icon _searchIcon = new Icon(Icons.search,size: 30.0,);
  Icon _searchIconRemove = new Icon(Icons.close,size: 30.0,);
  Widget _appBarTitle = new Text(
    'New Customer',
    style: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        color: Colors.black),
  );

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    double appbarheight = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: () async {
        dailyPlanNewCustomerUpdateController.changetab(0);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
            child: _displayAppBar(), preferredSize: const Size.fromHeight(56)),
        body: Stack(
          children: [

            Obx(() => dailyPlanNewCustomerUpdateController.filtered_newcustomer_enquiryList.value.isEmpty
                ? Container()
                : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: ListView.builder(
                itemCount:
                dailyPlanNewCustomerUpdateController.filtered_newcustomer_enquiryList.value.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var dataModel =
                  dailyPlanNewCustomerUpdateController.filtered_newcustomer_enquiryList.value[index];
                  return GestureDetector(
                    onTap: () {
                      dailyPlanNewCustomerUpdateController.goToNewCustomerFormScreen(dataModel);
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      elevation: 5,
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Text(
                                    '${dataModel.customerName}',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.w600),

                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 5.0,
                            ),

                            Text(
                              'Mobile Number - ${dataModel.mobileNumber==""?"N/A":dataModel.mobileNumber}',
                              style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600),
                            ), const SizedBox(
                              height: 5.0,
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
    return Obx(() => dailyPlanNewCustomerUpdateController.displayLoading.value == true
        ?  Center(child:progressBarCommon())
        : Container());
  }
  Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() =>
    dailyPlanNewCustomerUpdateController.ontapSearchFalg.value == false
        ? AppBar(
      backgroundColor: primaryColor,
      elevation: 0.0,
      title: _appBarTitle,
      actions: [
        Container(
          width: 30,
          height: 30,
          child: GestureDetector(
            child: _searchIcon,
            onTap: () {
              dailyPlanNewCustomerUpdateController.ontapSearchFalg.value = true;
              focusNode.requestFocus();
            },
          ),
        ),
      ],
    )
        : AppBar(
      backgroundColor: primaryColor,
      elevation: 0.0,
      title: new TextField(
        focusNode: focusNode,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        controller: dailyPlanNewCustomerUpdateController.filter_textedit,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        onChanged: (value) {
          dailyPlanNewCustomerUpdateController
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
              dailyPlanNewCustomerUpdateController.ontapSearchFalg.value = false;
              dailyPlanNewCustomerUpdateController.clearFilter();
            },
          ),
        ),
      ],
    ));
  }

}

