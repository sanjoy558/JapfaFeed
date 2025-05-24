import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japfa_feed_application/controllers/dailyVisitFeedbackController.dart';
import 'package:japfa_feed_application/responses/DailyPlanResponse.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DailyVisitFeedback extends StatefulWidget {
  const DailyVisitFeedback({Key? key}) : super(key: key);

  @override
  State<DailyVisitFeedback> createState() => _DailyVisitFeedbackState();
}

class _DailyVisitFeedbackState extends State<DailyVisitFeedback> {
  final dailyVisitFeedbackController = Get.put(DailyVisitFeedbackController());

  //create array to save values
  // Create a list to store form data
  final List<dynamic> formData = [];

  /* List<Position> coordinates = [];*/

  void updateFormData(List<dynamic> newData) {
    setState(() {
      formData.clear();
      formData.addAll(newData);
    });
  }

  bool trackingActivity = false;

  // Create controllers


  //feedback text fieds




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*_initializeDatabase();

    print("form data from previous screen == ${formData.length}");

    startTracking();*/
  }

//create sql database here
  /* void _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'coordinates.db');
    _database = await openDatabase(
      path,
      version: 16, // Updated version to 2 for second table
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE coordinates(id INTEGER PRIMARY KEY, latitude REAL, longitude REAL)',
        );

        //remark table take to first column
        await db.execute('CREATE TABLE supervisor_geo_location('
            'id INTEGER PRIMARY KEY, '
            'remark TEXT, '
            'superVisorid INTEGER, '
            'visitDate TEXT, '
            'timeStamp TEXT, '
            'latitude REAL, '
            'longitude REAL, '
            'distance REAL, '
            'locationObj TEXT, '
            'operattionType TEXT, '
            'flockNumber TEXT, ' // Remove 'TEXT' from column definition
            'routeId INTEGER)');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Migration logic for database upgrades
      },
    );
  }*/

  /*Future<void> saveSupervisorLocationToDB() async {
    if (formData.isNotEmpty) {
      List<dynamic> extractedData = [];

      for (var data in formData) {
        if (data is TextEditingController) {
          extractedData.add(data.text);
        } else {
          extractedData.add(data); // For other data types, add as is
        }
      }

      try {
        for (Position pos in coordinates) {
          String jsonData =
              jsonEncode(extractedData); // Convert the list to a JSON string
          await _database.insert(
            'supervisor_geo_location',
            {
              'remark': jsonData,
              'routeId': 123,
              'superVisorid': 456,
              'visitDate': 'kj',
              'timeStamp': 'asdf',
              'locationObj': 'mj',
              'operattionType': 'dan',
              'flockNumber': 'sambhau', // Change to 'flockNumber'
              'latitude': pos.latitude, // Add latitude
              'longitude': pos.longitude, // Add longitude
            },
          );

          Fluttertoast.showToast(
              msg: "Data saved successfully to database!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          print('FormData successfully saved to supervisor_geo_location table');
          print(
              'FormData: ${jsonData.length}'); // Print the jsonData for verification
          print('formdata printed with jsondecode == ${jsonDecode(jsonData)}');
        }
      } catch (e) {
        print('Error saving form data: $e');
      }
    } else {
      print('No form data to save');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {


        alertDialog("Discard");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Text(
                'Customer Feedback',
                style: TextStyle(color: Colors.black,fontFamily: "Gilroy"),
              ),*/
              Obx(() =>  Text("DIV - ${dailyVisitFeedbackController.division_name.value}",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "Gilroy"),
              ),
              ),
            ],
          ),
          backgroundColor: primaryColor,
          elevation: 0.0,
        ),
        body:Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Customer Feedback',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orange,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),*/
                    Text(
                      'NAME',
                      style: TextStyle(color: Colors.black,fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                      child: Text(
                        '${dailyVisitFeedbackController.customer_name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                      width: double.infinity,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    /*TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),*/
                    SizedBox(height: 10.0),
                    Text(
                      'ADDRESS',
                      style: TextStyle(color: Colors.black,fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                      child: Text(
                        '${dailyVisitFeedbackController.customer_address}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                      width: double.infinity,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'MOBILE NO.',
                      style: TextStyle(color: Colors.black,fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                      child: Text(
                        '${dailyVisitFeedbackController.customer_phone}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                      width: double.infinity,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),



                    Visibility(
                      visible:false,
                      child: Column(
                        children: [
                          Text(
                            'STATUS',
                            style: TextStyle(color: Colors.black,fontFamily: 'Gilroy'),
                          ),
                          Obx(() => Row(
                            children: [
                              Radio(
                                value: 'seller',
                                groupValue: dailyVisitFeedbackController.selectedStatus.value,
                                onChanged: (value) {
                                  dailyVisitFeedbackController.selectedStatus.value = value.toString();
                                },
                                activeColor: Colors.green,
                              ),
                              Text('Seller', style: TextStyle(color: Colors.black)),
                              Radio(
                                value: 'user',
                                groupValue: dailyVisitFeedbackController.selectedStatus.value,
                                onChanged: (value) {
                                  dailyVisitFeedbackController.selectedStatus.value = value.toString();
                                },
                                activeColor: Colors.green,
                              ),
                              Text('User', style: TextStyle(color: Colors.black)),
                              Radio(
                                value: 'seller user',
                                groupValue: dailyVisitFeedbackController.selectedStatus.value,
                                onChanged: (value) {
                                  dailyVisitFeedbackController.selectedStatus.value = value.toString();
                                },
                                activeColor: Colors.green,
                              ),
                              Text('Seller User', style: TextStyle(color: Colors.black)),
                            ],
                          ),),
                          SizedBox(height: 10.0),
                          Text(
                            'DATE',
                            style: TextStyle(color: Colors.orange),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                            child: Text(
                              '${dailyVisitFeedbackController.customer_todays_date}',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.0,
                            width: double.infinity,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '1. Feed Quality To The Poultry Feed Production',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue1.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue1.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller:dailyVisitFeedbackController.contr1,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // set 2. number contaoiner

                          SizedBox(height: 20.0),

                          Text(
                            '2. Feed Price',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue2.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue2.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr2,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '3. Availibility Of Feed',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue3.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue3.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller:dailyVisitFeedbackController.contr3,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '4. On Time Delivery',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue4.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue4.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr4,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '5. Terms Of Payment',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue5.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue5.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr5,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '6. Technical Service For Poultry Feed Production',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue6.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue6.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr6,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '7. Promotion Program',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue7.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue7.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr7,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '8. Customer Visit To Factory',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue8.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue8.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr8,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '9. Image Of JCIPL And Its Product',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue9.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue9.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr9,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            '10. Good Relation Between Organization & Customer',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Satisfaction',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: dailyVisitFeedbackController.selectedDropdownValue10.value,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24.0,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          onChanged: (int? newValue) {
                                            dailyVisitFeedbackController.selectedDropdownValue10.value = newValue!;
                                          },
                                          items: List.generate(
                                            11,
                                                (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text('$index'),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // Set the desired grey color
                                    ),
                                    child: TextField(
                                      controller: dailyVisitFeedbackController.contr10,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Feedback',
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),

                          Text(
                            'What do you consider while choosing of JCIPL?',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 15.0),

                          Obx(() => Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: dailyVisitFeedbackController.priceSelected.value,
                                    onChanged: (newValue) {
                                      dailyVisitFeedbackController.priceSelected.value = newValue!;
                                    },
                                  ),
                                  SizedBox(width: 5), // Add spacing between checkbox and text
                                  Text('Price'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: dailyVisitFeedbackController.qualitySelected.value,
                                    onChanged: (newValue) {
                                      dailyVisitFeedbackController.qualitySelected.value = newValue!;
                                    },
                                  ),
                                  SizedBox(width: 5), // Add spacing between checkbox and text
                                  Text('Quality'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: dailyVisitFeedbackController.serviceSelected.value,
                                    onChanged: (newValue) {

                                      dailyVisitFeedbackController.serviceSelected.value = newValue!;
                                    },
                                  ),
                                  SizedBox(width: 5), // Add spacing between checkbox and text
                                  Text('Service'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: dailyVisitFeedbackController.otherSelected.value,
                                    onChanged: (newValue) {

                                      dailyVisitFeedbackController.otherSelected.value = newValue!;
                                    },
                                  ),
                                  SizedBox(width: 5), // Add spacing between checkbox and text
                                  Text('Other'),
                                ],
                              ),
                            ],
                          ),),



                          SizedBox(height: 20.0),
                        ],
                      ),),









                    Text(
                      'Comment, Complaint,Compliment or Other.',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                          fontFamily: 'Gilroy'
                      ),
                    ),
                    SizedBox(height: 5.0),

                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5.0,right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Set the desired grey color
                            ),
                            child: TextField(
                              controller: dailyVisitFeedbackController.contr11,
                              decoration: InputDecoration(
                                hintText: 'Enter Here',
                                border: InputBorder.none,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Change to spaceBetween or spaceAround
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                              dailyVisitFeedbackController.getallVisitFeedback();
                              // Add functionality for CANCEL button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('CANCEL',style: TextStyle(fontFamily: 'Gilroy'),),
                          ),
                        ),
                        SizedBox(width: 10), // Adding space between buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                              dailyVisitFeedbackController.addData();
                              print(DateTime.now());
                              getDate();
                              /*stopTracking();*/

                              /*Map<String, dynamic> formDataMap = {
                            'status': _selectedStatus,
                            'name': nameController.text,
                            'address': addressController.text,
                            'mobile': mobileController.text,
                            'date': dateController.text,

                            'feedQuality': {
                              'satisfaction': _selectedDropdownValue1,
                              'feedback': contr1.text,
                            },
                            'feedPrice': {
                              'satisfaction2': _selectedDropdownValue2,
                              'feedback2': contr2.text,
                            },
                            'feedAvaibility': {
                              'satisfaction3': _selectedDropdownValue3,
                              'feedback3': contr3.text,
                            },
                            'OnTimeDelivery': {
                              'satisfaction4': _selectedDropdownValue4,
                              'feedback4': contr4.text,
                            },
                            'TermOfPayment': {
                              'satisfaction5': _selectedDropdownValue5,
                              'feedback5': contr5.text,
                            },
                            'ServicesTechnically': {
                              'satisfaction6': _selectedDropdownValue6,
                              'feedback6': contr6.text,
                            },
                            'PromotionProgramm': {
                              'satisfaction7': _selectedDropdownValue7,
                              'feedback7': contr7.text,
                            },
                            'CustomerVisit': {
                              'satisfaction8': _selectedDropdownValue8,
                              'feedback8': contr8.text,
                            },
                            'ImagesofJCIPL': {
                              'satisfaction9': _selectedDropdownValue9,
                              'feedback9': contr9.text,
                            },
                            'Relation': {
                              'satisfaction10': _selectedDropdownValue10,
                              'feedback10': contr10.text,
                            },

                            'other feedback11': contr11.text,

                            'choosingCriteria': {
                              'price': priceSelected,
                              'quality': qualitySelected,
                              'service': serviceSelected,
                              'other': otherSelected,
                            },
                            // Add other sections similarly
                          };*/

                              /* print("Structured FormData: $formDataMap");
                          formData.add(formDataMap);

                          saveSupervisorLocationToDB();*/
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: startjourneyGradient1,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('SAVE',style: TextStyle(fontFamily: 'Gilroy'),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _displayProgress()
          ],
        ) ,
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => dailyVisitFeedbackController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }

  /*void startTracking() {
    setState(() {
      trackingActivity = true;
    });

    const duration = Duration(seconds: 4);
    Timer.periodic(duration, (Timer t) async {
      if (!trackingActivity) {
        t.cancel();
      } else {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          if (coordinates.isNotEmpty) {
            double distanceInMeters = Geolocator.distanceBetween(
              coordinates.last.latitude,
              coordinates.last.longitude,
              position.latitude,
              position.longitude,
            );
            //totalDistance += distanceInMeters / 1000; // Converting to km
          }
          coordinates.add(position);
        });
      }
    });
  }

  void stopTracking() {
    setState(() {
      trackingActivity = false;
    });
  }*/

  String getDate() {
    print(dailyVisitFeedbackController.selectedStatus);
    DateTime now = DateTime.now();
    var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String todays_date = formatter.format(now);
    //todays_date
    print("todyas date is : ${todays_date}");
    return todays_date;
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
                        style: TextStyle(fontFamily: 'Gilroy'),
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
                                Get.back();

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
