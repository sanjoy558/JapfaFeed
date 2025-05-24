import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japfa_feed_application/controllers/addPlanController.dart';
import 'package:japfa_feed_application/responses/NewAutoCustomerListResponse.dart';
import 'package:japfa_feed_application/responses/VisitorListResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/views/newcustomerformscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final addplancontroller = Get.put(AddPlanController());
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
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Text(
                'Journey Plan',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),*/
              Obx(() =>  Text("DIV - ${addplancontroller.division_name.value}",
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
            Obx(() => addplancontroller.visitorList.value.isEmpty
                ? Container()
                : SingleChildScrollView(
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
                                color: statgradient3.withOpacity(0.1),
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 5.0,
                                    right: 5.0,
                                    bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Customer Type',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
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
                                                () => Text(addplancontroller
                                                .selected_dropdown_customertype ==
                                                null
                                                ? addplancontroller
                                                    .selected_dropdown_customertype
                                                .value
                                                .toString()
                                                : addplancontroller
                                                    .selected_dropdown_customertype
                                                .value
                                                .toString(),style: TextStyle(fontFamily: "Gilroy",color: Colors.black,fontWeight: FontWeight.w600),),
                                          ),
                                          items: addplancontroller
                                              .customerTypeList.value
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e.toString(),style: TextStyle(fontFamily: "Gilroy",color: Colors.black,fontWeight: FontWeight.w600)),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            addplancontroller
                                                .setSelectedCustomerType(
                                                value!);
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            addplancontroller.addplan_name.text="";
                                            addplancontroller.addplan_remark.text="";
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
                          oldForm(),

                          //old_new_form(),
                          //Obx(() =>addplancontroller.old_new_from.value?oldForm():newForm())

                          //oldForm(),
                          /*Obx(() => addplancontroller.old_new_from.value==true?oldForm():
                          newForm())*/
                         /* Visibility(
                            visible:addplancontroller.old_new_from.value,
                            child:
                          oldForm(),),
                          Visibility(
                            visible: !addplancontroller.old_new_from.value?true:false,
                            child:
                          newForm(),),*/

                        ],
                      ) ,
                    ),
                  )),
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


  Widget old_new_form(){
    return Wrap(
      direction: Axis.horizontal,
      children: [
        /* logintype(0),
                              logintype(1),*/
        GestureDetector(
          onTap: (){
            addplancontroller.changeform(true);
          },
          child: SizedBox(
            width: 150.0,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      loginCustomer),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ))),
              child: const Text(
                'Japfa Customer',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0,),
        GestureDetector(
          onTap: (){
            Get.to(() => NewCustomerFormScreen());
          },
          child: SizedBox(
            width: 150.0,
            child: ElevatedButton(
              onPressed:null ,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      loginEmployee),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ))),
              child: const Text(
                'New Customer',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget oldForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Obx(() => Visibility(
          visible: !addplancontroller.customerVisiblityFlag.value,
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: TypeAheadField(

                    controller: addplancontroller.autocompleteTextcontroller,
                    focusNode: FocusNode(),
                    /*textFieldConfiguration: TextFieldConfiguration(

                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Customer',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600)),
                    ),*/
                    suggestionsCallback: (pattern) {
                      return addplancontroller.newAutoCustomerList.value
                          .where((country) => country.customerName!.toLowerCase().contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.customerName.toString(),style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),),
                      );
                    },
                    onSelected: (suggestion) {
                      // Handle when a suggestion is selected.
                      addplancontroller.autocompleteTextcontroller.text = suggestion.customerName.toString();
                      print('Selected Customer: $suggestion');
                      addplancontroller.addplan_name.text=suggestion.customerName.toString();
                    },
                  ),
                ),
              ],
            ),
        ),],),),),

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
                Icons.person,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,

                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w600)),
                  style: const TextStyle(
                    fontFamily: 'Gilroy',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                  controller: addplancontroller.addplan_name,
                  keyboardType: TextInputType.text,
                  textCapitalization:
                  TextCapitalization.words,
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Date',
                style: TextStyle(
                    color: statgradient3,
                    fontSize: 14.0,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    addplancontroller.selectDate(context, "from");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
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
                                  fontFamily: 'Gilroy',
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600)),
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                            controller:
                            addplancontroller.fromdate,
                            keyboardType: TextInputType.text,
                            textCapitalization:
                            TextCapitalization.words,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
       /* Row(
          children: [
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    addplancontroller.selectDate(context, "from");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    margin: const EdgeInsets.only(
                        left: 20, right: 10, top: 10),
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
                            addplancontroller.fromdate,
                            keyboardType: TextInputType.text,
                            textCapitalization:
                            TextCapitalization.words,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    addplancontroller.selectDate(context, "to");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    margin: const EdgeInsets.only(
                        left: 10, right: 20, top: 10),
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
                            controller: addplancontroller.todate,
                            keyboardType: TextInputType.text,
                            textCapitalization:
                            TextCapitalization.words,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),*/
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
                      hintText: 'Remark',
                      hintStyle: TextStyle(
                        fontFamily: 'Gilroy',
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600)),
                  style: const TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                  controller:
                  addplancontroller.addplan_remark,
                  keyboardType: TextInputType.text,
                  textCapitalization:
                  TextCapitalization.words,
                ),
              ),
            ],
          ),
        ),
        /* DropdownButton(
                            items: addplancontroller.filteredCustomerList.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.firstName.toString()),
                                value: item.id,
                              );
                            }).toList(),
                            onChanged: (newVal) {


                            },
                            value: addplancontroller.selected_dropdown_object.value,
                          ),*/
