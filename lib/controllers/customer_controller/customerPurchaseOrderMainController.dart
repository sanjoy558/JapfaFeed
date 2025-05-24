import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/responses/CustomerListResponse.dart';
import 'package:japfa_feed_application/responses/PlantResponse.dart';
import 'package:japfa_feed_application/responses/ProductListResponse.dart';
import 'package:japfa_feed_application/responses/PurchaseOrderInsertResponse.dart';
import 'package:japfa_feed_application/responses/TempProductList.dart';
import 'package:japfa_feed_application/responses/TempProductList1.dart';
import 'package:japfa_feed_application/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/views/customer/customerPurchaseOrderList_Screen.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:darq/darq.dart';

class CustomerPurchaseOrderMainController extends GetxController {
  var imagename = "".obs;
  XFile? image;

  var displayLoading = false.obs;
  var selected_customer_str = "".obs;
  var selected_customer_id = "".obs;
  var selected_customer_zone = "".obs;
  var executive_id = "".obs;
  var firstname = "";
  var userId = "";
  var tokenid = "";
  var latitude = "".obs;
  var longitude = "".obs;
  var division_id="".obs;
  var division_name="".obs;

  //var tempProductList = List<TempProductList>.empty().obs;
  List<TempProductList> tempProductList = [];
  List<TempProductList1> tempProductList1 = [];
  var productlist = List<ProductListResponse>.empty().obs;
  var productlistDiscovered = List<ProductListResponse>.empty().obs;
  var productlIstitme = ProductListResponse();
  var plantlsit = List<PlantResponse>.empty().obs;
  var filteredplantlsit = List<PlantResponse>.empty().obs;
  var customerList = List<CustomerListResponse>.empty().obs;
  var customerList1 = List<CustomerListResponse>.empty().obs;
  var filteredCustomerList = List<CustomerListResponse>.empty().obs;
  CustomerListResponse? customerListResponse;
  final addplan_name_customer_fliter = TextEditingController();
  final payment_details = TextEditingController();

  var selected_dropdown_object = PlantResponse().obs;
  var selected_dropdown_string = "Select Plant".obs;
  var selected_transporttype_string = "Select Transport".obs;

  var selected_dropdown_brand = "".obs;
  var allbrandlist = List<String>.empty().obs;
  var brandlist = List<String>.empty().obs;

  var selected_dropdown_bird = "".obs;
  var allbirdlist = List<String>.empty().obs;
  var birdlist = List<String>.empty().obs;

  var selected_dropdown_stage = "".obs;
  var allstagelist = List<String>.empty().obs;
  var stagelist = List<String>.empty().obs;

  var selected_dropdown_matrial_text = "".obs;
  var selected_dropdown_matrial = "".obs;
  var allmatriallist = List<String>.empty().obs;
  var matriallist = List<String>.empty().obs;
  var transportList = List<String>.empty().obs;

  late Future<void> _launched;

  var bags_qty = TextEditingController();
  var bagsqty = "".obs;
  var bags_in_kg = "".obs;
  String base64img = "";

  var per_bag_weight=0.0.obs;

  /* var newproductid = "".obs;*/

  final textEditPlantController = TextEditingController();


  @override
  void onInit() {
    getCurrentLocation();
    if (MainPresenter.getInstance().userModel.userId != null) {
      userId = MainPresenter.getInstance().userModel.userId!;
      firstname = MainPresenter.getInstance().userModel.firstName!;
      tokenid = MainPresenter.getInstance().userModel.tokenid!;
      selected_customer_id.value = userId;
      selected_customer_zone.value = MainPresenter.getInstance().userModel.zone!;
      executive_id.value = MainPresenter.getInstance().userModel.executiveId!;
      division_id.value = MainPresenter.getInstance().userModel.divisionid!;
      division_name.value = MainPresenter.getInstance().userModel.divisionname!;
      MainPresenter.getInstance().printLog("userid tushar1 executive_id", executive_id.value);


      //getCustomerList();
      getPlantList();
      getProductList();
      transportList.clear();
      transportList.add('EXW');
      transportList.add('EUP');
      transportList.add('FOR');
      tempProductList.clear();
    }

    /* if (Get.arguments != null) {
      customerList1.value = Get.arguments['customer_list'];
      print(' details screen customerList1 : ${customerList1.value.length}');
      filteredCustomerList.value = customerList1.value;
      print(' details screen filteredCustomerList : ${filteredCustomerList.value.length}');
    }*/
  }

