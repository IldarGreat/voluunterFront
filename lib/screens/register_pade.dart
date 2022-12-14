import 'dart:math';

import 'package:flutter/material.dart';
import 'package:volunteer/api/auth_api.dart';
import 'package:volunteer/db/database.dart';

import '../model/user.dart';
import 'peronsal_area_user_page.dart';

const List<String> sexs = <String>['Мужской', 'Женский'];

class RegisterPage extends StatefulWidget {
  late bool _editData;
  RegisterPage(this._editData);

  @override
  State<StatefulWidget> createState() => RegisterState(_editData);
}

class RegisterState extends State<RegisterPage> {
  bool _hidePass = true;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _expirienceController = TextEditingController();
  final _languageController = TextEditingController();
  final _educationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String sex = sexs.first;
  late bool editData;
  RegisterState(this.editData);
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _expirienceController.dispose();
    _languageController.dispose();
    _educationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editData ? 'Редактировать данные' : 'Регистрация волонтера',
          style: const TextStyle(color: Colors.black),
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
            Text(
              editData ? 'Редактирование' : 'Регистрация',
              style: TextStyle(
                fontSize: editData ? 40 : 50,
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
                labelText: 'Имя',
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
              controller: _surnameController,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Фамилия',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) => (value!.isEmpty) ? 'Введите фамилию' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _loginController,
              maxLength: 8,
              decoration: const InputDecoration(
                hintText: 'Не менее 4 символов',
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
                hintText: 'Не менее 4 символов',
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
              height: 20,
            ),
            TextFormField(
              controller: _phoneController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Номер телефона',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) =>
                  (value!.isEmpty) ? 'Введите номер телефона' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Например mikhail@gmail.com',
                labelText: 'E-mail',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) =>
                  (value!.isEmpty) ? 'Введите свою почту' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _expirienceController,
              maxLength: 100,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Опишите Ваш опыт волонтерской деятельности',
                labelText: 'Опыт волонтерской деятельности',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              // validator: (value) => (value!.isEmpty) ? 'Введите свою почту' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _languageController,
              decoration: const InputDecoration(
                hintText: 'Англиский, Немецкий',
                labelText: 'Иностранные языки',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              // validator: (value) => (value!.isEmpty) ? 'Введите свою почту' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _educationController,
              maxLength: 30,
              decoration: const InputDecoration(
                hintText: 'Высшее(Юрист)',
                labelText: 'Образование',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.1),
                ),
              ),
              validator: (value) =>
                  (value!.isEmpty) ? 'Введите свое образование' : null,
            ),
            DropdownButton<String>(
              value: sex,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: const SizedBox(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  sex = value!;
                });
              },
              items: sexs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                child: Text(
                  editData ? 'Изменить' : 'Зарегистрироваться',
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
      UserRequest user = UserRequest(
          _nameController.text,
          _surnameController.text,
          _loginController.text,
          _passwordController.text,
          _phoneController.text,
          _emailController.text,
          _expirienceController.text,
          _languageController.text,
          _educationController.text,
          sex);
      AuthApi().register(user).then((value) {
        if (value.role == 'ERROR') {
          _errorBar(value.accessToken);
        } else {
          DBUser dbUser = DBUser(
              Random().nextInt(1000),
              _nameController.text,
              _surnameController.text,
              value.accessToken,
              value.login,
              value.role);
          DBProvider.db.insertAuth(dbUser);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PersonalAreaUserWidget()),
          );
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
