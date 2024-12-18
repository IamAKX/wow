class CoinBillingModel {
  String? id;
  String? userId;
  String? coins;
  String? message;
  String? created;

  CoinBillingModel(
      {this.id, this.userId, this.coins, this.message, this.created});

  CoinBillingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    coins = json['coins'];
    message = json['message'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['coins'] = coins;
    data['message'] = message;
    data['created'] = created;
    return data;
  }
}
