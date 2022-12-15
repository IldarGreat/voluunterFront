class Application {
  late int id;
  late String status;
  late int eventId;
  late String eventTitle;

  Application(this.id, this.status, this.eventId, this.eventTitle);

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      json['id'] as int,
      json['status'] as String,
      getEventId(json['event']),
      getEventTitle(json['event']),
    );
  }

  static int getEventId(Map<String, dynamic> json) {
    return json['id'];
    // return 'json['id']';
  }

  static String getEventTitle(Map<String, dynamic> json) {
    return json['title'];
    // return 'json['title']';
  }
}

class ApplicationList {
  late List<Application> applications;

  ApplicationList(this.applications);

  factory ApplicationList.fromJson(List<dynamic> jsonList) {
    List<Application> applications =
        jsonList.map((e) => Application.fromJson(e)).toList();
    return ApplicationList(applications);
  }
}
