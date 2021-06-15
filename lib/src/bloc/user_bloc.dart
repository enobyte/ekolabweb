import 'dart:convert';

import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = Repository();
  final _doLogin = PublishSubject<UserModel>();
  final _doRegister = PublishSubject<UserModel>();

  Stream<UserModel> get doLogin => _doLogin.stream;

  Stream<UserModel> get doRegister => _doRegister.stream;

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

  dispose() {
    _doLogin.close();
    _doRegister.close();
  }
}
