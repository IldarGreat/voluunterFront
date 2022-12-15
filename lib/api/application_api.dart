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
      return Application(0, '',0,'');
    }
  }

  Future<ApplicationList> getAllMyApplcation(String accessToken) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_APPLICATION_PATH}'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 200) {
      return ApplicationList.fromJson(jsonDecode(response.body));
    } else {
      Application application = Application(0, '',0,'');
      List<Application> applications = [];
      applications.add(application);
      ApplicationList applicationList = ApplicationList(List.of(applications));
      return applicationList;
    }
  }

  Future<String> deleteApply(int applyId, String accessToken) async {
    final response = await http.delete(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_APPLICATION_PATH}/$applyId'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 204) {
      return 'Заявка отозвана';
    } else {
      print(response.statusCode);
      return 'Ты еще не подавал заявку на это мероприятие';
    }
  }
}
