import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  int? code;
  String? message;
  @JsonKey(defaultValue: false)
  bool? status;
  Map<String, dynamic>? data;

  FileModel(this.code, this.message, this.status, this.data);

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);

  FileModel.withError(String error)
      : message = error,
        status = false;
}
