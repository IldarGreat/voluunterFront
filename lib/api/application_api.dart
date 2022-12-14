import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/application.dart';
import '../utils/constants.dart';

class ApplicationApi {
  Future<Application> applyToEvent(int eventId, String accessToken) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_APPLICATION_PATH}/apply/$eventId'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 200) {
      return Application.fromJson(jsonDecode(response.body));
    } else {
      return Application(0, '');
    }
  }
}
