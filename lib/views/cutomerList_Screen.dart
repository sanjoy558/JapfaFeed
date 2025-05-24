import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customerListController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/NavagationDrawerWidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final customerListController = Get.put(CustomerListController());


  var focusNode = FocusNode();
  Icon _searchIcon = new Icon(Icons.search,size: 30.0,);
  Icon _searchIconRemove = new Icon(Icons.close,size: 30.0,);
  Widget _appBarTitle(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       /* Text(
          'Customers',
          style: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),*/
        Obx(() =>  Text("DIV - ${customerListController.division_name.value}",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: "Gilroy"),
        ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        customerListController.changetab(0);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
            child: _displayAppBar(), preferredSize: const Size.fromHeight(56)),
       /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => customerListController.filteredcustomerList.value.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                physics: const ScrollPhysics(),
                    child: ListView.builder(
                        itemCount:
                            customerListController.filteredcustomerList.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var dataModel =
                              customerListController.filteredcustomerList.value[index];
                          //print(dataModel.toJson());
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: bordercolor1,width: 2.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${dataModel.firstName}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'Address : ${dataModel.addressLine2}, ${dataModel.addressLine1}',
                                            style: const TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${dataModel.phone}',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        customerListController.callCustomer(dataModel);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: Card(
                                          color: callbuttoncolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(180),
                                          ),
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 25.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    return Obx(() => customerListController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget _displayAppBar() {
    //https://medium.com/codechai/a-simple-search-bar-in-flutter-f99aed68f523
    return Obx(() =>
    customerListController.ontapSearchFalg.value == false
        ? AppBar(
      backgroundColor: toolbarColor,
      title: _appBarTitle(),
      actions: [
        Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child: _searchIcon,
            onTap: () {
              customerListController.ontapSearchFalg.value = true;
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
        style: TextStyle(color: Colors.black,fontFamily: "Gilroy"),
        controller: customerListController.filter_textedit,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(
              fontFamily: "Gilroy",
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        onChanged: (value) {
          customerListController
              .filterGoodsRec("", value.toString());
        },
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          width: 30,
          height: 30,
          child: GestureDetector(
            child: _searchIconRemove,
            onTap: () {
              customerListController.ontapSearchFalg.value = false;
              customerListController.clearFilter();
            },
          ),
        ),
      ],
    ));
  }
}

/*class CustomerListScreen extends StatelessWidget {
  final customerListController = Get.put(CustomerListController());

  CustomerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Customers',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Obx(() => customerListController.customerList.value.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount:
                          customerListController.customerList.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var dataModel =
                            customerListController.customerList.value[index];
                        //print(dataModel.toJson());
                        return GestureDetector(
                          onTap: () {
                            //controller.displayOrderDetails(dataModel);
                          },
                          child: Card(
                            margin: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${dataModel.firstName}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${dataModel.addressLine1}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/images/sync_red.png',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text('${dataModel.phone}',
                                          style: const TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => customerListController.displayLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : Container());
  }
}*/
