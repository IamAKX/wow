class ReportType {
  String? id;
  String? typeName;
  String? created;
  String? updated;

  ReportType({this.id, this.typeName, this.created, this.updated});

  ReportType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_name'] = typeName;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
