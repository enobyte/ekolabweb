import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/standard_map_model.dart';
import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/model/submisson_proc_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';

class ApiProvider {
  var _dio = Dio();
  var _dioFile = Dio();

  ApiProvider() {
    //_dio.options.baseUrl = "http://ekolab.id:8080/api/";
    _dio.options.baseUrl = "http://localhost:8080/api/";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;

    _dioFile.options.baseUrl = "http://ekolab.id:8080/api/";
    _dioFile.options.connectTimeout = 5000; //5s
    _dioFile.options.receiveTimeout = 3000;
    _dioFile.options.contentType = Headers.formUrlEncodedContentType;

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST[${options.method}] => BODY: ${options.data}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(
          'RESPONSE: ${response.data} => PATH: ${response.requestOptions.path}');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      print(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      return handler.next(e); //continue
    }));

    _dioFile.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) {
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

  Future<UserMultipleModel> getAllUser(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("get_user", data: json.encode(body));
      return UserMultipleModel.fromJson(response.data);
    } catch (err, snap) {
      print(snap.toString());
      return UserMultipleModel.withError(_handleError(err));
    }
  }

  Future<UserMultipleModel> getUserByKind(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("get_user_by_kind", data: json.encode(body));
      return UserMultipleModel.fromJson(response.data);
    } catch (err, snap) {
      print(snap.toString());
      return UserMultipleModel.withError(_handleError(err));
    }
  }

  Future<FileModel> uploadGeneralFile(FormData formData) async {
    try {
      final response = await _dioFile.post(
        'upload_file',
        data: formData,
        onSendProgress: (int sent, int total) {
          print("progress >>> " +
              ((sent / total) * 100).floor().toString() +
              "%");
        },
      );
      return FileModel.fromJson(response.data);
    } catch (error, stack) {
      return FileModel.withError(_handleError(error));
    }
  }

  Future<UserModel> updateUser(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("update_user", data: json.encode(body));
      return UserModel.fromJson(response.data);
    } catch (err, snap) {
      return UserModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> getProduct(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("get_product", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> getProductByName(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("get_product_by_name", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> createProduct(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("create_product", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> delProduct(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("del_product", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> submissionProduct(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("submission_req", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<ProductModel> submissionProcess(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("submission_proc", data: json.encode(body));
      return ProductModel.fromJson(response.data);
    } catch (err, snap) {
      return ProductModel.withError(_handleError(err));
    }
  }

  Future<SubmissionModel> getSubmissionProduct(
      Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("get_sub_req", data: json.encode(body));
      return SubmissionModel.fromJson(response.data);
    } catch (err, snap) {
      return SubmissionModel.withError(_handleError(err));
    }
  }

  Future<SubmissionModel> getAllSubmissionProduct() async {
    try {
      final response = await _dio.post("get_sub_alll");
      return SubmissionModel.fromJson(response.data);
    } catch (err, snap) {
      return SubmissionModel.withError(_handleError(err));
    }
  }

  Future<SubmissionProcModel> getSubmissionProcess(
      Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("get_sub_proc", data: json.encode(body));
      return SubmissionProcModel.fromJson(response.data);
    } catch (err, snap) {
      return SubmissionProcModel.withError(_handleError(err));
    }
  }

  Future<StandardMapListModels> getChating(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("get_chating", data: json.encode(body));
      return StandardMapListModels.fromJson(response.data);
    } catch (err, snap) {
      return StandardMapListModels.withError(_handleError(err));
    }
  }

  Future<StandardMapListModels> getChatingList(
      Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("get_chating_list", data: json.encode(body));
      return StandardMapListModels.fromJson(response.data);
    } catch (err, snap) {
      return StandardMapListModels.withError(_handleError(err));
    }
  }

  Future<StandardMapListModels> saveChating(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("save_chating", data: json.encode(body));
      return StandardMapListModels.fromJson(response.data);
    } catch (err, snap) {
      return StandardMapListModels.withError(_handleError(err));
    }
  }

  Future<StandardMapListModels> preForgotPass(Map<String, dynamic> body) async {
    try {
      final response =
          await _dio.post("pre_forgot_pass", data: json.encode(body));
      return StandardMapListModels.fromJson(response.data);
    } catch (err, snap) {
      return StandardMapListModels.withError(_handleError(err));
    }
  }

  Future<StandardMapListModels> actionForgotPass(
      Map<String, dynamic> body) async {
    try {
      final response = await _dio.post("forgot_pass", data: json.encode(body));
      return StandardMapListModels.fromJson(response.data);
    } catch (err, snap) {
      return StandardMapListModels.withError(_handleError(err));
    }
  }
}
