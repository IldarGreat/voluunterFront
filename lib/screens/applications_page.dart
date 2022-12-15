import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/api/application_api.dart';
import 'package:volunteer/api/event_api.dart';
import 'package:volunteer/db/database.dart';
import 'package:volunteer/model/application.dart';

class ApplicationsWidget extends StatefulWidget {
  late String accessToken;
  ApplicationsWidget(this.accessToken);

  @override
  State<ApplicationsWidget> createState() =>
      _ApplicationsWidgetState(accessToken);
}

class _ApplicationsWidgetState extends State<ApplicationsWidget> {
  late String accessToken;
  late Future<ApplicationList> _applicationList;
  _ApplicationsWidgetState(this.accessToken);

  @override
  void initState() {
    super.initState();
    _applicationList = ApplicationApi().getAllMyApplcation(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Все заявки',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _applicationList,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.applications.length == 0) {
                return const Center(
                  child: Text('Заявок нет'),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.applications.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${snapshot.data?.applications[index].eventTitle}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                button(snapshot.data!.applications[index].id),
                                statusText(
                                    snapshot.data!.applications[index].status)
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "События",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Личный кабинет",
          )
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: _onTappedBar,
      ),
    );
  }

  void _onTappedBar(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  Widget button(int id) {
    return ElevatedButton(
      onPressed: () {
        DBProvider.db.getDBAuth().then((value) {
          EventApi().getEvent(id, value.accessToken).then((value) =>
              Navigator.pushNamed(context, '/event', arguments: value));
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
            side: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
      child: const Text(
        'Просмотр',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Text statusText(String status) {
    Color color = Colors.green;
    String russianStatus = 'Одобрено';
    if (status == 'WAITED') {
      color = Colors.orange;
      russianStatus = 'Ожидает';
    } else if (status == 'REJECTED') {
      color = Colors.red;
      russianStatus = 'Отклонено';
    }
    return Text(
      russianStatus,
      style: TextStyle(color: color),
    );
  }
}
