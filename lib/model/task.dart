class Task {
  late int id;
  late String title;
  late String description;
  late String wish;
  late int eventId;

  Task(this.id, this.title, this.wish, this.description, this.eventId);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        json['id'] as int,
        json['title'] as String,
        json['wish'] as String,
        json['description'] as String,
        json['eventId'] as int);
  }
}

class TaskList {
  late List<Task> tasks;

  TaskList(this.tasks);

  factory TaskList.fromJson(Map<String, dynamic> json) {
    var taskJson = json['tasks'] as List;
    List<Task> tasks = taskJson.map((e) => Task.fromJson(e)).toList();
    return TaskList(tasks);
  }

  factory TaskList.fromDynamicJson(dynamic json) {
    var taskJson = json as List;
    List<Task> tasks = taskJson.map((e) => Task.fromJson(e)).toList();
    return TaskList(tasks);
  }
}
