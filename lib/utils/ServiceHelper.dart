import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/controllers/dashboardController.dart';
import 'package:japfa_feed_application/controllers/homeController.dart';
import 'package:japfa_feed_application/hive/localdatabase.dart';
import 'package:japfa_feed_application/hive/pointsTravelledString.dart';

import 'package:japfa_feed_application/utils/MainPresenter.dart';
import 'package:japfa_feed_application/utils/SharePrefHelper.dart';
import 'package:workmanager/workmanager.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class ServiceHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static StreamSubscription<Position>? positionStreamSubscription;

  static int positionCount = 0;
  static var totalDistance = 0.0.obs;
  static var distanceInMeters = 0.0.obs;
  static Position? firstPosition;
  static String purchase_uuid = "";
  static String userId="";
  static final dashboardController = Get.put(DashboardController());
  static final homeController = Get.put(HomeController());

    static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      print("Background task executed: $task");
      return Future.value(true);
    });
  }

  static Future<void> startService() async {

    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (!isRunning) {
      service.startService();
    }
  }

  static Future<void> stopService() async {
    final service = FlutterBackgroundService();
    service.invoke("stopService");

    if(await SharePrefsHelper.getBool(
        SharePrefsHelper.USER_START_JOURNEY_FLAG)){
      dashboardController.endJourney();
    }

  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

   /* service.on('stopService').listen((event) {
      service.stopSelf();
    });
*/
    service.on('stopService').listen((event) {
      positionStreamSubscription?.cancel();
      flutterLocalNotificationsPlugin.cancelAll();
      service.stopSelf();
    });

    positionStreamSubscription =Geolocator.getPositionStream().listen((position) async {
      String formattedDateTime = DateFormat('dd-MM-yy HH:mm:ss').format(DateTime.now());
      flutterLocalNotificationsPlugin.show(
        0,
        'Tracking Location',
        "Lat: ${position.latitude.toString()} Long: ${position.longitude.toString()}",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "notificationChannelId",
            'Location Service',
            channelDescription: "",
            playSound: false,
            enableVibration: false,
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );

      positionCount++;

      if (positionCount == 1) {
        // Save the first position
        firstPosition = position;
      } else if (positionCount == 5) {
        // Check the distance for the 10th position
        if (firstPosition != null) {
          distanceInMeters.value = Geolocator.distanceBetween(
            firstPosition!.latitude,
            firstPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          if (distanceInMeters > 5) {
            totalDistance.value +=
                distanceInMeters.value / 1000; // Converting to km
            String inString = totalDistance.toStringAsFixed(2);
            homeController.total_km.value = double.parse(inString);
            SharePrefsHelper.setDouble(SharePrefsHelper.TOTAL_KM, homeController.total_km.value);

            purchase_uuid =
            await SharePrefsHelper.getString(SharePrefsHelper.PURCHASE_ORDER_UUDI);
            //userId = MainPresenter.getInstance().userModel.userId!;

            await LocalDataBase.instance!.insertPointsVisited(
                todo: PointsTravelledString(
                    distance: double.parse(inString),
                    latitude: position.latitude,
                    longitude: position.longitude,
                    operationType: "ROUTE",
                    remark: "",
                    routeId: purchase_uuid.toString(),
                    superVisorId: dashboardController.userId,
                    timeStamp: MainPresenter.getInstance().getTimeStamp(),
                    visitDate: MainPresenter.getInstance()
                        .getPaternWiseDate("yyyy-MM-dd'T'HH:mm:ss")));
          }
        }
        // Reset the counter for the next cycle
        positionCount = 0;
    }});
  }
}
