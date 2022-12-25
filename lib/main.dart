import 'package:flutter/material.dart';
import 'package:volunteer/model/user.dart';
import 'package:volunteer/screens/admin/view_user_page.dart';
import 'package:volunteer/screens/user/applications_page.dart';
import 'package:volunteer/screens/user/events_page.dart';
import 'package:volunteer/screens/user/peronsal_area_user_page.dart';
import 'model/event.dart';
import 'screens/admin/add_event_page.dart';
import 'screens/admin/admin_area.dart';
import 'screens/admin/all_application_page.dart';
import 'screens/admin/event_admin_page.dart';
import 'screens/admin/my_event_page.dart';
import 'screens/informationPage.dart';
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

        case '/login':
          return MaterialPageRoute(builder: (context) => const LoginPage());

        case '/reference':
          return MaterialPageRoute(
              builder: (context) => const ReferenceInformationPage());

        case '/mainAuth':
          return MaterialPageRoute(
              builder: (context) => const PersonalAreaUserWidget());

        case '/adminPage':
          return MaterialPageRoute(builder: (context) => const AdminPage());

        case '/events':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => EventsWidget(accessToken));

        case '/event':
          Event event = settings.arguments as Event;
          return MaterialPageRoute(builder: (context) => EventScreen(event));

        case '/addEvent':
          return MaterialPageRoute(builder: (context) => const AddEventPage());

        case '/applications':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => ApplicationsWidget(accessToken));

        case '/adminEvents':
          String accessToken = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => AdminEvents(accessToken));

        case '/showEventToAdmin':
          Event event = settings.arguments as Event;
          return MaterialPageRoute(builder: (context) => AdminEvent(event));

        case '/showApplicationToAdmin':
          UtilEvent utilEvent = settings.arguments as UtilEvent;
          return MaterialPageRoute(builder: (context) => AllApplicationsWidget(utilEvent));

        case '/showUser':
          UserRequest user = settings.arguments as UserRequest;
          return MaterialPageRoute(builder: (context) => UserView(user));

        case '/info':
          return MaterialPageRoute(
              builder: (context) => const InformationWidet());
      }
    },
  ));
}
