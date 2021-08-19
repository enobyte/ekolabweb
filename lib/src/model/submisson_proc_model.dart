import 'package:json_annotation/json_annotation.dart';

part 'submisson_proc_model.g.dart';

@JsonSerializable()
class SubmissionProcModel {
  int? code;
  String? message;
  @JsonKey(defaultValue: false)
  bool? status;
  List<Map<String, dynamic>>? data;

  SubmissionProcModel(this.code, this.message, this.status, this.data);

  factory SubmissionProcModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionProcModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionProcModelToJson(this);

  SubmissionProcModel.withError(String error)
      : message = error,
        status = false;
}
