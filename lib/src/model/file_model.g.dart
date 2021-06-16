// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) {
  return FileModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool? ?? false,
    json['data'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
