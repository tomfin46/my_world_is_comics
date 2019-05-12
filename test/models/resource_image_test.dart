import 'package:test/test.dart';

import 'package:my_world_is_comics/models/resource_image.dart';

void main() {
  group('ResourceImage', () {
    test('Should initialise from JSON structure', () {
      final json = {
        'thumb_url': 'https://thumb.com/superman',
        'icon_url': 'https://icon.com/superman',
      };
      final img = ResourceImage.fromJson(json);

      expect(img.thumb, 'https://thumb.com/superman');
      expect(img.icon, 'https://icon.com/superman');
    });
  });
}
