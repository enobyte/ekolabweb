import 'package:json_annotation/json_annotation.dart';

part 'standard_map_model.g.dart';

@JsonSerializable()
class StandardMapModels {
  String message;
  @JsonKey(defaultValue: false)
  bool? status;
  Map<String, dynamic>? data;
  int? code;

  StandardMapModels(this.message, this.status, this.data, this.code);

  factory StandardMapModels.fromJson(Map<String, dynamic> json) =>
      _$StandardMapModelsFromJson(json);

  Map<String, dynamic> toJson() => _$StandardMapModelsToJson(this);

  StandardMapModels.withError(String error)
      : message = error,
        status = false;
}
