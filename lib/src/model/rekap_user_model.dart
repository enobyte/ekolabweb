import 'package:json_annotation/json_annotation.dart';

part 'rekap_user_model.g.dart';

@JsonSerializable()
class RekapUserModel {
  int? code;
  String? message;
  @JsonKey(defaultValue: false)
  bool? status;
  List<_Data>? data;

  RekapUserModel(this.code, this.message, this.status, this.data);

  factory RekapUserModel.fromJson(Map<String, dynamic> json) =>
      _$RekapUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RekapUserModelToJson(this);

  RekapUserModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  int? total;
  String? name;

  _Data(this.total, this.name);

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
