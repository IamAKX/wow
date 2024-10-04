class GenerateOrderModel {
  String? success;
  String? message;
  String? orderId;
  String? key;
  String? amount;

  GenerateOrderModel(
      {this.success, this.message, this.orderId, this.key, this.amount});

  GenerateOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    orderId = json['orderId'];
    key = json['key'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['orderId'] = this.orderId;
    data['key'] = this.key;
    data['amount'] = this.amount;
    return data;
  }
}
