import 'package:flutter/material.dart';

import '../db/database.dart';
import '../model/auth.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<StatefulWidget> createState() => MainAuthState();
}

class MainAuthState extends State<MainAuth> {
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
          'Главная',
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
              'Список мероприятий',
              '\nБез Вас любому мероприятию будет непросто! Выберите из списка любое понравившееся мероприятие, заполните необходимые поля и вперед!',
              'Список'),
          const SizedBox(
            height: 10,
          ),
          card(
              'Редактирование данных',
              '\nЧтобы редактировать личные данные волонтера, перейдите в соответсвующий раздел',
              'Изменить'),
          const SizedBox(
            height: 10,
          ),
          card(
              'Список мероприятий',
              '\nБез Вас любому мероприятию будет непросто! Выберите из списка любое понравившееся мероприятие, заполните необходимые поля и вперед!',
              'Список'),
          const SizedBox(
            height: 10,
          ),
          card(
              'Справочная информация',
              '\nЧтобы прочитать справочную информацию о системе, перейдите в соответсвующий раздел.',
              'Справка'),
        ],
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
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _onTappedBar,
      ),
    );
  }

  void _onTappedBar(int index) {
    if (index != 0) {
      final snackBar = SnackBar(
        content: const Text(
          'Ты авторизован но пока не реализован',
        ),
        action: SnackBarAction(
          label: 'Понял',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void getLogin() async {
    List<Auth> auths = await DBProvider.db.getAuths();
    String login = "";
    auths.forEach((element) {
      login = element.login;
    });
    setState(() {
      _login = login;
    });
  }

  Card card(String title, String subtitle, String buttonName) {
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
                onPressed: () {},
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
