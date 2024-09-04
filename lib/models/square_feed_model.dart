// ignore_for_file: unnecessary_this

class SquareFeedModel {
  String? id;
  String? userId;
  String? description;
  String? image;
  String? status;
  String? commentCount;
  String? likeCount;
  String? created;
  String? postCreated;
  String? updated;
  String? postStatus;
  String? name;
  bool? likeStatus;
  String? imageDp;
  String? postTime;
  String? commentBy;
  String? comment;
  String? commentByame;
  String? commentByUsername;

  SquareFeedModel(
      {this.id,
      this.userId,
      this.description,
      this.image,
      this.status,
      this.commentCount,
      this.likeCount,
      this.created,
      this.postCreated,
      this.updated,
      this.postStatus,
      this.name,
      this.likeStatus,
      this.imageDp,
      this.postTime,
      this.commentBy,
      this.comment,
      this.commentByame,
      this.commentByUsername});

  SquareFeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    created = json['created'];
    postCreated = json['postCreated'];
    updated = json['updated'];
    postStatus = json['postStatus'];
    name = json['name'];
    likeStatus = json['likeStatus'];
    imageDp = json['imageDp'];
    postTime = json['postTime'];
    commentBy = json['commentBy'];
    comment = json['comment'];
    commentByame = json['commentByame'];
    commentByUsername = json['commentByUsername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    data['created'] = this.created;
    data['postCreated'] = this.postCreated;
    data['updated'] = this.updated;
    data['postStatus'] = this.postStatus;
    data['name'] = this.name;
    data['likeStatus'] = this.likeStatus;
    data['imageDp'] = this.imageDp;
    data['postTime'] = this.postTime;
    data['commentBy'] = this.commentBy;
    data['comment'] = this.comment;
    data['commentByame'] = this.commentByame;
    data['commentByUsername'] = this.commentByUsername;
    return data;
  }
}
