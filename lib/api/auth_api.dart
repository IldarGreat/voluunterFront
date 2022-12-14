import 'dart:convert';

import '../model/auth.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class AuthApi {
  Future<Auth> register(UserRequest user) async {
    final response = await http.post(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_AUTH_PATH}/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      return Auth(0, response.body, '', 'ERROR','','');
    }
  }

  Future<Auth> login(String login, String password) async {
    final response = await http.post(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_AUTH_PATH}/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'login': login, 'password': password}),
    );
    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      return Auth(0, response.body, '', 'ERROR','','');
    }
  }
}
