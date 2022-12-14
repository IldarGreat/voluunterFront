import 'package:flutter/material.dart';
import 'package:volunteer/model/task.dart';

class Event {
  late int id;
  late String title;
  late int volunteerAmount;
  late String place;
  late TaskList tasks;
  late String startedDay;
  late String endedDay;
  late String startedTime;

  Event(this.id, this.title, this.volunteerAmount, this.place, this.tasks,this.startedDay,
      this.endedDay, this.startedTime);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        json['id'] as int,
        json['title'] as String,
        json['volunteerAmount'] as int,
        json['place'] as String,
        TaskList.fromDynamicJson(json['tasks']),
       // TaskList.fromDynamicJson(json['tasks']),
        json['startedDay'] as String,
        json['endedDay'] as String,
        json['startedTime'] as String);
  }

  factory Event.fromJsonWhenMore(Map<String, dynamic> json) {
    List<Task> task = [];
    TaskList taskList = TaskList(task);
    return Event(
        json['id'] as int,
        json['title'] as String,
        json['volunteerAmount'] as int,
        json['place'] as String,
        taskList,
        json['startedDay'] as String,
        json['endedDay'] as String,
        json['startedTime'] as String);
  }
}




class EventList {
  late List<Event> events;

  EventList(this.events);

  factory EventList.fromJson(List<dynamic> jsonList) {
    List<Event> events = jsonList.map((e) => Event.fromJsonWhenMore(e)).toList();
    return EventList(events);
  }
}
