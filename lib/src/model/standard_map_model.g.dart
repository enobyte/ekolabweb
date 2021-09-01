// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardMapModels _$StandardMapModelsFromJson(Map<String, dynamic> json) {
  return StandardMapModels(
    json['message'] as String,
    json['status'] as bool? ?? false,
    json['data'] as Map<String, dynamic>?,
    json['code'] as int?,
  );
}

Map<String, dynamic> _$StandardMapModelsToJson(StandardMapModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'code': instance.code,
    };
