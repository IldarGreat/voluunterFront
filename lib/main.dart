import 'package:flutter/material.dart';
import 'package:volunteer/screens/applications_page.dart';
import 'package:volunteer/screens/events_page.dart';
import 'package:volunteer/screens/peronsal_area_user_page.dart';
import 'model/event.dart';
import 'screens/event_page.dart';
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
        case '/events':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => EventsWidget(accessToken));
          break;
        case '/event':
          Event event = settings.arguments as Event;
          return MaterialPageRoute(
              builder: (context) => EventScreen(event));
          break;
        case '/applications':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => ApplicationsWidget(accessToken));
          break;
      }
    },
    //routes: {
    //  '/register': (context) => const RegisterPage(),
    //  '/login': (context) => const LoginPage(),
    //  '/reference': (context) => const ReferenceInformationPage(),
    //  '/mainAuth': (context) => const PersonalAreaUserWidget(),
    //  '/events': (context) => const EventsWidget(),
    //  '/applications': (context) => const ApplicationsWidget(),
    // },
  ));
}
