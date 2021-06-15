import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? code;
  String? message;
  bool? status;
  _UserDataModel? data;

  UserModel(this.code, this.message, this.status, this.data);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _UserDataModel {
  String? id;
  int? kind;
  Map<String, dynamic>? data;

  factory _UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$_UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$_UserDataModelToJson(this);

  _UserDataModel(this.id, this.kind, this.data);
}
