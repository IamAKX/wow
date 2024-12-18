class FamilyInviteRequest {
  String? id;
  String? familyId;
  String? userId;
  String? type;
  String? status;
  String? isAdmin;
  String? isLeader;
  String? date;
  String? image;
  String? description;
  String? familyName;

  FamilyInviteRequest(
      {this.id,
      this.familyId,
      this.userId,
      this.type,
      this.status,
      this.isAdmin,
      this.isLeader,
      this.date,
      this.image,
      this.description,
      this.familyName});

  FamilyInviteRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    userId = json['userId'];
    type = json['type'];
    status = json['status'];
    isAdmin = json['is_admin'];
    isLeader = json['is_leader'];
    date = json['date'];
    image = json['image'];
    description = json['description'];
    familyName = json['familyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['familyId'] = familyId;
    data['userId'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['is_admin'] = isAdmin;
    data['is_leader'] = isLeader;
    data['date'] = date;
    data['image'] = image;
    data['description'] = description;
    data['familyName'] = familyName;
    return data;
  }
}
