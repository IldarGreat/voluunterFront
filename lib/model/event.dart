import 'package:flutter/material.dart';
import 'package:volunteer/model/task.dart';

class Event {
  late int id;
  late String title;
  late String startedDay;
  late String endedDay;
  late String startedTime;

  Event(this.id, this.title, this.startedDay, this.endedDay, this.startedTime);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        json['id'] as int,
        json['title'] as String,
        // Передать в tasks from json
        //TaskList.fromJson(json['tasks'] ),
        json['startedDay'] as String,
        json['endedDay'] as String,
        json['startedTime'] as String);
  }
}

class EventList{
  late List<Event> events;

   EventList(this.events);

 // factory EventList.fromJson(Map<String, dynamic> json) {
 //   var taskJson = json['events'] as List;
 //   List<Event> events = taskJson.map((e) => Event.fromJson(e)).toList();
 //   return EventList(events);
 // }

 factory EventList.fromJson(List<dynamic> jsonList){
  List<Event> events = jsonList.map((e) => Event.fromJson(e)).toList();
  return EventList(events);
 }
}
