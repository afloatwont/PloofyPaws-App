// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) => _$UserDataImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      serverAuthCode: json['serverAuthCode'] as String,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'serverAuthCode': instance.serverAuthCode,
    };
