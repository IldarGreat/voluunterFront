import 'dart:convert';

import 'package:volunteer/model/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserApi {

  Future<UserRequest?> getUser(String accessToken,String userId) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_ADMIN_PATH}/users/$userId'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 200) {
      return UserRequest.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
