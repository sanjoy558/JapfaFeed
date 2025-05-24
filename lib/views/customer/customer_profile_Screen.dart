import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/customer_controller/customerProfileController.dart';
import 'package:japfa_feed_application/controllers/profileController.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:japfa_feed_application/utils/Constants.dart';

class CustomerProfileScreen extends StatefulWidget {
  @override
  State<CustomerProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<CustomerProfileScreen> {
  final profileController = Get.put(CustomerProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Hi ${profileController.firstname}!",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/hand_gif.gif',
                            width: 25.0,
                            height: 25.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                profileController.logout();
              },
              child: Row(
                children: [
                  Text(
                    "Logout",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.logout,
                      color: startjourneyGradient1,
                      size: 25,
                    ),
                  ),
                ],
              ),
            )
          ],
        ), // Spacing between rows
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0, left: 50.0),
            // Set your margin here
            child: LayoutBuilder(
              builder: (context, constraints) {
                double remainingHeight = constraints.maxHeight;
                double cardWidth =
                    constraints.maxWidth; // Use LayoutBuilder's constraints
                return Container(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: remainingHeight / 3.5,
                            // Quarter of remaining height
                            width: cardWidth,
                            decoration: BoxDecoration(
                                color: startjourneyGradient2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5, // Bottom shadow
                                  ),
                                  // Shadow for the right side
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(4, 0), // Right shadow
                                  ),
                                  // Shadow for the left side
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(-4, 0), // Left shadow
                                  ),
                                ]),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 50.0),
                                    child: Text(
                                      "JAPFA",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25.0),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: cardWidth,
                            height: remainingHeight / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5, // Bottom shadow
                                ),
                                // Shadow for the right side
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(4, 0), // Right shadow
                                ),
                                // Shadow for the left side
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(-4, 0), // Left shadow
                                ),
                              ],
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        top: remainingHeight / 3.5 - 100,left: 10.0,right: 10.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "${profileController.firstname}",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  Container(
                                    child: Text(
                                      "ID - #${profileController.login}",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: remainingHeight / 3.5 - 60,
                        // Vertically center
                        left: cardWidth / 2 - 60,
                        // Horizontally center within the card
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/profile1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayProgress() {
    return Obx(() => profileController.displayLoading.value == true
        ? Center(child: progressBarCommon())
        : Container());
  }
}
//https://stackoverflow.com/questions/76373048/how-can-i-create-a-flutter-ui-design-with-a-profile-picture-that-looks-like-this
