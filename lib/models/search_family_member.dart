class SearchFamilyMember {
  String? id;
  String? name;
  String? username;
  bool? isInvitable;
  String? image;

  SearchFamilyMember(
      {this.id, this.name, this.username, this.isInvitable, this.image});

  SearchFamilyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    isInvitable = json['isInvitable'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['isInvitable'] = isInvitable;
    data['image'] = image;
    return data;
  }
}
