/*import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';*/
import 'package:flutter/foundation.dart';

class NotificationAwesomeHelper {

  /*static createNotification(RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          //simple notification
          id: 12324,
          channelKey: 'basic',
          //set configuration with key "basic"
          title: message.notification!.title,
          bigPicture:
              'https://bhajiwala.getallmed.com/new/assets/img/fav.png',
          fullScreenIntent: true,
          body: message.notification!.body,
          payload: {"name": "FlutterCampus"},
          autoDismissible: false,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "Read",
            label: "Read",
          ),
        ]);
  }*/



  static void initialize() {


    /*FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      if (kDebugMode) {
        print("Token : " + token.toString());
      }
    });
    AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
      ),
    ]);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      createNotification(message);
    });*/

    // awesomeNotifications.actionStream.asBroadcastStream().listen((action) {
    //   if (action.buttonKeyPressed == "open") {
    //     print("Open button is pressed");
    //   } else if (action.buttonKeyPressed == "delete") {
    //     print("Delete button is pressed.");
    //   } else {
    //     print(action.payload); //notification was pressed
    //   }
    // });
  }

  // static void showNotification(RemoteMessage message) {
  //   AwesomeNotifications().initialize('resource://mipmap/ic_launcher', [
  //     // notification icon
  //     NotificationChannel(
  //       channelGroupKey: 'basic_test',
  //       channelKey: 'basic',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       channelShowBadge: true,
  //       importance: NotificationImportance.High,
  //       enableVibration: true,
  //     ),
  //   ]);
  // }
}
