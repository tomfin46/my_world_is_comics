import 'package:flutter/material.dart';

import 'package:my_world_is_comics/models/character.dart';
import 'package:my_world_is_comics/screens/characters/widgets/characters_list_item.dart';

class CharactersList extends StatelessWidget {
  final List<Character> characters;

  CharactersList({@required this.characters});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: characters.length,
      itemBuilder: (context, i) => CharactersListItem(character: characters[i]),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
