class WalletModel {
  String? id;
  String? userId;
  String? walletAmount;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? razorpaySignature;
  String? payVerifyStatus;
  String? created;
  String? updated;

  WalletModel(
      {this.id,
      this.userId,
      this.walletAmount,
      this.razorpayOrderId,
      this.razorpayPaymentId,
      this.razorpaySignature,
      this.payVerifyStatus,
      this.created,
      this.updated});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    walletAmount = json['wallet_amount'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpaySignature = json['razorpay_signature'];
    payVerifyStatus = json['pay_verifyStatus'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['wallet_amount'] = walletAmount;
    data['razorpay_order_id'] = razorpayOrderId;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['razorpay_signature'] = razorpaySignature;
    data['pay_verifyStatus'] = payVerifyStatus;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