  Future<void> openAndCloseLoadingDialog(String title, String msg) async {
    Get.defaultDialog(title: title, content: Text("$msg"), actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'))
    ]);
  }

  void getCustomerList() {
    print("getCustomerList : ${tokenid}");
    displayLoading.value = true;
    final body = jsonEncode({
      /* 'username': "0030000001",
      'password': "12345678",
      'rememberMe': 'true',*/
    });
    ApiService()
        .executeWithBearerTokenGET('api/mobile/my-customers', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          customerList.value =
              list.map((e) => CustomerListResponse.fromJson(e)).toList();
          filteredCustomerList.value = customerList.value;

          customerList1.value = customerList.value.toSet().toList();

          MainPresenter.getInstance()
              .printLog("customerlist1", customerList.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Login', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Login', "Invalid Login Credentials..");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Login', 'Please try again');
    });
  }

  void getPlantList() {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/plants/division', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
         /* final list = jsonDecode(response.body) as List<dynamic>;
          plantlsit.value = list.map((e) => PlantResponse.fromJson(e)).toList();*/

          final list = jsonDecode(response.body) as List<dynamic>;
          plantlsit.value = list.map((e) => PlantResponse.fromJson(e)).toList();
          filteredplantlsit.value = list.map((e) => PlantResponse.fromJson(e)).toList();

          MainPresenter.getInstance()
              .printLog("plantlsit", plantlsit.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Plant', "Server error");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Plant', "Server error");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Plant', 'Please try again');
    });
  }

  void getProductList() {
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeWithBearerTokenGET('api/products-division?division=${division_id.value}', tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          final list = jsonDecode(response.body) as List<dynamic>;
          productlist.value =
              list.map((e) => ProductListResponse.fromJson(e)).toList();

          for (var abc in productlist.value) {
            allbrandlist.add(abc.brand.toString());
          }
          brandlist.value = allbrandlist.value.distinct().toList();

          MainPresenter.getInstance()
              .printLog("brandlist", brandlist.value.length);

          MainPresenter.getInstance()
              .printLog("productlist", productlist.value.length);
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Product List', "Server error1");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Product List', "Server error2");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Product List', 'Please try again');
    });
  }

  void changetab(int i) {
    Get.back();
  }

  void callCustomer(CustomerListResponse dataModel) {
    if (dataModel.phone != null && dataModel.phone!.length > 0)
      _launched = _launchedyoutube('tel://${dataModel.phone!}');
    FutureBuilder<void>(future: _launched, builder: _launchStatus);
  }

  Future<void> _launchedyoutube(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{"my_header_key": "my_header_view"},
      );
    } else {
      throw "not launch $url";
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text("Error : ${snapshot})");
    } else {
      return const Text("");
    }
  }

  void clerarfilterdTextfield() {
    addplan_name_customer_fliter.clear();
    filteredCustomerList.value = customerList1.value;
    filteredCustomerList.refresh();
  }

  void doneSelection(String selectedName, String customerid, String zone) {
    selected_customer_str.value = selectedName;
    selected_customer_id.value = customerid.toString();
    selected_customer_zone.value = zone.toString();
    /*for (var abc in filteredCustomerList.value) {
      if (abc.checked == true) {
        */ /*selectedCustomerList.add(abc);*/ /*
        selected_customer_str.value =
            selected_customer_str.value + "\n" + abc.firstName.toString();
      }
    }*/
  }

  void filterPlayer(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<CustomerListResponse> results = [];
    if (playerName.isEmpty) {
      results = customerList1;
    } else {
      results = customerList1
          .where((element) => element.firstName
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredCustomerList.value = results;
  }

  void setSelected(PlantResponse value) {
    MainPresenter.getInstance().printLog("TAG", value.name.toString());
    selected_dropdown_string.value = value.name.toString();
    selected_dropdown_object.value = value;
    refresh();
    /*getCustomerList(value.id.toString());*/
  }

  void setSelectedTransportType(String value) {
    MainPresenter.getInstance()
        .printLog("TAG transport type", value.toString());
    selected_transporttype_string.value = value.toString();
    refresh();
    /*getCustomerList(value.id.toString());*/
  }

  void setSelectedBrandvalue(String s) {
    selected_dropdown_brand.value = s;

    allbirdlist.value.clear();
    selected_dropdown_bird.value = "";

    allstagelist.value.clear();
    selected_dropdown_stage.value = "";

    allmatriallist.clear();
    selected_dropdown_matrial.value = "";
    per_bag_weight.value=0.0;
    bags_in_kg.value = "";
    bags_qty.text="";

    for (var abc in productlist.value) {
      if (abc.brand == s) {
        allbirdlist.add(abc.bird.toString());
      }
    }
    birdlist.value = allbirdlist.value.distinct().toList();
    MainPresenter.getInstance().printLog("birdlist", birdlist.value.length);
  }

  void setSelectedBirdvalue(String s) {
    selected_dropdown_bird.value = s;

    allstagelist.value.clear();
    selected_dropdown_stage.value = "";

    allmatriallist.clear();
    selected_dropdown_matrial.value = "";
    per_bag_weight.value=0.0;
    bags_in_kg.value = "";
    bags_qty.text="";

    for (var abc in productlist.value) {
      if (abc.brand == selected_dropdown_brand.value &&
          abc.bird == selected_dropdown_bird.value) {
        allstagelist.add(abc.stage.toString());
      }
    }

    stagelist.value = allstagelist.value.distinct().toList();
    MainPresenter.getInstance().printLog("stagelist", stagelist.value.length);
  }

  void setSelectedStagevalue(String s) {
    selected_dropdown_stage.value = s;

    allmatriallist.clear();
    selected_dropdown_matrial.value = "";
    per_bag_weight.value=0.0;
    bags_in_kg.value = "";
    bags_qty.text="";

    for (var abc in productlist.value) {
      if (abc.brand == selected_dropdown_brand.value &&
          abc.bird == selected_dropdown_bird.value &&
          abc.stage == selected_dropdown_stage.value) {
        allmatriallist.add(abc.materialType.toString());
      }
    }

    matriallist.value = allmatriallist.value.distinct().toList();
    MainPresenter.getInstance()
        .printLog("matriallist", matriallist.value.length);
  }

  void selectmatrial(String s) {
    productlistDiscovered.clear();
    selected_dropdown_matrial.value = s;
    MainPresenter.getInstance().printLog("selected matrial", s);

    for (var item in productlist) {
      if (item.brand == selected_dropdown_brand.value &&
          item.bird == selected_dropdown_bird.value &&
          item.stage == selected_dropdown_stage.value &&
          item.materialType == selected_dropdown_matrial.value) {
        productlistDiscovered.add(item);
        print(item.id);
        print(item.weight);
      }
    }

    per_bag_weight.value=productlistDiscovered[0].weight!;
    selected_dropdown_matrial_text.value=productlistDiscovered[0].materialText!;

    MainPresenter.getInstance().printLog("selected matrial", (per_bag_weight.value).toString());
    MainPresenter.getInstance().printLog("selected matrial", (productlistDiscovered[0].id).toString());
    MainPresenter.getInstance().printLog("selected matrial/////", (productlistDiscovered.length).toString());

    if (bags_qty.text == "") {
      bags_in_kg.value = "";
    } else {
      bags_in_kg.value = (int.parse(bags_qty.text) * per_bag_weight.value).toString();
    }
  }

  void submit() {
    productlistDiscovered.clear();
    if (validateAddList()) {
      DateTime now = DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String todays_date = formatter.format(now);
      //todays_date
      print("todyas date is : ${todays_date}");
      print(now.toString());

      String dateinmilliseconds =
          (DateTime.now().millisecondsSinceEpoch).toString();
      print(DateTime.now().millisecondsSinceEpoch);

      for (var item in productlist) {
        if (item.brand == selected_dropdown_brand.value &&
            item.bird == selected_dropdown_bird.value &&
            item.stage == selected_dropdown_stage.value &&
            item.materialType == selected_dropdown_matrial.value) {
          productlistDiscovered.add(item);
          print(item.id);
          print(item.weight);
        }
      }
      productlIstitme = productlistDiscovered[0];
      var data = tempProductList.where((row) =>
          (row.productid!.contains(productlIstitme.productId as Pattern)));
      if (data.length >= 1) {
        //tempProductList.removeWhere((item) => (item.productid!.contains(productlIstitme.productId as Pattern)));
        int itemIndex = tempProductList
            .indexWhere((item) => item.productid == productlIstitme.productId);
        tempProductList[itemIndex] = TempProductList(
            productid: productlIstitme.productId.toString(),
            headerId: dateinmilliseconds,
            brand: productlIstitme.brand.toString(),
            bird: productlIstitme.bird.toString(),
            material: productlIstitme.materialType.toString(),
            modifiedOn: todays_date.toString(),
            noOfBags: int.parse(bags_qty.text.toString()),
            packageingWeight: productlIstitme.weight,
            stage: productlIstitme.stage.toString(),
            totalQuantity: double.parse(bags_in_kg.value));
      } else {
        tempProductList.add(TempProductList(
            productid: productlIstitme.productId.toString(),
            headerId: dateinmilliseconds,
            brand: productlIstitme.brand.toString(),
            bird: productlIstitme.bird.toString(),
            material: productlIstitme.materialType.toString(),
            modifiedOn: todays_date.toString(),
            noOfBags: int.parse(bags_qty.text.toString()),
            packageingWeight: productlIstitme.weight,
            stage: productlIstitme.stage.toString(),
            totalQuantity: double.parse(bags_in_kg.value)));
      }
    }

    //userId//userid

    selected_dropdown_brand.value = "";
    selected_dropdown_bird.value = "";
    selected_dropdown_matrial.value = "";
    selected_dropdown_stage.value = "";
    bags_qty.clear();
    bagsqty.value = "";
    bags_in_kg.value = "";
    per_bag_weight.value=0.0;
    print(tempProductList.length);
    update();
  }

 /* void updateListAtGivenIndex(int i, String productid, date, String date1) {
    print('updated for');

    tempProductList[i] = TempProductList(
        productid: productid.toString(),
        headerId: date,
        brand: selected_dropdown_brand.toString(),
        bird: selected_dropdown_bird.toString(),
        material: selected_dropdown_matrial.toString(),
        modifiedOn: date1.toString(),
        noOfBags: int.parse(bags_qty.text.toString()),
        packageingWeight: 50,
        stage: selected_dropdown_stage.toString(),
        totalQuantity: double.parse(bags_in_kg.value));
    selected_dropdown_brand.value = "";
    selected_dropdown_bird.value = "";
    selected_dropdown_matrial.value = "";
    selected_dropdown_stage.value = "";
  }

  void addnew(String productid, String date, String date1) {
    print('added for');
    tempProductList.add(TempProductList(
        productid: productid.toString(),
        headerId: date,
        brand: selected_dropdown_brand.toString(),
        bird: selected_dropdown_bird.toString(),
        material: selected_dropdown_matrial.toString(),
        modifiedOn: date1.toString(),
        noOfBags: 1,
        packageingWeight: 50,
        stage: selected_dropdown_stage.toString(),
        totalQuantity: double.parse(bags_in_kg.value)));
    selected_dropdown_brand.value = "";
    selected_dropdown_bird.value = "";
    selected_dropdown_matrial.value = "";
    selected_dropdown_stage.value = "";
  }*/

  void getqty() {
    if (bags_qty.text == "") {
      bags_in_kg.value = "";
    } else {
      bags_in_kg.value = (int.parse(bags_qty.text) * per_bag_weight.value).toString();
    }
  }

  void approveProduct() {
    if (validateSubmitList()) {
      DateTime now = DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String todays_date = formatter.format(now);
      //todays_date
      print("todyas date is : ${todays_date}");
      tempProductList1.clear();

      String datetime_inmiliseconds = "";
      datetime_inmiliseconds =
          (DateTime.now().millisecondsSinceEpoch).toString();

      for (int i = 0; i < tempProductList.length; i++) {
        tempProductList1.add(TempProductList1(
            headerId: int.parse(datetime_inmiliseconds),
            brand: tempProductList[i].brand,
            bird: tempProductList[i].bird,
            material: tempProductList[i].material,
            modifiedOn: tempProductList[i].modifiedOn,
            noOfBags: tempProductList[i].noOfBags,
            packageingWeight: tempProductList[i].packageingWeight,
            stage: tempProductList[i].stage,
            totalQuantity: tempProductList[i].totalQuantity,
            productId: tempProductList[i].productid.toString()));
      }

      String encoded =
          jsonEncode(tempProductList1.map((i) => i.toJson()).toList())
              .toString();

      print(encoded);

      /*paymentImage*/
      final body = jsonEncode([
        {
          'id': "",
          'orderUUID': int.parse(datetime_inmiliseconds),
          'adminStatus': "",
          'cancelRemark': "",
          'createdOn': "$todays_date",
          'createdBy': "${userId.toString()}",
          'execStatus': "",
          'grnStatus': "",
          'modifiedOn': "$todays_date",
          'paymentMethod': "",
          'paymentRemark': "${payment_details.text.toString()}",
          'paymentImage': "${base64img}",
          'remark': "",
          'salesOrderStatus': "",
          'sapId': "",
          'status': "Created",
          'transportArrangeBy': "${selected_transporttype_string.toString()}",
          'type': "Customer",
          'zone': "${selected_customer_zone.value}",
          'longitude': "$longitude",
          'latitude': "$latitude",
          'plant': "${selected_dropdown_string.value}",
          'transport': "",
          'items': tempProductList1,
          'customer': {"id": int.parse(selected_customer_id.value)},
          'exec': {
            "id": executive_id.value,
          },
          'divisionId':"${division_id.value}",
          'divisionName':"${division_name.value}",
        }
      ]);
      print("body : ${body}");
      datetime_inmiliseconds = "";

      insertdata(body);
    }
  }

  bool validateSubmitList() {
    if (tempProductList.length < 1) {
      MainPresenter.getInstance().showErrorToast("Invlid Products");
      return false;
    } else {
      return true;
    }
  }

  bool validateAddList() {
     if (selected_transporttype_string.value.toString() ==
        "Select Transport") {
      MainPresenter.getInstance().showErrorToast("Invlid Transport Type");
      return false;
    } else if (selected_dropdown_string.value.toString() == "Select Plant") {
      MainPresenter.getInstance().showErrorToast("Invlid Plant");
      return false;
    } else if (selected_dropdown_brand.value == "") {
      MainPresenter.getInstance().showErrorToast("Invlid Brand");
      return false;
    } else if (selected_dropdown_bird.value == "") {
      MainPresenter.getInstance().showErrorToast("Invlid Bird");
      return false;
    } else if (selected_dropdown_stage.value == "") {
      MainPresenter.getInstance().showErrorToast("Invlid Stage");
      return false;
    } else if (selected_dropdown_matrial.value == "") {
      MainPresenter.getInstance().showErrorToast("Invlid Material");
      return false;
    } else if (bags_in_kg.value == "") {
      MainPresenter.getInstance().showErrorToast("Invlid Quantity");
      return false;
    } else {
      return true;
    }
  }

  void insertdata(String body) {
    print("body : ${body}");
    print("tokenid : ${tokenid}");
    displayLoading.value = true;
    ApiService()
        .executeRawPOSTWithToken('api/purchase-order-list', body, tokenid!)
        .then((value) {
      http.Response response = value;
      if (response.statusCode == 200) {
        displayLoading.value = false;
        if (response.body != null) {
          PurchaseOrderInsertResponse purchaseOrderInsertResponse =
              PurchaseOrderInsertResponse.fromJson(jsonDecode(response.body));
          if (purchaseOrderInsertResponse.success![0] != null) {
            displayLoading.value = false;
            base64img = "";
            per_bag_weight.value=0.0;
            Get.back();
            Get.offAll(() => CustomerPurchaseOrderListScreen(), arguments: {
              'refresh': "true",
            });
            MainPresenter.getInstance().showToast("Successfully Inserted");
          } else {
            displayLoading.value = false;
            //openAndCloseLoadingDialog('Purchase Order', "Invalid Data");
          }
        } else {
          displayLoading.value = false;
          //openAndCloseLoadingDialog('Purchase Order', "Server error1");
        }
      } else {
        displayLoading.value = false;
        //openAndCloseLoadingDialog('Purchase Order', "Server error2");
      }
    }).catchError((onError) {
      print(onError);
      displayLoading.value = false;
      //openAndCloseLoadingDialog('Purchase Order', 'Please try again');
    });
  }

  void getCurrentLocation() async {
    // ask permissions
    // ask gps on
    // get latitude and longitude
    // call api to get store details
    LocationData? currentLocation;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.getLocation().then(
      (location) async {
        currentLocation = location;
        // call api
        if (currentLocation?.latitude != null) {
          latitude.value = (currentLocation?.latitude).toString();
          longitude.value = (currentLocation?.longitude).toString();
          MainPresenter.getInstance().printLog(
              "location", "latitude: $latitude \n longitude:$longitude");
        }
      },
    );
  }

  Future<void> setimage(XFile? img) async {
    image = img;
    imagename.value = image!.name.toString();

    var bytes = await image!.readAsBytes();
    base64img = base64Encode(bytes);
    print(base64img);
  }

  void removeProductFromTempList(String? productid) {
    Get.back();
    tempProductList.removeWhere((item) =>
    (item.productid!.contains(productid as Pattern)));
    update();
  }

  void filterPlant(String playerName) {
    //https://github.com/RipplesCode/FilterListViewFlutterGetX/tree/master
    List<PlantResponse> results = [];
    if (playerName.isEmpty) {
      results = plantlsit;
    } else {
      results = plantlsit
          .where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase()))
          .toList();
    }
    filteredplantlsit.value = results;
  }

  void setPlantSelected(PlantResponse value) {
    MainPresenter.getInstance().printLog("TAG", value.name.toString());
    selected_dropdown_string.value = value.name.toString();
    selected_dropdown_object.value = value;
    refresh();
    /*getCustomerList(value.id.toString());*/
  }


  void clerarfilterdTextfieldPlant() {
    textEditPlantController.clear();
    filteredplantlsit.value = plantlsit.value;
    filteredplantlsit.refresh();
  }
}
