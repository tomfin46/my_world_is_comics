import 'package:flutter/material.dart';
import 'package:my_world_is_comics/screens/characters/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My World Is Comics',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CharactersScreen(),
      },
    );
  }
}
