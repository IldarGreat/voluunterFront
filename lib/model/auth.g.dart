// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      json['id'] as int,
      json['accessToken'] as String,
      json['login'] as String,
      json['role'] as String,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'login': instance.login,
      'role': instance.role,
    };
