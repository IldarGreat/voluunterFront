import 'package:json_annotation/json_annotation.dart';
part 'user_request.g.dart';

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
    if(sex=='Мужской'){
      map['sex'] = 'MALE';
    }
    map['sex'] = 'FEMALE';
    return map;
  }

  Map<String,dynamic> toJson() => _$UserRequestToJson(this);
}
