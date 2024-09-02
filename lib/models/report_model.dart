import 'dart:convert';

class ReportModel {
  String? reportCategory;
  String? reportSubCategory;
  String? otherUserId;
  String? postId;
  String? userId;
  String? desc;
  ReportModel({
    this.reportCategory,
    this.reportSubCategory,
    this.otherUserId,
    this.postId,
    this.userId,
    this.desc,
  });

  ReportModel copyWith({
    String? reportCategory,
    String? reportSubCategory,
    String? otherUserId,
    String? postId,
    String? userId,
    String? desc,
  }) {
    return ReportModel(
      reportCategory: reportCategory ?? this.reportCategory,
      reportSubCategory: reportSubCategory ?? this.reportSubCategory,
      otherUserId: otherUserId ?? this.otherUserId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(reportCategory != null){
      result.addAll({'reportCategory': reportCategory});
    }
    if(reportSubCategory != null){
      result.addAll({'reportSubCategory': reportSubCategory});
    }
    if(otherUserId != null){
      result.addAll({'otherUserId': otherUserId});
    }
    if(postId != null){
      result.addAll({'postId': postId});
    }
    if(userId != null){
      result.addAll({'userId': userId});
    }
    if(desc != null){
      result.addAll({'desc': desc});
    }
  
    return result;
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reportCategory: map['reportCategory'],
      reportSubCategory: map['reportSubCategory'],
      otherUserId: map['otherUserId'],
      postId: map['postId'],
      userId: map['userId'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(reportCategory: $reportCategory, reportSubCategory: $reportSubCategory, otherUserId: $otherUserId, postId: $postId, userId: $userId, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReportModel &&
      other.reportCategory == reportCategory &&
      other.reportSubCategory == reportSubCategory &&
      other.otherUserId == otherUserId &&
      other.postId == postId &&
      other.userId == userId &&
      other.desc == desc;
  }

  @override
  int get hashCode {
    return reportCategory.hashCode ^
      reportSubCategory.hashCode ^
      otherUserId.hashCode ^
      postId.hashCode ^
      userId.hashCode ^
      desc.hashCode;
  }
}
