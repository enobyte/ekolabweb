import 'package:json_annotation/json_annotation.dart';

part 'standard_maplist_model.g.dart';

@JsonSerializable()
class StandardMapListModels {
  String message;
  @JsonKey(defaultValue: false)
  bool? status;
  List<Map<String, dynamic>>? data;
  int? code;

  StandardMapListModels(this.message, this.status, this.data, this.code);

  factory StandardMapListModels.fromJson(Map<String, dynamic> json) =>
      _$StandardMapListModelsFromJson(json);

  Map<String, dynamic> toJson() => _$StandardMapListModelsToJson(this);

  StandardMapListModels.withError(String error)
      : message = error,
        status = false;
}
