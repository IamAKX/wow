import 'dart:convert';

class MusicModel {
  String? name;
  String? link;
  MusicModel({
    this.name,
    this.link,
  });

  MusicModel copyWith({
    String? name,
    String? link,
  }) {
    return MusicModel(
      name: name ?? this.name,
      link: link ?? this.link,
    );
  }

  Map toMap() {
    final result = <dynamic, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (link != null) {
      result.addAll({'link': link});
    }

    return result;
  }

  factory MusicModel.fromMap(Map map) {
    return MusicModel(
      name: map['name'],
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModel.fromJson(String source) =>
      MusicModel.fromMap(json.decode(source));

  @override
  String toString() => 'MusicModel(name: $name, link: $link)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MusicModel && other.name == name && other.link == link;
  }

  @override
  int get hashCode => name.hashCode ^ link.hashCode;
}
