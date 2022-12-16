class Application {
  late int id;
  late String status;
  late int eventId;
  late String eventTitle;
  late String userId;
  late String userFirstName;
  late String userSecondName;

  Application(this.id, this.status, this.eventId, this.eventTitle, this.userId,
      this.userFirstName, this.userSecondName);

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      json['id'] as int,
      json['status'] as String,
      getEventId(json['event']),
      getEventTitle(json['event']),
      getUserId(json['user']),
      getFirstNameUser(json['user']),
      getSecondNameUser(json['user']),
    );
  }

  static String getUserId(Map<String, dynamic> json) {
    return json['id'];
  }

  static int getEventId(Map<String, dynamic> json) {
    return json['id'];
  }

  static String getEventTitle(Map<String, dynamic> json) {
    return json['title'];
  }

  static String getFirstNameUser(Map<String, dynamic> json) {
    return json['firstName'];
  }

  static String getSecondNameUser(Map<String, dynamic> json) {
    return json['secondName'];
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
