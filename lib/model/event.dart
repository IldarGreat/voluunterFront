import 'package:flutter/material.dart';
import 'package:volunteer/model/task.dart';

class Event{
  late int id;
  late String title;
  late List<Task> tasks;
  late DateTime startedDay;
  late DateTime endedDay;
  late TimeOfDay startedTime;
}