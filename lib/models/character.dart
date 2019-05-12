import 'package:my_world_is_comics/models/resource_image.dart';

class Character {
  final int id;
  final String name;
  final String realName;
  final ResourceImage image;

  Character({this.id, this.name, this.realName, this.image});

  Character.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          realName: json['real_name'],
          image: ResourceImage.fromJson(json['image'] as Map<String, dynamic>),
        );
}
