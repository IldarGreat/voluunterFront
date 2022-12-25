import 'package:flutter/material.dart';
import '../../api/event_api.dart';
import '../../db/database.dart';
import '../../model/event.dart';

class AdminEvents extends StatefulWidget {
  late String _accessToken;

  AdminEvents(this._accessToken);
  @override
  State<AdminEvents> createState() => _AdminEventsState(_accessToken);
}

class _AdminEventsState extends State<AdminEvents> {
  late String _accessToken;
  late Future<EventList> _eventList;
  _AdminEventsState(this._accessToken);

  @override
  void initState() {
    super.initState();
    _eventList = EventApi().getMyEvents(_accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои мероприятия',
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
              Navigator.pushNamed(context, '/info');
            },
            icon: const Icon(Icons.more_vert),
            color: Colors.black54,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              const Text(
                'Мои мероприятия',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              FutureBuilder(
                future: _eventList,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.events.length,
                        itemBuilder: (context, index) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      button(
                                          'Просмотр',
                                          Colors.blue,
                                          snapshot.data!.events[index].id,
                                          snapshot.data!.events[index]),
                                      button(
                                          'Удалить',
                                          Colors.red,
                                          snapshot.data!.events[index].id,
                                          snapshot.data!.events[index])
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
            ],
          )),
    );
  }

  Widget button(String text, Color color, int id, Event event) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Удалить') {
          _showDialog(id);
        } else {
          Navigator.pushNamed(context, '/showEventToAdmin', arguments: event);
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

  _showDialog(int eventId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Удалить мероприятие?'),
            content: const Text(
                'Удаление мероприятия приведет также к удалению заявкам на это мероприятие'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Нет')),
                  ElevatedButton(
                      onPressed: () {
                        DBProvider.db.getDBAuth().then((value) => EventApi()
                            .deleteEvent(value.accessToken, eventId)
                            .then((value) => showSnackBar(value)));
                        setState(() {
                          _eventList = EventApi().getMyEvents(_accessToken);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Да'))
                ],
              ),
            ],
          );
        });
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
