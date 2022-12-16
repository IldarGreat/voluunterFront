import 'dart:math';

import 'package:flutter/material.dart';
import 'package:volunteer/model/user.dart';
import 'package:volunteer/screens/admin/admin_area.dart';

import '../api/auth_api.dart';
import '../db/database.dart';
import 'user/peronsal_area_user_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  bool _hidePass = true;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Вход в систему',
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Войти',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: _loginController,
              maxLength: 8,
              decoration: const InputDecoration(
                labelText: 'Логин',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Введите логин';
                }
                if (value.length < 4) {
                  return 'Размер логина не менее 4 символов';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              maxLength: 10,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: 'Пароль',
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: _hidePass
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Введите пароль';
                }
                if (value.length < 4) {
                  return 'Размер пароля не менее 4 символов';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  _submitForm();
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
                child: const Text(
                  'Войти в систему',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
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
        onTap: _onTappedBar,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      AuthApi()
          .login(_loginController.text, _passwordController.text)
          .then((value) {
        if (value.role == 'ERROR') {
          _errorBar(value.accessToken);
        } else {
          DBUser dbUser = DBUser(Random().nextInt(1000), value.firstName,
              value.secondName, value.accessToken, value.login, value.role);
          DBProvider.db.insertAuth(dbUser);
          if (dbUser.accessRole == 'USER') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const PersonalAreaUserWidget()),
            );
          } else if (dbUser.accessRole == 'ADMIN') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminPage()),
            );
          }
        }
      });
    }
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

  void _errorBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Понял',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
