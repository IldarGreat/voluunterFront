import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../api/application_api.dart';
import '../../db/database.dart';
import '../../model/event.dart';
import '../../model/task.dart';

class EventScreen extends StatefulWidget {
  late Event _event;
  EventScreen(this._event);

  @override
  State<EventScreen> createState() => _EventScreenState(_event);
}

class _EventScreenState extends State<EventScreen> {
  late Event _event;
  _EventScreenState(this._event);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Просмотр мероприятия',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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
          initialValue: allTaskToString(_event.tasks.tasks),
          readOnly: true,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Задачи волонтеров',
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
            applyToEvent();
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
            'Подать заявку',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            deleteEvent();
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
            'Отменить заявку',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ]),
    );
  }

  String allTaskToString(List<Task> tasks) {
    String stringTask = '';
    tasks.forEach((element) {
      stringTask = '$stringTask${element.description},';
    });
    return stringTask;
  }

  void applyToEvent() {
    DBProvider.db.getDBAuth().then((value) {
      if (value.accessRole == 'ADMIN') {
        onTappedApply('ADMIN');
      } else {
        ApplicationApi()
            .applyToEvent(_event.id, value.accessToken)
            .then((value) => {onTappedApply(value.status)});
      }
    });
  }

  void deleteEvent() {
    DBProvider.db.getDBAuth().then((value) => ApplicationApi()
        .deleteApply(_event.id, value.accessToken)
        .then((value) => {onTappedDelete(value)}));
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

  void onTappedDelete(String value) {
    final snackBar = SnackBar(
      content: Text(value),
      action: SnackBarAction(
        label: 'Ок',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
