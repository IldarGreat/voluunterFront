import 'package:flutter/material.dart';
import 'package:volunteer/api/application_api.dart';
import 'package:volunteer/api/user_api.dart';
import 'package:volunteer/db/database.dart';
import 'package:volunteer/model/application.dart';
import 'package:volunteer/model/event.dart';

class AllApplicationsWidget extends StatefulWidget {
  late UtilEvent _utilEvent;

  AllApplicationsWidget(this._utilEvent);
  @override
  State<AllApplicationsWidget> createState() =>
      _AllApplicationsWidgetState(_utilEvent);
}

class _AllApplicationsWidgetState extends State<AllApplicationsWidget> {
  late UtilEvent _utilEvent;
  late Future<ApplicationList> _applications;
  @override
  void initState() {
    super.initState();
    _applications = ApplicationApi()
        .getAllApplications(_utilEvent.accessToken, _utilEvent.eventId);
  }

  _AllApplicationsWidgetState(this._utilEvent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Список заявок',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/reference');
            },
            icon: const Icon(Icons.more_vert),
            color: Colors.black54,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(padding: const EdgeInsets.all(16.0), children: [
          const Text(
            'Список заявок',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          FutureBuilder(
            future: _applications,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.applications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            '${snapshot.data?.applications[index].userFirstName} ${snapshot.data?.applications[index].userSecondName}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Статус ${snapshot.data?.applications[index].status}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  button(
                                      'Просмотр',
                                      snapshot.data!.applications[index].id,
                                      snapshot
                                          .data!.applications[index].userId),
                                  button(
                                      '${snapshot.data?.applications[index].status}',
                                      snapshot
                                          .data!.applications[index].eventId,
                                      snapshot
                                          .data!.applications[index].userId),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Text('Error');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ]),
      ),
    );
  }

  Widget button(String status, int eventId, String userId) {
    String buttonText = 'Просмотр';
    Color buttonColor = Colors.blue;
    if (status == 'WAITED' || status == 'REJECTED') {
      buttonText = 'Принять';
      buttonColor = Colors.green;
    } else if (status == 'APPROVED') {
      buttonText = 'Отказать';
      buttonColor = Colors.red;
    }
    return ElevatedButton(
      onPressed: () {
        if (buttonText == 'Принять') {
          DBProvider.db.getDBAuth().then((value) => ApplicationApi()
              .changeUserStatus(
                  eventId, userId, 'APPROVED', value.accessToken));
          showSnackBar('Статус изменен');
        } else if (buttonText == 'Отказать') {
          DBProvider.db.getDBAuth().then((value) => ApplicationApi()
              .changeUserStatus(
                  eventId, userId, 'REJECTED', value.accessToken));
          showSnackBar('Статус изменен');
        } else {
          DBProvider.db.getDBAuth().then((value) => UserApi()
              .getUser(value.accessToken, userId)
              .then((value) =>
                  Navigator.pushNamed(context, '/showUser', arguments: value)));
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
            side: BorderSide(color: buttonColor),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: buttonColor),
      ),
    );
  }

  void showSnackBar(String value) {
    final snackBar = SnackBar(
      content: Text(value),
      action: SnackBarAction(
        label: 'Понял',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
