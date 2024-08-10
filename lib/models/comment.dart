import 'dart:convert';

class Comment {
  String? id;
  String? feedId;
  String? userId;
  String? comment;
  String? created;
  String? updated;
  String? name;
  String? image;
  String? commentCreatedTime;
  Comment({
    this.id,
    this.feedId,
    this.userId,
    this.comment,
    this.created,
    this.updated,
    this.name,
    this.image,
    this.commentCreatedTime,
  });

  Comment copyWith({
    String? id,
    String? feedId,
    String? userId,
    String? comment,
    String? created,
    String? updated,
    String? name,
    String? image,
    String? commentCreatedTime,
  }) {
    return Comment(
      id: id ?? this.id,
      feedId: feedId ?? this.feedId,
      userId: userId ?? this.userId,
      comment: comment ?? this.comment,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      name: name ?? this.name,
      image: image ?? this.image,
      commentCreatedTime: commentCreatedTime ?? this.commentCreatedTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (feedId != null) {
      result.addAll({'feedId': feedId});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (comment != null) {
      result.addAll({'comment': comment});
    }
    if (created != null) {
      result.addAll({'created': created});
    }
    if (updated != null) {
      result.addAll({'updated': updated});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (commentCreatedTime != null) {
      result.addAll({'commentCreatedTime': commentCreatedTime});
    }

    return result;
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      feedId: map['feedId'],
      userId: map['userId'],
      comment: map['comment'],
      created: map['created'],
      updated: map['updated'],
      name: map['name'],
      image: map['image'],
      commentCreatedTime: map['commentCreatedTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, feedId: $feedId, userId: $userId, comment: $comment, created: $created, updated: $updated, name: $name, image: $image, commentCreatedTime: $commentCreatedTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.feedId == feedId &&
        other.userId == userId &&
        other.comment == comment &&
        other.created == created &&
        other.updated == updated &&
        other.name == name &&
        other.image == image &&
        other.commentCreatedTime == commentCreatedTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        feedId.hashCode ^
        userId.hashCode ^
        comment.hashCode ^
        created.hashCode ^
        updated.hashCode ^
        name.hashCode ^
        image.hashCode ^
        commentCreatedTime.hashCode;
  }
}
