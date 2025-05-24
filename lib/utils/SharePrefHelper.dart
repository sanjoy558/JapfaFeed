import 'dart:async';
import 'dart:convert';
import 'package:japfa_feed_application/controllers/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsHelper {
  static const String USER_MODEL = "USER_MODEL";
  static const String USER_TYPE = "USER_TYPE";
  static const String USER_START_JOURNEY_FLAG = "start_journey_flag";
  static const String USER_START_JOURNEY_TYPE = "start_journey_type";
  static const String USER_ID = "USER_ID";
  static const String DARK_MODE = "DARK_MODE";
  static const String CART_COUNT = "CART_COUNT";
  static const String CART_DETAILS = "CART_DETAILS";
  static const String MAP_ADDRESS = "MAP_ADDRESS";
  static const String MAP_ADDRESS_LAT_LNG = "MAP_ADDRESS_LAT_LNG";
  static const String MAP_LATITUDE = "LATITUDE";
  static const String MAP_LONGITUDE = "LONGITUDE";
  static const String ONBOARDING_FLAG = "ONBOARDING_FLAG";

  static const String VISIT_DATE = "visit_date";
  static const String VISIT_VEHICLE_NUMBER = "visit_vehicle_number";
  static const String VISIT_OPENING_KM = "visit_opening_km";
  static const String VISIT_REMARK = "visit_remark";
  static const String VISIT_ENDING_KM = "visit_ending_km";
  static const String VISIT_START_TIME = "visit_start_time";
  static const String VISIT_ROUTE_ID = "visit_route_id";
  static const String TOTAL_KM = "total_km";
  static const String PURCHASE_ORDER_UUDI = "purchaseorder_uuid";
  static const String DIVISION_TYPE = "division_type";
  static const String DIVISION_ID = "division_id";
  static const String PUNCHINN_TIME = "punchinn_time";
  static const String PUNCHOUT_TIME = "punchout_time";



  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  static Future<void> clearAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
  static Future<void> clearOne(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static Future<UserModel> getUserModel() async {
    String jsonString = "";
    UserModel userModel = UserModel();
    try {
      jsonString = await getString(USER_MODEL);

      if (jsonString.isEmpty) {
        return UserModel();
      }
      var model = jsonDecode(jsonString);
      userModel = UserModel.fromJson(model);
    } catch (e) {
      return UserModel();
    }
    return userModel;
  }

  static Future<void> saveUserModel(UserModel userModel) async {
    try {
      String jsonString = jsonEncode(userModel.toJson());
      setString(USER_MODEL, jsonString);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> saveUserLocation(String latitude,String longitude) async {
    try {
      setString(MAP_LATITUDE, latitude);
      setString(MAP_LONGITUDE, longitude);
    } catch (e) {
      print(e);
    }
  }

  /*static Future<void> saveCartDetails(List<CartModel> cartList) async {
    try {
      String jsonString = jsonEncode(cartList);
      setString(CART_DETAILS, jsonString);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<CartModel>> getCartDetails() async {
    String jsonString = "";
    List<CartModel> list = List<CartModel>.empty();
    try {
      jsonString = await getString(CART_DETAILS);
      if (jsonString.isEmpty) {
        return List<CartModel>.empty();
      }
      var data = jsonDecode(jsonString) as List;
      list = data.map((e) => CartModel.fromJson(e)).toList();
      print(list);
    } catch (e) {
      print(e);
      return List<CartModel>.empty();
    }
    return list;
  }*/
}
