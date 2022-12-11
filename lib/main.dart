import 'package:flutter/material.dart';
import 'package:volunteer/main_page.dart';
import 'package:volunteer/reference_information_page.dart';
import 'package:volunteer/register_pade.dart';

import 'login_page.dart';

void main() {
  runApp(MaterialApp(
    home: const MainPage(),
    routes: {
      '/register': (context) => const RegisterPage(),
      '/login': (context) => const LoginPage(),
      '/reference': (context) => const ReferenceInformationPage(),
    },
  ));
}
