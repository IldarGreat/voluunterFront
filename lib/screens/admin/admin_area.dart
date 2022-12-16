import 'package:flutter/material.dart';

import '../../db/database.dart';
import '../../model/user.dart';
import '../main_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String _login = "";

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Личный кабинет',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            _login,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          card(
              'Добавить мероприятие',
              '\nПланируете мероприятие, и без помощи волонтеров не обойтись? Создайте новое мероприятие, задайте нужные требования и условия проведения.',
              'Создать',
              0),
          const SizedBox(
            height: 10,
          ),
          card(
              'Список своих мероприятий',
              '\nСписок всех Ваших мероприятий. Одобрите участие волонтеров, удалите мероприятие, добавьте обратную связь и многое другое!',
              'Список',
              1),
          const SizedBox(
            height: 10,
          ),
          card(
              'Справочная информация',
              '\nЧтобы прочитать справочную информацию о системе, перейдите в соотвествующий раздел',
              'Справка',
              2),
          logout(),
        ],
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
      DBProvider.db.getDBAuth().then((value) => Navigator.pushNamed(
          context, '/events',
          arguments: value.accessToken));
    }
  }

  void getLogin() async {
    DBUser user = await DBProvider.db.getDBAuth();
    setState(() {
      _login = user.firstName;
    });
  }

  ElevatedButton logout() {
    return ElevatedButton(
      onPressed: () {
        logoutAndDeleteAuth();
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
        'Выйти из аккаунта',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void logoutAndDeleteAuth() async {
    DBUser auth = await DBProvider.db.getDBAuth();

    DBProvider.db.deleteAuth(auth.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  Card card(String title, String subtitle, String buttonName, int index) {
    return Card(
      shadowColor: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitle),
          ),
          Row(
            children: [
              const SizedBox(width: 13),
              ElevatedButton(
                onPressed: () {
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, '/addEvent');
                      break;
                    case 1:
                      DBProvider.db.getDBAuth().then((value) =>
                          Navigator.pushNamed(context, '/adminEvents',
                              arguments: value.accessToken));
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/reference');
                      break;
                    default:
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                child: Text(
                  buttonName,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
