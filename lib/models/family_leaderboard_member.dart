class FamilyLeaderboardMember {
  String? id;
  String? uniqueId;
  String? familyName;
  String? familyLevel;
  String? description;
  String? leaderId;
  String? members;
  String? image;
  String? status;
  String? editStatus;
  String? createdAt;
  String? total;

  FamilyLeaderboardMember(
      {this.id,
      this.uniqueId,
      this.familyName,
      this.familyLevel,
      this.description,
      this.leaderId,
      this.members,
      this.image,
      this.status,
      this.editStatus,
      this.createdAt,
      this.total});

  FamilyLeaderboardMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    familyName = json['familyName'];
    familyLevel = json['familyLevel'];
    description = json['description'];
    leaderId = json['leaderId'];
    members = json['members'];
    image = json['image'];
    status = json['status'];
    editStatus = json['edit_status'];
    createdAt = json['created_at'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uniqueId'] = uniqueId;
    data['familyName'] = familyName;
    data['familyLevel'] = familyLevel;
    data['description'] = description;
    data['leaderId'] = leaderId;
    data['members'] = members;
    data['image'] = image;
    data['status'] = status;
    data['edit_status'] = editStatus;
    data['created_at'] = createdAt;
    data['total'] = total;
    return data;
  }
}
