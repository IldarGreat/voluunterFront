import 'package:flutter/material.dart';
import 'package:volunteer/page/events_page.dart';
import 'package:volunteer/page/peronsal_area_user_page.dart';
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
      '/mainAuth': (context) => const PersonalAreaUserWidget(),
      '/events' :(context) => const EventsWidget(),
    },
  ));
}
