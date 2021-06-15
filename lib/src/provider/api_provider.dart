import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/user_model.dart';

class ApiProvider {
  var _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = "http://localhost:8000/api/";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      print(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      return handler.next(e); //continue
    }));
  }

  String _handleError(error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${error.response!.statusCode}";
          break;
        default:
          errorDescription = "Not Found Method";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured, please try again ";
    }
    return errorDescription;
  }

  Future<UserModel> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("login", data: json.encode(body));
      return UserModel.fromJson(response.data);
    } catch (err, snap) {
      print(snap.toString());
      return UserModel.withError(_handleError(err));
    }
  }

  Future<UserModel> registerUser(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("register", data: json.encode(body));
      return UserModel.fromJson(response.data);
    } catch (err, snap) {
      print(snap.toString());
      return UserModel.withError(_handleError(err));
    }
  }
}
