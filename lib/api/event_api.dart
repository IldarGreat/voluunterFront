import 'dart:convert';

import 'package:volunteer/model/event.dart';
import 'package:http/http.dart' as http;
import 'package:volunteer/model/task.dart';

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

  Future<EventList> getMyEvents(String accessToken) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_ADMIN_PATH}'),
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

   Future<String> deleteEvent(String accessToken,int eventId) async {
    final response = await http.delete(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_ADMIN_PATH}/$eventId'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 204) {
      return 'Удалено!';
    } else {
      return 'Ошибка';
    }
  }

  Future<Event> getEvent(int id, String accessToken) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_EVENT_PATH}/$id'),
      headers: <String, String>{
        'Cookie': 'volunteerJWT=$accessToken',
      },
    );
    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      List<Task> tasks = [];
      TaskList taskList = TaskList(tasks);
      Event event = Event(0, '', 0, '', taskList, '', '', '');
      return event;
    }
  }

  Future<String> addEvent(Event event, String accessToken) async {
    final response = await http.post(
        Uri.parse(
            '${Constants.VOLUNTEER_BASE_SCHEMA}${Constants.VOLUNTEER_BASE_URL_DOMAIN}${Constants.VOLUNTEER_ADMIN_PATH}'),
        headers: <String, String>{
          'Cookie': 'volunteerJWT=$accessToken',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(event.toJson()));
    if (response.statusCode == 201) {
      return 'Успешно создана!';
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return 'Произошла ошибка';
    }
  }
}
