class ResourceImage {
  final String icon;
  final String thumb;

  ResourceImage({this.icon, this.thumb});

  ResourceImage.fromJson(Map<String, dynamic> json)
      : this(
          icon: json['icon_url'],
          thumb: json['thumb_url'],
        );
}
