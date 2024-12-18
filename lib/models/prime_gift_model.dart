import 'dart:convert';

class PrimeGiftModel {
  String? id;
  String? title;
  String? primeAccount;
  String? image;
  String? thumbnail;
  String? status;
  String? giftType;
  String? created;
  String? updated;
  PrimeGiftModel({
    this.id,
    this.title,
    this.primeAccount,
    this.image,
    this.thumbnail,
    this.status,
    this.giftType,
    this.created,
    this.updated,
  });

  PrimeGiftModel copyWith({
    String? id,
    String? title,
    String? primeAccount,
    String? image,
    String? thumbnail,
    String? status,
    String? giftType,
    String? created,
    String? updated,
  }) {
    return PrimeGiftModel(
      id: id ?? this.id,
      title: title ?? this.title,
      primeAccount: primeAccount ?? this.primeAccount,
      image: image ?? this.image,
      thumbnail: thumbnail ?? this.thumbnail,
      status: status ?? this.status,
      giftType: giftType ?? this.giftType,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(primeAccount != null){
      result.addAll({'primeAccount': primeAccount});
    }
    if(image != null){
      result.addAll({'image': image});
    }
    if(thumbnail != null){
      result.addAll({'thumbnail': thumbnail});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(giftType != null){
      result.addAll({'giftType': giftType});
    }
    if(created != null){
      result.addAll({'created': created});
    }
    if(updated != null){
      result.addAll({'updated': updated});
    }
  
    return result;
  }

  factory PrimeGiftModel.fromMap(Map<String, dynamic> map) {
    return PrimeGiftModel(
      id: map['id'],
      title: map['title'],
      primeAccount: map['primeAccount'],
      image: map['image'],
      thumbnail: map['thumbnail'],
      status: map['status'],
      giftType: map['giftType'],
      created: map['created'],
      updated: map['updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrimeGiftModel.fromJson(String source) => PrimeGiftModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrimeGiftModel(id: $id, title: $title, primeAccount: $primeAccount, image: $image, thumbnail: $thumbnail, status: $status, giftType: $giftType, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PrimeGiftModel &&
      other.id == id &&
      other.title == title &&
      other.primeAccount == primeAccount &&
      other.image == image &&
      other.thumbnail == thumbnail &&
      other.status == status &&
      other.giftType == giftType &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      primeAccount.hashCode ^
      image.hashCode ^
      thumbnail.hashCode ^
      status.hashCode ^
      giftType.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
