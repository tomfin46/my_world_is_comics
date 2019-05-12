import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_world_is_comics/models/character.dart';
import 'package:my_world_is_comics/screens/characters/widgets/characters_list.dart';

class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Characters"),
      ),
      body: new Container(
        child: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('lib/assets/characters.json'),
          builder: (context, snapshot) {
            List<Character> characters =
                parseCharacters(snapshot.data.toString());

            return characters.isNotEmpty
                ? new CharactersList(characters: characters)
                : new Center(child: new CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

List<Character> parseCharacters(String response) {
  final parsed = jsonDecode(response.toString()) as Map<String, dynamic>;
  if (parsed == null) {
    return [];
  }

  if (parsed['results'] == null) {
    return [];
  }

  return (parsed['results'] as List<dynamic>)
      .map<Character>((json) => new Character.fromJson(json))
      .toList();
}
