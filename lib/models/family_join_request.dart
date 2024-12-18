class FamilyJoinRequest {
  String? leaderId;
  String? id;
  String? familyId;
  String? userId;
  String? type;
  String? status;
  String? isAdmin;
  String? isLeader;
  String? date;
  String? imageDp;
  String? name;
  String? username;
  String? dob;
  String? myCoin;
  String? myDiamond;

  FamilyJoinRequest(
      {this.leaderId,
      this.id,
      this.familyId,
      this.userId,
      this.type,
      this.status,
      this.isAdmin,
      this.isLeader,
      this.date,
      this.imageDp,
      this.name,
      this.username,
      this.dob,
      this.myCoin,
      this.myDiamond});

  FamilyJoinRequest.fromJson(Map<String, dynamic> json) {
    leaderId = json['leaderId'];
    id = json['id'];
    familyId = json['familyId'];
    userId = json['userId'];
    type = json['type'];
    status = json['status'];
    isAdmin = json['is_admin'];
    isLeader = json['is_leader'];
    date = json['date'];
    imageDp = json['imageDp'];
    name = json['name'];
    username = json['username'];
    dob = json['dob'];
    myCoin = json['myCoin'];
    myDiamond = json['myDiamond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leaderId'] = leaderId;
    data['id'] = id;
    data['familyId'] = familyId;
    data['userId'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['is_admin'] = isAdmin;
    data['is_leader'] = isLeader;
    data['date'] = date;
    data['imageDp'] = imageDp;
    data['name'] = name;
    data['username'] = username;
    data['dob'] = dob;
    data['myCoin'] = myCoin;
    data['myDiamond'] = myDiamond;
    return data;
  }
}
