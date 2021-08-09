import 'package:json_annotation/json_annotation.dart';

part 'submission_model.g.dart';

@JsonSerializable()
class SubmissionModel {
  int? code;
  String? message;
  @JsonKey(defaultValue: false)
  bool? status;
  List<Map<String, dynamic>>? data;

  SubmissionModel(this.code, this.message, this.status, this.data);

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionModelToJson(this);

  SubmissionModel.withError(String error)
      : message = error,
        status = false;
}
