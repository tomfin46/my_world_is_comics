import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import 'package:my_world_is_comics/screens/characters/widgets/characters_list_item.dart';

import 'package:my_world_is_comics/models/character.dart';
import 'package:my_world_is_comics/models/resource_image.dart';

pumpWidget(WidgetTester tester, Character character) async {
  await provideMockedNetworkImages(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharactersListItem(character: character),
        ),
      ),
    );
  });
}

void main() {
  Character character;

  setUpAll(() {
    character = Character(
      id: 52,
      name: 'Superman',
      realName: 'Clark Kent',
      image: ResourceImage(icon: 'http://icon.com/superman'),
    );
  });

  group('CharactersListItem', () {
    testWidgets('should render a ListTile', (WidgetTester tester) async {
      await pumpWidget(tester, character);

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display the name of the character as the title',
        (WidgetTester tester) async {
      await pumpWidget(tester, character);

      ListTile tile = find.byType(ListTile).evaluate().first.widget;
      Text title = tile.title;
      expect(title.data, 'Superman');
    });

    testWidgets('should display the real name of the character as the subtitle',
        (WidgetTester tester) async {
      await pumpWidget(tester, character);

      ListTile tile = find.byType(ListTile).evaluate().first.widget;
      Text subtitle = tile.subtitle;
      expect(subtitle.data, 'Clark Kent');
    });

    testWidgets(
        'should display the icon image of the character in a NetworkImage as the leading avatar',
        (WidgetTester tester) async {
      await pumpWidget(tester, character);

      ListTile tile = find.byType(ListTile).evaluate().first.widget;
      CircleAvatar avatar = tile.leading;
      expect(avatar.backgroundImage, NetworkImage('http://icon.com/superman'));
    });
  });
}
