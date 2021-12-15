// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rekap_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RekapUserModel _$RekapUserModelFromJson(Map<String, dynamic> json) {
  return RekapUserModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool? ?? false,
    (json['data'] as List<dynamic>?)
        ?.map((e) => _Data.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RekapUserModelToJson(RekapUserModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
    json['total'] as int?,
    json['name'] as String?,
  );
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'total': instance.total,
      'name': instance.name,
    };
