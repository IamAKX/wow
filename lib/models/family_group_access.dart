class FamilyGroupAccess {
  bool? isAdmin;
  int? invitationCount;
  int? requestCount;
  bool? isLeader;

  FamilyGroupAccess(
      {this.isAdmin, this.invitationCount, this.requestCount, this.isLeader});

  FamilyGroupAccess.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    invitationCount = json['invitationCount'];
    requestCount = json['request_count'];
    isLeader = json['isLeader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAdmin'] = isAdmin;
    data['invitationCount'] = invitationCount;
    data['request_count'] = requestCount;
    data['isLeader'] = isLeader;
    return data;
  }
}
