import 'package:flutter/material.dart';

class ReferenceInformationPage extends StatefulWidget {
  const ReferenceInformationPage({super.key});

  @override
  State<StatefulWidget> createState() => ReferenceInformationState();
}

class ReferenceInformationState extends State<ReferenceInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Справочная информация',
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
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black54,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: const [
          SizedBox(
            height: 40,
          ),
          Text(
            'Справочная\nИнформация',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Интерактивное приложение\n              "Помощь.org"\n     разработано студентом\n          гр. 6131-020402D\n         Грушенковым М.А.\n\n              Самара, 2022',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "События",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Личный кабинет",
          )
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
