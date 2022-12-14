import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ApplicationsWidget extends StatefulWidget {
  const ApplicationsWidget({super.key});

  @override
  State<ApplicationsWidget> createState() => _ApplicationsWidgetState();
}

class _ApplicationsWidgetState extends State<ApplicationsWidget> {
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
}
