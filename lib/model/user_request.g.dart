// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      json['firstName'] as String,
      json['secondName'] as String,
      json['login'] as String,
      json['password'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['experience'] as String,
      json['language'] as String,
      json['education'] as String,
      json['sex'] as String,
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'login': instance.login,
      'password': instance.password,
      'phone': instance.phone,
      'email': instance.email,
      'experience': instance.experience,
      'language': instance.language,
      'education': instance.education,
      'sex': instance.sex,
    };
