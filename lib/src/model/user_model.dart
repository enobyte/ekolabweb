import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? code;
  String? message;
  bool? status;
  UserDataModel? data;

  UserModel(this.code, this.message, this.status, this.data);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class UserMultipleModel {
  int? code;
  String? message;
  bool? status;
  List<UserDataModel?>? data;

  UserMultipleModel(this.code, this.message, this.status, this.data);

  factory UserMultipleModel.fromJson(Map<String, dynamic> json) =>
      _$UserMultipleModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserMultipleModelToJson(this);

  UserMultipleModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class UserDataModel {
  String? id;
  int? kind;
  Map<String, dynamic>? data;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  UserDataModel(this.id, this.kind, this.data);
}
