import 'package:flutter/material.dart';
import 'package:volunteer/api/event_api.dart';
import 'package:volunteer/db/database.dart';
import 'package:volunteer/model/event.dart';

import '../../model/task.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  final _volunteerAmountController = TextEditingController();
  DateTime startedDay = DateTime.now();
  DateTime endedDay = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _placeController.dispose();
    _volunteerAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавить мероприятие',
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
              Navigator.pushNamed(context, '/info');
            },
            icon: const Icon(Icons.more_vert),
            color: Colors.black54,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Добавить мероприятие',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _nameController,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Название',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) => (value!.isEmpty) ? 'Введите имя' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _placeController,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Место проведения',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) => (value!.isEmpty) ? 'Введите имя' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _volunteerAmountController,
              maxLength: 3,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Количество волонтеров',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) => (value!.isEmpty) ? 'Введите имя' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Дата начала мероприятия ${startedDay.year}-${startedDay.month}-${startedDay.day}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            editDate(0),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Дата окончания мероприятия ${endedDay.year}-${endedDay.month}-${endedDay.day}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            editDate(1),
            ElevatedButton(
              onPressed: () {
                _addEvent();
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
                'Создать мероприятие',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addEvent() {
    if (_formKey.currentState!.validate()) {
      List<Task> tasks = [];
      TaskList taskList = TaskList(tasks);
      String startedMonthchar = '${startedDay.month}';
      String startedDaychar = '${startedDay.day}';
      String endedDaychar = '${endedDay.day}';
      String endedMonthchar = '${endedDay.month}';
      if (startedMonthchar.length == 1) {
        startedMonthchar = '0$startedMonthchar';
      }
      if (startedDaychar.length == 1) {
        startedDaychar = '0$startedDaychar';
      }
      if (endedDaychar.length == 1) {
        endedDaychar = '0$endedDaychar';
      }
      if (endedMonthchar.length == 1) {
        endedMonthchar = '0$endedMonthchar';
      }
      Event event = Event(
          0,
          _nameController.text,
          int.parse(_volunteerAmountController.text),
          _placeController.text,
          taskList,
          '${startedDay.year}-$startedMonthchar-$startedDaychar',
          '${endedDay.year}-$endedMonthchar-$endedDaychar',
          '13:00:00');
      DBProvider.db.getDBAuth().then(
        (value) {
          EventApi()
              .addEvent(event, value.accessToken)
              .then((value) => checkReturn(value));
        },
      );
    }
  }

  ElevatedButton editDate(int id) {
    return ElevatedButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: id == 0 ? startedDay : endedDay,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030));
          if (newDate != null) {
            setState(() {
              if (id == 0) {
                startedDay = newDate;
              } else {
                endedDay = newDate;
              }
            });
          }
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
        child: Text(
          id == 0 ? 'Изменить дату начала' : 'Изменить дату окончания',
          style: const TextStyle(color: Colors.blue),
        ));
  }

  void checkReturn(String value) {
    if (value == 'Успешно создана!') {
      final snackBar = SnackBar(
        content: const Text('Мероприятие создано'),
        action: SnackBarAction(
          label: 'Понял',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }
}
