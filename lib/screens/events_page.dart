import 'package:flutter/material.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<StatefulWidget> createState() => EventState();
}

class EventState extends State<EventsWidget> {
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
}
