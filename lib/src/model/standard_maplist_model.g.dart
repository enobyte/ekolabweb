// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_maplist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardMapListModels _$StandardMapListModelsFromJson(
    Map<String, dynamic> json) {
  return StandardMapListModels(
    json['message'] as String,
    json['status'] as bool? ?? false,
    (json['data'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    json['code'] as int?,
  );
}

Map<String, dynamic> _$StandardMapListModelsToJson(
        StandardMapListModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'code': instance.code,
    };
