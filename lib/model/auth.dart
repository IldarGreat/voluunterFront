// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Auth {
  late int id;
  late String accessToken;
  late String login;
  late String role;
  late String firstName;
  late String secondName;
  Auth(this.id,this.accessToken, this.login, this.role,this.firstName,this.secondName);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['access_token'] = accessToken;
    map['login'] = login;
    map['role'] = role;
    return map;
  }

  Auth.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    accessToken = map['access_token'];
    login = map['login'];
    role = map['role'];
  }

  factory Auth.fromJson(Map<String,dynamic> json) =>  Auth(
      json['id'] as int,
      json['accessToken'] as String,
      json['login'] as String,
      json['role'] as String,
      json['firstName'] as String,
      json['secondName'] as String,
    );
}
