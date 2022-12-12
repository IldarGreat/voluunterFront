import 'package:flutter/material.dart';

const List<String> sexs = <String>['Мужской', 'Женский'];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterState();
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
        title: const Text(
          'Регистрация волонтера',
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
              'Регистрация',
              style: TextStyle(
                fontSize: 50,
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
                child: const Text(
                  'Зарегистрироваться',
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
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }
}
