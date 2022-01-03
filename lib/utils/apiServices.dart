import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:musicroom/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

class ApiBaseHelper {
  // final String _baseUrl = "http://127.0.0.1:8000/api";
  final String _baseUrl = "https://musicroomweb.herokuapp.com/api";
  String get baseurl => _baseUrl;
  BuildContext? context;


  Future<dynamic> get(String url) async {
    String? FCMdeviceId = await FirebaseMessaging.instance.getToken();
    print('Api Get, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String deviceId= await getDeviceId();


    try {
      Map<String, String> headers = {"Content-Type": "application/json",};
      if (token != null && token.isNotEmpty){
        headers.addAll(
            {
              HttpHeaders.authorizationHeader:
              'Token $token',
            }
        );
      } else {
        headers.addAll({
          "guest" : deviceId
        });
      }
      headers.addAll({"fcm-device-id":FCMdeviceId ?? ''});

      final response = await http.get(
        Uri.parse(_baseUrl + url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get received!');
    print('response get $responseJson');
    return responseJson;
  }


  Future<dynamic> post(String url, Map<String, dynamic> data,
      {BuildContext? context}) async {
    String? FCMdeviceId = await FirebaseMessaging.instance.getToken();

    if (context != null){
      this.context = context;
    }
    print('Api Post, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String deviceId= await getDeviceId();


    try {
      Map<String, String> headers = {"Content-Type": "application/json",};
      if (token != null && token.isNotEmpty){
        headers.addAll(
            {
              HttpHeaders.authorizationHeader:
              'Token $token',
            }
        );
      } else {

        headers.addAll({
          "guest" : deviceId
        });
      }
      headers.addAll({"fcm-device-id":FCMdeviceId ?? ''});

      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: headers,
          body: json.encode(data));

      print("response is ${response.body}");


      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');

      throw FetchDataException('No Internet connection');
    }
    print('api post received!');
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, dynamic> data, {bool returnHttpResponse=false}) async {
    print('Api Put, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String deviceId= await getDeviceId();
    String? FCMdeviceId = await FirebaseMessaging.instance.getToken();



    try {
      Map<String, String> headers = {"Content-Type": "application/json",};
      if (token != null && token.isNotEmpty){
        headers.addAll(
            {
              HttpHeaders.authorizationHeader:
              'Token $token',
            }
        );
      } else {
        headers.addAll({
          "guest" : deviceId
        });
      }
      headers.addAll({"fcm-device-id":FCMdeviceId ?? ''});
      print(data);
      final response = await http.put(Uri.parse(_baseUrl + url),
          headers: headers,
          body: json.encode(data));

      if(returnHttpResponse){
        return response;
      }
      print("response is ${response.body}");


      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post received!');
    return responseJson;
  }
  Future<dynamic> patch(String url, Map<String, dynamic>? data) async {

    print('Api Post, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String deviceId= await getDeviceId();
    String? FCMdeviceId = await FirebaseMessaging.instance.getToken();


    try {
      Map<String, String> headers = {"Content-Type": "application/json",};
      if (token != null && token.isNotEmpty){
        headers.addAll(
            {
              HttpHeaders.authorizationHeader:
              'Token $token',
            }
        );
      } else {
        headers.addAll({
          "guest" : deviceId
        });
      }

      headers.addAll({"fcm-device-id":FCMdeviceId ?? ''});
      final response = await http.patch(Uri.parse(_baseUrl + url),
          headers: headers,
          body: json.encode(data));

      print("response is ${response.body}");


      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post received!');
    return responseJson;
  }
  Future<dynamic> delete(String url, Map<String, dynamic>? data) async {

    print('Api Post, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String deviceId= await getDeviceId();
    String? FCMdeviceId = await FirebaseMessaging.instance.getToken();


    try {
      Map<String, String> headers = {"Content-Type": "application/json",};
      if (token != null && token.isNotEmpty){
        headers.addAll(
            {
              HttpHeaders.authorizationHeader:
              'Token $token',
            }
        );
      } else {
        headers.addAll({
          "guest" : deviceId
        });
      }
      String? FCMdeviceId = await FirebaseMessaging.instance.getToken();
      headers.addAll({"fcm-device-id":FCMdeviceId ?? ''});
      final response = await http.delete(Uri.parse(_baseUrl + url),
          headers: headers,
          body: json.encode(data));

      print("response is ${response.body}");


      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post received!');
    return responseJson;
  }
  void displayMessage(String message){
    if (this.context != null){
      ScaffoldMessenger.of(
          this.context!)
          .showSnackBar(
            SnackBar(
            content: Text(
              '$message',
              textAlign: TextAlign
                  .center,
            ),
            backgroundColor:
            Colors.red,
          )
      );
    }
  }
  dynamic _returnResponse(http.Response response) {
    print("status is ${response.statusCode}");
    if (response.statusCode >= 400  &&  response.statusCode <= 511){
      print("it falls in line");
      displayMessage('${response.body.toString()}');
    }
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
         throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      displayMessage('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
