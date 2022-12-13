import 'package:flutter/material.dart';
import 'package:volunteer/page/main_auth_page.dart';
import 'page/login_page.dart';
import 'page/main_page.dart';
import 'page/reference_information_page.dart';
import 'page/register_pade.dart';

void main() {
  runApp(MaterialApp(
    home: const MainPage(),
    routes: {
      '/register': (context) => const RegisterPage(),
      '/login': (context) => const LoginPage(),
      '/reference': (context) => const ReferenceInformationPage(),
      '/mainAuth': (context) => const MainAuth(),
    },
  ));
}
