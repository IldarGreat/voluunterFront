import 'package:flutter/material.dart';
import 'package:volunteer/api/application_api.dart';
import 'package:volunteer/api/event_api.dart';
import 'package:volunteer/model/event.dart';

import '../../db/database.dart';

class EventsWidget extends StatefulWidget {
  late String _accessToken;
  EventsWidget(this._accessToken);

  @override
  State<StatefulWidget> createState() => EventState(_accessToken);
}

class EventState extends State<EventsWidget> {
  late Future<EventList> _eventList;
  late String _accessToken;
  EventState(this._accessToken);
  @override
  void initState() {
    super.initState();
    _eventList = EventApi().getEvents(_accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Список мероприятий',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black54,
          ),
          onPressed: () {},
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
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: FutureBuilder(
          future: _eventList,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.events.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Text(
                        'Список мероприятий',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${snapshot.data?.events[index].title}',
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
                                button('Просмотр', Colors.blue,
                                    snapshot.data!.events[index].id),
                                button('Записаться', Colors.green,
                                    snapshot.data!.events[index].id)
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
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _onTappedBar,
      ),
    );
  }

  void _onTappedBar(int index) {
    if (index == 1) {
      Navigator.pop(context);
    }
  }

  Widget button(String text, Color color, int id) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Просмотр') {
          DBProvider.db.getDBAuth().then((value) {
            EventApi().getEvent(id, value.accessToken).then((value) =>
                Navigator.pushNamed(context, '/event', arguments: value));
          });
        } else {
          DBProvider.db.getDBAuth().then((value) {
            if (value.accessRole == 'ADMIN') {
              onTappedApply('ADMIN');
            } else {
              ApplicationApi()
                  .applyToEvent(id, value.accessToken)
                  .then((value) => onTappedApply(value.status));
            }
          });
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
            side: BorderSide(color: color),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }

  void onTappedApply(String status) {
    if (status.isEmpty) {
      status = 'Ты уже подал заявку';
    } else if (status == 'ADMIN') {
      status = 'Ты админ, тебе нельзя подавать заявки';
    } else if(status.isNotEmpty){
      status = 'Заявка подана!';
    }
    final snackBar = SnackBar(
      content: Text(status),
      action: SnackBarAction(
        label: 'Ок',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
