class SilverCoinBillingModel {
  String? id;
  String? userId;
  String? silverCoin;
  String? goldCoin;
  String? message;
  String? createdAt;

  SilverCoinBillingModel(
      {this.id,
      this.userId,
      this.silverCoin,
      this.goldCoin,
      this.message,
      this.createdAt});

  SilverCoinBillingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    silverCoin = json['silverCoin'];
    goldCoin = json['goldCoin'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['silverCoin'] = silverCoin;
    data['goldCoin'] = goldCoin;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}