/*
        Obx(() => Visibility(
          visible: addplancontroller.customerVisiblityFlag.value,
          child: Container()
        ),),*/

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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<VisitorListResponse>(
                    hint: SizedBox(
                      width:
                      MediaQuery.of(context).size.width *
                          .4,
                      child: Obx(
                            () => Text(addplancontroller
                            .selected_dropdown_object ==
                            null
                            ? addplancontroller
                            .selected_dropdown_string
                            .value
                            .toString()
                            : addplancontroller
                            .selected_dropdown_string
                            .value
                            .toString(),style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),),
                      ),
                    ),
                    items: addplancontroller.visitorList.value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                .4,
                            child:
                            Text(e.firstName.toString(),style: TextStyle(fontFamily: 'Gilroy',color: Colors.black,fontWeight: FontWeight.w600),)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      addplancontroller.setSelected(value!);
                      FocusScope.of(context)
                          .requestFocus(new FocusNode());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        Obx(() => Visibility(
          visible: addplancontroller.customerVisiblityFlag.value,
          child: GestureDetector(
            onTap: () {
              addplancontroller.selectedCustomerList.clear();
              addplancontroller.selectedCustomerList.refresh();
              addplancontroller.selected_customer_str.value =
              "";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Select Customers',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              addplancontroller
                                  .clerarfilterdTextfield();
                              Get.back();
                            },
                            child: const Text('Cancel',style: TextStyle(fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                                color: statgradient3),)),
                        TextButton(
                            onPressed: () {
                              Get.back();
                              addplancontroller
                                  .clerarfilterdTextfield();
                              addplancontroller.doneSelection();
                            },
                            child: const Text('Done',style: TextStyle(fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                                color: statgradient3),))
                      ],
                      content: setupAlertDialoadContainer(),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15.0),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                      color: Colors.white, width: 0.5),
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
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0),
                        child: Obx(
                              () => Text(
                            addplancontroller
                                .selected_customer_str.isEmpty
                                ? 'Select Customers'
                                : addplancontroller
                                .selected_customer_str.value,
                            style: const TextStyle(
                                color: statgradient3,
                                fontSize: 14.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),),

        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  addplancontroller.addPlan();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      statgradient3),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ))),
                child: const Text(
                  'Add Journey',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  /*Widget newForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textFormField("Firm Name",addplancontroller.customer_company_name,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),
        textFormField("Customer Name",addplancontroller.customer_name,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),

        textFormField("Mobile No.",addplancontroller.customer_mobile,TextInputType.number),
        const SizedBox(
          height: 5.0,
        ),
        textFormField("State",addplancontroller.customer_state,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),
        textFormField("District",addplancontroller.customer_district,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),
        textFormField("Tehsil",addplancontroller.customer_tehsil,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),
        textFormField("Monthly Total Feed Sales,MT",addplancontroller.customer_monthly_total_feed_sale_mt,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),

        textFormField("Tehsil",addplancontroller.customer_tehsil,TextInputType.text),
        const SizedBox(
          height: 5.0,
        ),

        textFormField("Tehsil",addplancontroller.customer_tehsil,TextInputType.text),
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
                  addplancontroller.addPlan();
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
                  'Add Plan',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'OpenSans',
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }*/

  Widget textFormField(String hinttext, TextEditingController customer_company_name, TextInputType name1, ){
    return Container(
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
            Icons.person,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child:
            TextFormField(
              decoration:  InputDecoration(
                  labelText: "$hinttext",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400)),
              style: const TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
              controller:customer_company_name,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              keyboardType: name1,
              autofocus: true,
              onFieldSubmitted: (sting ){

              },
            )
          ),
        ],
      ),
    );
  }



  Widget _displayProgress() {
    return Obx(() => addplancontroller.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      addplancontroller.filterPlayer(value.toString());
                    },
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                    controller: addplancontroller.addplan_name_customer_fliter,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: addplancontroller.filteredCustomerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataModel =
                        addplancontroller.filteredCustomerList.value[index];
                    return CheckboxListTile(
                        value: dataModel.checked!,
                        activeColor: statgradient3,
                        title: Text(dataModel.firstName.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Gilroy",color: Colors.black),),
                        onChanged: (vale) {
                          dataModel.checked = vale;
                          addplancontroller.filteredCustomerList.refresh();
                          print(dataModel.checked);
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void showAlertDialog(BuildContext context) {
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
                            "Select customer",
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
                        "Select customer type to proceed!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Gilroy',),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Old',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
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
                                /*FocusManager.instance.primaryFocus!.unfocus();*/

                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: Text('New',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
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
                                Get.back();
                                /*FocusManager.instance.primaryFocus!.unfocus();*/
                                addplancontroller.old_new_from.value=false;

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
                            color: statgradient3,
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
                        style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),
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
                                addplancontroller.changetab(0);

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
