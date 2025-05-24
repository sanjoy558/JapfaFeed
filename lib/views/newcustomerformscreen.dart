import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/newcustomerFormController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewCustomerFormScreen extends StatefulWidget {
  const NewCustomerFormScreen({Key? key}) : super(key: key);

  @override
  State<NewCustomerFormScreen> createState() => _NewCustomerFormScreenState();
}

class _NewCustomerFormScreenState extends State<NewCustomerFormScreen> {

  final customerFormController = Get.put(CustomerFormController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:() async{
          alertDialogDiscard("Discard");
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0.0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*const Text(
                  'New Customer',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),*/
                Obx(() =>  Text("DIV - ${customerFormController.division_name.value}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: "Gilroy"),
                ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    labelField("Firm Name"),
                    textFormField("Firm Name",customerFormController.customer_firmname_name,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Customer Name"),
                    textFormField("Customer Name",customerFormController.customer_name,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20.0,top: 5.0,right:20.0,bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Customer Type',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerRight,
                              child: DropdownButton<String>(
                                hint: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      .4,
                                  child: Obx(
                                        () => Text(customerFormController
                                        .selected_customertype_string ==
                                        null
                                        ? customerFormController
                                        .selected_customertype_string
                                        .value
                                        .toString()
                                        : customerFormController
                                        .selected_customertype_string
                                        .value
                                        .toString(),style: TextStyle(
                                            fontSize: 12.0
                                        )),
                                  ),
                                ),
                                items: customerFormController.customertypelist.value
                                    .map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .4,
                                        child:
                                        Text(e.toString(),style: TextStyle(
                                          fontSize: 12.0
                                        ),)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  customerFormController.setSelectedTransportType(value!);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(
                      height: 5.0,
                    ),

                    labelField("Mobile No."),

                    textFormField("Mobile No.",customerFormController.customer_mobile,TextInputType.number),
                    const SizedBox(
                      height: 5.0,
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 20.0,left: 20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: labelField2("State"),),
                              SizedBox(width: 5.0,),
                              Expanded(child: labelField2("District"),),
                              SizedBox(width: 5.0,),
                              Expanded(child: labelField2("Tehsil"),),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Container(
                                child: textFormField1("State",customerFormController.customer_state,TextInputType.text),
                              ),),
                              SizedBox(width: 5.0,),
                              Expanded(child: Container(child: textFormField1("District",customerFormController.customer_district,TextInputType.text),),),
                              SizedBox(width: 5.0,),
                              Expanded(child: Container(child: textFormField1("Tehsil",customerFormController.customer_tehsil,TextInputType.text),),),

                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Village"),
                    textFormField("Village",customerFormController.customer_village,TextInputType.text),

                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Monthly Total Feed Sales,MT"),
                    textFormField("Monthly Total Feed Sales,MT",customerFormController.customer_monthly_total_feed_sale_mt,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Feed Buying From"),
                    textFormField("Feed Buying From",customerFormController.customer_feed_buying_from,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Monthly Feed Sales"),
                    textFormField("Monthly Feed Sales",customerFormController.customer_monthly_feed_sale,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Top Selling SKU Name"),
                    textFormField("Top Selling SKU Name",customerFormController.customer_top_selling_sku_name,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Top Selling SKU Price, Rs. Per Bag"),
                    textFormField("Top Selling SKU Price, Rs. Per Bag",customerFormController.customer_top_selling_sku_price_per_bag,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Top Selling SKU Monthly Sales, MT"),
                    textFormField("Top Selling SKU Monthly Sales, MT",customerFormController.customer_top_selling_sku_monthly_sale,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Company Name"),
                    textFormField("Company Name",customerFormController.customer_company_name,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Monthly Sales, MT"),
                    textFormField("Monthly Sales, MT",customerFormController.customer_monthly_sales_mt,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Feed Buying Type"),
                    textFormField("Feed Buying Type",customerFormController.customer_feed_buying_type,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Payment Terms"),
                    textFormField("Payment Terms",customerFormController.customer_payment_terms,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Top Selling SKU"),
                    textFormField("Top Selling SKU",customerFormController.customer_top_selling_sku,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Top SKU Selling Price 50kg Bag"),
                    textFormField("Top SKU Selling Price 50kg Bag",customerFormController.customer_top_sku_selling_price_50_kg_bag,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Cash Discount"),
                    textFormField("Cash Discount",customerFormController.customer_cah_discount,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Monthly Target"),
                    textFormField("Monthly Target",customerFormController.customer_monthly_target_mt,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Monthly Scheem Rs. Per Bag"),
                    textFormField("Monthly Scheem Rs. Per Bag",customerFormController.customer_monthly_scheem_rs_per_bag,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
                    ),
                    labelField("Remark"),
                    textFormField("Remark",customerFormController.customer_remark,TextInputType.text),
                    const SizedBox(
                      height: 5.0,
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
                              alertDialog();

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
                              'Submit',
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
                ),
              ),
              _displayProgress()
            ],

          ),
        ),
      );


  }

  Widget textFormField1(String hinttext, TextEditingController customer_company_name, TextInputType name1, ){
    return Container(
      height: 40.0,
      padding: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child:
              TextFormField(
                decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: hinttext,
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),),
                style:  TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
                controller:customer_company_name,
                cursorColor: Colors.black,
                keyboardType: name1,
                autofocus: true,

              )
          ),
        ],
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => customerFormController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget labelField(String hinttext){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        hinttext,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget labelField2(String hinttext){
    return Container(
      child: Text(
        hinttext,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w400),
      ),
    );
  }
  Widget textFormField(String hinttext, TextEditingController customer_company_name, TextInputType name1, ){
    return Container(
      height: 40.0,
      padding: const EdgeInsets.only(left: 10.0),
      margin: const EdgeInsets.only(
          left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.grey[200],),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child:
              TextFormField(
                decoration:  InputDecoration(
                    border: InputBorder.none,

                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400)),
                style: const TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
                controller:customer_company_name,
                cursorColor: Colors.black,
                keyboardType: name1,
                autofocus: true,

              )
          ),
        ],
      ),
    );
  }

  void alertDialog() {
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
                            "Customer Form",
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
                        "Submit Customer Form Now!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Cancel',
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
                              child: Text('Submit',
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
                                customerFormController.submitForm();

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

  void alertDialogDiscard(String str_exit_logout) {
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
                                Get.back();
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






}
