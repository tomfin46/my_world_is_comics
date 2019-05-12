import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import 'package:my_world_is_comics/screens/characters/widgets/characters_list.dart';

import 'package:my_world_is_comics/models/character.dart';
import 'package:my_world_is_comics/models/resource_image.dart';
import 'package:my_world_is_comics/screens/characters/widgets/characters_list_item.dart';

pumpWidget(WidgetTester tester, List<Character> characters) async {
  await provideMockedNetworkImages(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharactersList(characters: characters),
        ),
      ),
    );
  });
}

void main() {
  List<Character> characters;

  setUpAll(() {
    characters = [
      Character(
        id: 52,
        name: 'Superman',
        realName: 'Clark Kent',
        image: ResourceImage(icon: 'http://icon.com/superman'),
      ),
      Character(
        id: 616,
        name: 'Captain America',
        realName: 'Steve Rogers',
        image: ResourceImage(icon: 'http://icon.com/captain-america'),
      ),
      Character(
        id: 400,
        name: 'Hellboy',
        realName: 'Hellboy',
        image: ResourceImage(icon: 'http://icon.com/hellboy'),
      )
    ];
  });

  group('CharactersList', () {
    testWidgets('should render a ListView', (WidgetTester tester) async {
      await pumpWidget(tester, characters);

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should render a CharactersListItem for each character',
        (WidgetTester tester) async {
      await pumpWidget(tester, characters);

      final items = find.byType(CharactersListItem);
      expect(items, findsNWidgets(3));
      for (var i = 0; i < 3; i++) {
        CharactersListItem item = items.at(i).evaluate().first.widget;
        expect(item.character, characters[i]);
      }
    });

    testWidgets('should render a Divider between each character',
        (WidgetTester tester) async {
      await pumpWidget(tester, characters);

      expect(find.byType(Divider), findsNWidgets(2));
    });
  });
}
