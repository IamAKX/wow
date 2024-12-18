import 'dart:convert';

class PopularBannerModel {
  String? id;
  String? image;
  String? created;
  PopularBannerModel({
    this.id,
    this.image,
    this.created,
  });

  PopularBannerModel copyWith({
    String? id,
    String? image,
    String? created,
  }) {
    return PopularBannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (created != null) {
      result.addAll({'created': created});
    }

    return result;
  }

  factory PopularBannerModel.fromMap(Map<String, dynamic> map) {
    return PopularBannerModel(
      id: map['id'],
      image: map['image'],
      created: map['created'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularBannerModel.fromJson(String source) =>
      PopularBannerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PopularBannerModel(id: $id, image: $image, created: $created)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PopularBannerModel &&
        other.id == id &&
        other.image == image &&
        other.created == created;
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode ^ created.hashCode;
}
