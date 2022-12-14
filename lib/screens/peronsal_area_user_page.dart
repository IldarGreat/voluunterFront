import 'package:flutter/material.dart';
import 'package:volunteer/model/user.dart';
import 'package:volunteer/screens/main_page.dart';

import '../db/database.dart';
import '../model/auth.dart';

class PersonalAreaUserWidget extends StatefulWidget {
  const PersonalAreaUserWidget({super.key});

  @override
  State<StatefulWidget> createState() => PersonalAreaUseState();
}

class PersonalAreaUseState extends State<PersonalAreaUserWidget> {
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
              'Список',
              0),
          const SizedBox(
            height: 10,
          ),
          card(
              'Редактирование данных',
              '\nЧтобы редактировать личные данные волонтера, перейдите в соответсвующий раздел',
              'Изменить',
              1),
          const SizedBox(
            height: 10,
          ),
          card(
              'Список заявок',
              '\nУже учавствовали в каком-либо мероприятии или это только предстоит? Посмотрите полный список Ваших заявок на мероприятия.',
              'Заявки',
              2),
          const SizedBox(
            height: 10,
          ),
          card(
              'Справочная информация',
              '\nЧтобы прочитать справочную информацию о системе, перейдите в соответсвующий раздел.',
              'Справка',
              3),
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
      Navigator.pushNamed(context, '/events');
    }
  }

  void getLogin() async {
    DBUser user = await DBProvider.db.getDBAuth();
    setState(() {
      _login = user.firstName;
    });
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
                      Navigator.pushNamed(context, '/events');
                      break;
                    case 1:
                      Navigator.pushNamed(context, '/register', arguments: true);
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/applications');
                      break;
                    case 3:
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

  void logoutAndDeleteAuth() async {
    DBUser auth = await DBProvider.db.getDBAuth();
    
    DBProvider.db.deleteAuth(auth.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
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
}
