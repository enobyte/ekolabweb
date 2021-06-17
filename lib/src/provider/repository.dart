import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<UserModel> actLogin(Map<String, dynamic> body) =>
      apiProvider.loginUser(body);

  Future<UserModel> actRegister(Map<String, dynamic> body) =>
      apiProvider.registerUser(body);

  Future<UserMultipleModel> actGetAllUser(Map<String, dynamic> body) =>
      apiProvider.getAllUser(body);

  Future<FileModel> actUploadFile(FormData formData) =>
      apiProvider.uploadGeneralFile(formData);

  Future<UserModel> updateUser(Map<String, dynamic> body) =>
      apiProvider.updateUser(body);

  Future<ProductModel> getProduct(Map<String, dynamic> body) =>
      apiProvider.getProduct(body);

  Future<ProductModel> createProduct(Map<String, dynamic> body) =>
      apiProvider.createProduct(body);

  Future<ProductModel> submissionProduct(Map<String, dynamic> body) =>
      apiProvider.submissionProduct(body);

  Future<ProductModel> getSubmissionProduct(Map<String, dynamic> body) =>
      apiProvider.getSubmissionProduct(body);
}
