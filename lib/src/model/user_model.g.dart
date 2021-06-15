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
        : UserDataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

UserMultipleModel _$UserMultipleModelFromJson(Map<String, dynamic> json) {
  return UserMultipleModel(
    json['code'] as int?,
    json['message'] as String?,
    json['status'] as bool?,
    (json['data'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : UserDataModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserMultipleModelToJson(UserMultipleModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  return UserDataModel(
    json['id'] as String?,
    json['kind'] as int?,
    json['data'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'data': instance.data,
    };
