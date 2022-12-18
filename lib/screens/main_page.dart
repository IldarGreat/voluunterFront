import 'package:flutter/material.dart';
import 'package:volunteer/model/user.dart';

import '../db/database.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    hasAuthFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          'Меню',
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
      body: Column(
        children: [
          SizedBox(
           // height: MediaQuery.of(context).size.height,
            child: Container(
             // color: Colors.blue,
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Помощь.\norg',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 123),
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 123)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register',
                          arguments: false);
                    },
                    child: const Text(
                      'Стать волонтером',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 123),
                          fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 123)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Войти в аккаунт',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 123),
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        content: const Text('Ты не авторизован!'),
        action: SnackBarAction(
          label: 'Понял',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void hasAuthFuture() async {
    DBUser user = await DBProvider.db.getDBAuth();
    if (user.accessRole == 'USER') {
      Navigator.pushNamed(context, '/mainAuth', arguments: false);
    } else if (user.accessRole == 'ADMIN') {
      Navigator.pushNamed(context, '/adminPage');
    }
  }
}
