// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool?,
    json['data'] == null
        ? null
        : _UserDataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

_UserDataModel _$_UserDataModelFromJson(Map<String, dynamic> json) {
  return _UserDataModel(
    json['id'] as String?,
    json['kind'] as int?,
    json['data'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$_UserDataModelToJson(_UserDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'data': instance.data,
    };
