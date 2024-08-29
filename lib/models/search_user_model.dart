class SearchUserModel {
  String? id;
  String? name;
  String? username;
  String? image;
  String? familyId;

  SearchUserModel(
      {this.id, this.name, this.username, this.image, this.familyId});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    familyId = json['familyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['image'] = image;
    data['familyId'] = familyId;
    return data;
  }
}
