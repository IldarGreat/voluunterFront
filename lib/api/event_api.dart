import 'dart:convert';

import 'package:volunteer/model/event.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class EventApi {

  Future<EventList> getEvents(String accessToken) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_EVENT_PATH}'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 200) {
      return EventList.fromJson(jsonDecode(response.body));
    } else {
      List<Event> events = [];
      return EventList(events);
    }
  }

}