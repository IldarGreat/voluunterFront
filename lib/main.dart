import 'package:flutter/material.dart';
import 'package:volunteer/screens/applications_page.dart';
import 'package:volunteer/screens/events_page.dart';
import 'package:volunteer/screens/peronsal_area_user_page.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart';
import 'screens/reference_information_page.dart';
import 'screens/register_pade.dart';

void main() {
  runApp(MaterialApp(
    home: const MainPage(),
    routes: {
      '/register': (context) => const RegisterPage(),
      '/login': (context) => const LoginPage(),
      '/reference': (context) => const ReferenceInformationPage(),
      '/mainAuth': (context) => const PersonalAreaUserWidget(),
      '/events': (context) => const EventsWidget(),
      '/applications': (context) => const ApplicationsWidget(),
    },
  ));
}
