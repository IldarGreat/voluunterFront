import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Меню',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black54,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: FooterView(
        footer: Footer(
          child: Text('I am a Customizable footer!!'),
        ),
        flex: 1,
        children: <Widget>[
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Column(
              children: const [
                SizedBox(
                  height: 150,
                ),
                Text(
                  'Помощь.\norg',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 123),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ], //default flex is 2
      ),
    );
  }
}
