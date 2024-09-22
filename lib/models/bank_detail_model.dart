class BankDetailsModel {
  String? id;
  String? userId;
  String? accountHolderName;
  String? accountNumber;
  String? bankName;
  String? branchName;
  String? ifscCode;
  String? accountType;
  String? createdAt;
  String? updatedAt;

  BankDetailsModel(
      {this.id,
      this.userId,
      this.accountHolderName,
      this.accountNumber,
      this.bankName,
      this.branchName,
      this.ifscCode,
      this.accountType,
      this.createdAt,
      this.updatedAt});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    accountHolderName = json['accountHolderName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    ifscCode = json['ifscCode'];
    accountType = json['accountType'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['accountHolderName'] = accountHolderName;
    data['accountNumber'] = accountNumber;
    data['bankName'] = bankName;
    data['branchName'] = branchName;
    data['ifscCode'] = ifscCode;
    data['accountType'] = accountType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
