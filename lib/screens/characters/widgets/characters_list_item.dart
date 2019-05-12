import 'package:flutter/material.dart';
import 'package:my_world_is_comics/models/character.dart';

class CharactersListItem extends StatelessWidget {
  final Character character;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  CharactersListItem({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(character.image.icon),
      ),
      title: Text(
        character.name,
        style: _biggerFont,
      ),
      subtitle: Text(character.realName),
    );
  }
}
