import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/standard_map_model.dart';
import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/model/submisson_proc_model.dart';
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

  Future<UserMultipleModel> actGetUserByKind(Map<String, dynamic> body) =>
      apiProvider.getUserByKind(body);

  Future<FileModel> actUploadFile(FormData formData) =>
      apiProvider.uploadGeneralFile(formData);

  Future<UserModel> updateUser(Map<String, dynamic> body) =>
      apiProvider.updateUser(body);

  Future<ProductModel> getProduct(Map<String, dynamic> body) =>
      apiProvider.getProduct(body);

  Future<ProductModel> getProductByName(Map<String, dynamic> body) =>
      apiProvider.getProductByName(body);

  Future<ProductModel> createProduct(Map<String, dynamic> body) =>
      apiProvider.createProduct(body);

  Future<ProductModel> delProduct(Map<String, dynamic> body) =>
      apiProvider.delProduct(body);

  Future<ProductModel> submissionProduct(Map<String, dynamic> body) =>
      apiProvider.submissionProduct(body);

  Future<ProductModel> submissionProc(Map<String, dynamic> body) =>
      apiProvider.submissionProcess(body);

  Future<SubmissionModel> getSubmissionProduct(Map<String, dynamic> body) =>
      apiProvider.getSubmissionProduct(body);

  Future<SubmissionModel> getAllSubmissionProduct() =>
      apiProvider.getAllSubmissionProduct();

  Future<SubmissionProcModel> getSubmissionProcess(Map<String, dynamic> body) =>
      apiProvider.getSubmissionProcess(body);

  Future<StandardMapListModels> getChating(Map<String, dynamic> body) =>
      apiProvider.getChating(body);

  Future<StandardMapListModels> getChatingList(Map<String, dynamic> body) =>
      apiProvider.getChatingList(body);

  Future<StandardMapListModels> saveChating(Map<String, dynamic> body) =>
      apiProvider.saveChating(body);

  Future<StandardMapListModels> preForgotPass(Map<String, dynamic> body) =>
      apiProvider.preForgotPass(body);

  Future<StandardMapListModels> actionForgotPass(Map<String, dynamic> body) =>
      apiProvider.actionForgotPass(body);
}
