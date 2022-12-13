import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';
@JsonSerializable()
class Auth {
  late int id;
  late String accessToken;
  late String login;
  late String role;
  Auth(this.id,this.accessToken, this.login, this.role);

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
  factory Auth.fromJson(Map<String,dynamic> json) => _$AuthFromJson(json);
}
