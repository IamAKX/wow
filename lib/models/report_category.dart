class ReportCategoryModel {
  String? id;
  String? categoryName;
  String? created;
  String? updated;

  ReportCategoryModel({this.id, this.categoryName, this.created, this.updated});

  ReportCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
