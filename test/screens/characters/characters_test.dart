import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import 'package:my_world_is_comics/screens/characters/characters.dart';

import 'package:my_world_is_comics/models/character.dart';
import 'package:my_world_is_comics/models/resource_image.dart';
import 'package:my_world_is_comics/screens/characters/widgets/characters_list.dart';

class TestAssetBundle extends CachingAssetBundle {
  final Map<String, dynamic> data;

  TestAssetBundle(this.data);

  @override
  Future<ByteData> load(String key) async {
    if (key == 'lib/assets/characters.json') {
      return ByteData.view(
        Uint8List.fromList(utf8.encode(jsonEncode(data))).buffer,
      );
    }

    return null;
  }
}

pumpWidget(WidgetTester tester, Map<String, dynamic> data) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DefaultAssetBundle(
          bundle: TestAssetBundle(data),
          child: CharactersScreen(),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('CharactersScreen', () {
    group('When there is no character data', () {
      Map<String, dynamic> data;
      setUp(() {
        data = {'results': null};
      });

      testWidgets('should render an AppBar', (WidgetTester tester) async {
        await pumpWidget(tester, data);

        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should set AppBar title to "Characters"',
          (WidgetTester tester) async {
        await pumpWidget(tester, data);

        AppBar appBar = find.byType(AppBar).evaluate().first.widget;
        Text title = appBar.title;
        expect(title.data, 'Characters');
      });

      testWidgets('Should display a CircularProgressIndicator',
          (WidgetTester tester) async {
        await pumpWidget(tester, data);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('Should not display a CharactersList',
          (WidgetTester tester) async {
        await pumpWidget(tester, data);

        expect(find.byType(CharactersList), findsNothing);
      });
    });

    group('When there is character data', () {
      Map<String, dynamic> data;
      setUp(() {
        data = {
          'results': [
            {
              'id': 52,
              'name': 'Superman',
              'real_name': 'Clark Kent',
              'image': {'icon_url': 'http://icon.com/superman'}
            },
            {
              'id': 616,
              'name': 'Captain America',
              'real_name': 'Steve Rogers',
              'image': {'icon_url': 'http://icon.com/captain-america'}
            },
          ]
        };
      });

      testWidgets('should render an AppBar', (WidgetTester tester) async {
        await provideMockedNetworkImages(() async {
          await pumpWidget(tester, data);
        });

        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should set AppBar title to "Characters"',
          (WidgetTester tester) async {
        await provideMockedNetworkImages(() async {
          await pumpWidget(tester, data);
        });

        AppBar appBar = find.byType(AppBar).evaluate().first.widget;
        Text title = appBar.title;
        expect(title.data, 'Characters');
      });

      testWidgets('Should not display a CircularProgressIndicator',
          (WidgetTester tester) async {
        await provideMockedNetworkImages(() async {
          await pumpWidget(tester, data);
        });

        expect(find.byType(CircularProgressIndicator), findsNothing);
      });

      testWidgets(
          'Should display a CharactersList with the decoded character data',
          (WidgetTester tester) async {
        await provideMockedNetworkImages(() async {
          await pumpWidget(tester, data);
        });

        final charactersList = find.byType(CharactersList);
        expect(charactersList, findsOneWidget);
        CharactersList widget = charactersList.evaluate().first.widget;
        expect(widget.characters[0].id, 52);
        expect(widget.characters[1].id, 616);
      });
    });
  });
}
