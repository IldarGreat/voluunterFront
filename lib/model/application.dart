
class Application {
  late int id;
  late String status;

  Application(this.id, this.status);

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      json['id'] as int,
      json['status'] as String,
    );
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
