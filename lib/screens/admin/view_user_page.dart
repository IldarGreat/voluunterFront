import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:volunteer/model/user.dart';

class UserView extends StatefulWidget {
  late UserRequest? userRequest;

  UserView(this.userRequest);

  @override
  State<UserView> createState() => _UserViewState(userRequest);
}

class _UserViewState extends State<UserView> {
  late UserRequest? userRequest;

  _UserViewState(this.userRequest);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Пользователь',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
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
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          '${userRequest!.firstName}',
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.secondName,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Фамилия',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.email,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Почта',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.phone,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Номер телефона',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.experience,
          readOnly: true,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Опыт',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.language,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Языки',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: userRequest!.education,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Образование',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.1),
            ),
          ),
        ),
      ]),
    );
  }
}
