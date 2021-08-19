// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submisson_proc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionProcModel _$SubmissionProcModelFromJson(Map<String, dynamic> json) {
  return SubmissionProcModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool? ?? false,
    (json['data'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$SubmissionProcModelToJson(
        SubmissionProcModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
