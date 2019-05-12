import 'package:test/test.dart';

import 'package:my_world_is_comics/models/character.dart';

void main() {
  group('Character', () {
    test('Should initialise from JSON structure', () {
      final json = {
        'id': 52,
        'name': 'Superman',
        'real_name': 'Clark Kent',
        'image': {
          'icon_url': 'https://icon.com/superman',
        }
      };
      final char = Character.fromJson(json);

      expect(char.id, 52);
      expect(char.name, 'Superman');
      expect(char.realName, 'Clark Kent');
      expect(char.image.icon, 'https://icon.com/superman');
    });
  });
}
