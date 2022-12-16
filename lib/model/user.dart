// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserRequest {
  String firstName;
  String secondName;
  String login;
  String password;
  String phone;
  String email;
  String experience;
  String language;
  String education;
  String sex;

  UserRequest(
      this.firstName,
      this.secondName,
      this.login,
      this.password,
      this.phone,
      this.email,
      this.experience,
      this.language,
      this.education,
      this.sex);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['secondName'] = secondName;
    map['login'] = login;
    map['password'] = password;
    map['phone'] = phone;
    map['email'] = email;
    map['experience'] = experience;
    map['language'] = language;
    map['education'] = education;
    if (sex == 'Мужской') {
      map['sex'] = 'MALE';
    }
    map['sex'] = 'FEMALE';
    return map;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'firstName': firstName,
        'secondName': secondName,
        'login': login,
        'password': password,
        'phone': phone,
        'email': email,
        'experience': experience,
        'languages': language,
        'education': education,
        'sex': sex == 'Мужской' ? 'MALE' : 'FEMALE',
      };

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
        json['firstName'] as String,
        json['secondName'] as String,
        '',
        '',
        json['phone'] as String,
        json['email'] as String,
        json['experience'] as String,
        json['languages'] as String,
        json['education'] as String,
        json['sex'] as String);
  }
}

class DBUser {
  late int id;
  late String firstName;
  late String secondName;
  late String accessToken;
  late String accessLogin;
  late String accessRole;

  DBUser(this.id, this.firstName, this.secondName, this.accessToken,
      this.accessLogin, this.accessRole);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['second_name'] = secondName;
    map['access_token'] = accessToken;
    map['login'] = accessLogin;
    map['role'] = accessRole;
    return map;
  }

  DBUser.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['first_name'];
    secondName = map['second_name'];
    accessToken = map['access_token'];
    accessLogin = map['login'];
    accessRole = map['role'];
  }
}
