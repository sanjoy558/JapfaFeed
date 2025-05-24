import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:japfa_feed_application/utils/MainPresenter.dart';
import '../utils/Constants.dart';

class ApiService {
  Future<Object> executeGET(
      String endPoint, Map<String, dynamic> paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    var newURI;
    if (paramsMaps == null) {
      newURI = uri;
    } else {
      newURI = uri.replace(queryParameters: paramsMaps);
    }
    final response = await http.get(newURI);
    return response;
  }

  Future<Object> executeGET1(
      String endPoint) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response?> executeGET12(String endPoint) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Request was successful, return the response.
        return response;
      } else {
        // Handle other status codes (e.g., display an error message).
        print("Request failed with status: ${response.statusCode}");
        return null; // or throw an exception
      }
    } catch (error) {
      // Handle network or other errors.
      print("Error during request: $error");
      return null; // or throw an exception
    }
  }

  Future<http.Response> executeWithBearerTokenGET1(
      String endPoint, Map<String, dynamic> paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    var newURI;
    if (paramsMaps == null) {
      newURI = uri;
    } else {
      newURI = uri.replace(queryParameters: paramsMaps);
    }
    final response = await http.get(newURI);
    return response;
  }

//implemented
  Future<http.Response> executeWithBearerTokenGET(
      String endPoint, String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    print("url is  : ${uri.toString()}");
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('Token : ${token}');
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }
  //implemented
  Future<http.Response> executeGet(String endPoint) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    print("url is  : ${uri.toString()}");
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }
//implemented
  Future<http.Response> executeWithBearerTokenGETAndParam(
      String endPoint, String token,Map<String, dynamic> paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    final response = await http.get(uri.replace(queryParameters: paramsMaps), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('Token : ${token}');
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  Future<http.Response> executePostWithBearerTokenAndRawData(
      String endPoint, String token, String paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    var encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: paramsMaps,
        encoding: encoding);
    print('Token : ${token}');
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  Future<http.Response> executePOST(
      String endPoint, Map<String, dynamic> paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    /* MainPresenter.getInstance().printLog("Token", API_TOKEN);*/
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  //implemented
  Future<http.Response> executeRawPOST(
      String endPoint, String paramsMaps) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  Future<http.Response> executeRawPOSTCustomerForm(
      String endPoint, String paramsMaps,String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    log(paramsMaps);
    return response;
  }

  //feedbackpost
  Future<http.Response> executeRawPOSTCustomerForm1(
  //https://stackoverflow.com/questions/67769074/how-to-send-an-array-in-http-post-request-body
      String endPoint, List paramsMaps,String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: [], encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    log(paramsMaps.toString());
    return response;
  }

  Future<http.Response> executeRawPOSTWithToken(
      String endPoint,String paramsMaps,String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  Future<http.Response> executeRawPOST1(
      String endPoint, String paramsMaps, String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.post(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

  Future<http.Response> executeRawPut(
      String endPoint, String paramsMaps, String token) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var encoding = Encoding.getByName('utf-8');
    var response = await http.put(uri,
        headers: headers, body: paramsMaps, encoding: encoding);
    MainPresenter.getInstance().printLog("EndPoint", uri);
    MainPresenter.getInstance().printLog("Parameters", paramsMaps);
    MainPresenter.getInstance().printLog("Response", response.body);
    return response;
  }

/*Future<http.Response> executeMultiPart(
      String endPoint, MediaModel mediaModel, String buyerId) async {
    Uri uri = Uri.parse(BASE_URL + endPoint);
    var request = http.MultipartRequest('POST', uri);
    request.fields['seller_id'] = buyerId;
    request.fields['document_type'] = mediaModel.documentType!;
    request.fields['image_name'] = mediaModel.title!;
    request.fields['user_type'] = mediaModel.userType!;
    request.files
        .add(await http.MultipartFile.fromPath('file', mediaModel.mediaUrl!));
    var streamResponse = await request.send();
    var response = await http.Response.fromStream(streamResponse);
    return response;
  }*/
}
