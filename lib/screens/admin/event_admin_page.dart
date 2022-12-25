import 'package:flutter/material.dart';
import 'package:volunteer/model/event.dart';

import '../../api/event_api.dart';
import '../../db/database.dart';

class AdminEvent extends StatefulWidget {
  late Event _event;
  AdminEvent(this._event);

  @override
  State<AdminEvent> createState() => _AdminEventState(_event);
}

class _AdminEventState extends State<AdminEvent> {
  late Event _event;
  _AdminEventState(this._event);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Просмотр мероприятия',
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
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          '${_event.title}',
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: _event.title,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Название мероприятия',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: _event.place,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Место проведения',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: '${_event.volunteerAmount}',
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Количество волонтеров',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: _event.startedDay,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Дата начала проведения мероприятия',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: _event.endedDay,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Дата завершения мероприятия',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            DBProvider.db.getDBAuth().then((value) => Navigator.pushNamed(
                context, '/showApplicationToAdmin',
                arguments: UtilEvent(_event.id, value.accessToken)));
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
            'Список заявок волонтеров',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            _showDialog(_event.id);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
          child: const Text(
            'Удалить мероприятие',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ]),
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
                        Navigator.pop(context);
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
