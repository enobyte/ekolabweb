import 'package:ekolabweb/src/model/user_model.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<UserModel> actLogin(Map<String, dynamic> body) =>
      apiProvider.loginUser(body);

  Future<UserModel> actRegister(Map<String, dynamic> body) =>
      apiProvider.registerUser(body);
}
