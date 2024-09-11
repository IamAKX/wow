class AgoraToken {
  String? name;
  String? username;
  String? dob;
  String? gender;
  String? userId;
  String? image;
  String? toke;
  String? channelName;
  String? rtmToken;
  String? mainId;

  AgoraToken(
      {this.name,
      this.username,
      this.dob,
      this.gender,
      this.userId,
      this.image,
      this.toke,
      this.channelName,
      this.rtmToken,
      this.mainId});

  AgoraToken.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    dob = json['dob'];
    gender = json['gender'];
    userId = json['userId'];
    image = json['image'];
    toke = json['toke'];
    channelName = json['channelName'];
    rtmToken = json['rtmToken'];
    mainId = json['mainId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['dob'] = dob;
    data['gender'] = gender;
    data['userId'] = userId;
    data['image'] = image;
    data['toke'] = toke;
    data['channelName'] = channelName;
    data['rtmToken'] = rtmToken;
    data['mainId'] = mainId;
    return data;
  }
}
