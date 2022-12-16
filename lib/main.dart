import 'package:flutter/material.dart';
import 'package:volunteer/screens/user/applications_page.dart';
import 'package:volunteer/screens/user/events_page.dart';
import 'package:volunteer/screens/user/peronsal_area_user_page.dart';
import 'model/event.dart';
import 'screens/admin/add_event_page.dart';
import 'screens/admin/admin_area.dart';
import 'screens/user/event_page.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart';
import 'screens/reference_information_page.dart';
import 'screens/register_pade.dart';

void main() {
  runApp(MaterialApp(
    home: const MainPage(),
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/register':
          bool editData = settings.arguments as bool;
          return MaterialPageRoute(
              builder: (context) => RegisterPage(editData));
          break;
        case '/login':
          return MaterialPageRoute(builder: (context) => const LoginPage());
          break;
        case '/reference':
          return MaterialPageRoute(
              builder: (context) => const ReferenceInformationPage());
          break;
        case '/mainAuth':
          return MaterialPageRoute(
              builder: (context) => const PersonalAreaUserWidget());
          break;
        case '/adminPage':
          return MaterialPageRoute(builder: (context) => const AdminPage());
          break;
        case '/events':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => EventsWidget(accessToken));
          break;
        case '/event':
          Event event = settings.arguments as Event;
          return MaterialPageRoute(builder: (context) => EventScreen(event));
          break;
        case '/addEvent':
          return MaterialPageRoute(builder: (context) => const AddEventPage());
          break;
        case '/applications':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => ApplicationsWidget(accessToken));
          break;
      }
    },
  ));
}
