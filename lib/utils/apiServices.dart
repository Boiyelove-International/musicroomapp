import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
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
  final String _baseUrl = "http://127.0.0.1:8000/api";
  // final String _baseUrl = "https://musicroomweb.herokuapp.com/api";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3R1c2VyQGJvaXllbG92ZS53ZWJzaXRlIiwibmFtZWlkIjoiNjE2MWQ0ZjYwMDYxNjdkYTNiM2E0YmJhIiwicm9sZSI6IkFkbWluIiwibmJmIjoxNjMzODAxNDYyLCJleHAiOjE2NTIxMTgyNjIsImlhdCI6MTYzMzgwMTQ2Mn0.hXatLjuc0puyFXar_Czu0-tLF2gweOGals0bNOfF8tg',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get received!');
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    print('Api Post, url $url');
    var responseJson;
    SharedPreferences pref  = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader:
                'Token $token',
          },
          body: json.encode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post received!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
