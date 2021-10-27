import 'dart:convert';

import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _doLogin = PublishSubject<UserModel>();
  final _updateUser = PublishSubject<UserModel>();
  final _doRegister = PublishSubject<UserModel>();
  final _doGetAllUser = BehaviorSubject<UserMultipleModel>();

  Stream<UserModel> get doLogin => _doLogin.stream;

  Stream<UserModel> get updateUser => _updateUser.stream;

  Stream<UserModel> get doRegister => _doRegister.stream;

  Stream<UserMultipleModel> get doGetAllUser => _doGetAllUser.stream;

  fetchLogin(Map<String, dynamic> body) async {
    UserModel model = await _repository.actLogin(body);
    if (model.status ?? false) {
      await SharedPreferencesHelper.setStringPref(
          SharedPreferencesHelper.user, json.encode(model.toJson()));
    }
    _doLogin.sink.add(model);
  }

  fetchRegister(Map<String, dynamic> body) async {
    UserModel model = await _repository.actRegister(body);
    _doRegister.sink.add(model);
  }

  fetchAllUser(Map<String, dynamic> body) async {
    UserMultipleModel model = await _repository.actGetAllUser(body);
    _doGetAllUser.sink.add(model);
  }

  Future<UserMultipleModel> fetchUserByKind(Map<String, dynamic> body) async {
    UserMultipleModel model = await _repository.actGetUserByKind(body);
    return model;
  }

  updateProfile(Map<String, dynamic> body) async {
    UserModel model = await _repository.updateUser(body);
    if (model.status ?? false) {
      await SharedPreferencesHelper.setStringPref(
          SharedPreferencesHelper.user, json.encode(model.toJson()));
    }
    _updateUser.sink.add(model);
  }

  Future<StandardMapListModels> preForgotPass(Map<String, dynamic> body) async {
    StandardMapListModels model = await _repository.preForgotPass(body);
    return model;
  }

  Future<StandardMapListModels> actionForgotPass(
      Map<String, dynamic> body) async {
    StandardMapListModels model = await _repository.actionForgotPass(body);
    return model;
  }

  Future<StandardMapListModels> actionChangePass(
      Map<String, dynamic> body) async {
    StandardMapListModels model = await _repository.actionChangePass(body);
    return model;
  }

  dispose() {
    _doRegister.close();
    _doGetAllUser.close();
    _updateUser.close();
  }

  disposeLogin() {
    _doLogin.close();
  }
}

final bloc = UserBloc();
