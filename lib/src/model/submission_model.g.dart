// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionModel _$SubmissionModelFromJson(Map<String, dynamic> json) {
  return SubmissionModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool? ?? false,
    (json['data'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$SubmissionModelToJson(SubmissionModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
