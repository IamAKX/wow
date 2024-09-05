class SenderReceiverGiftingModel {
  String? diamond;
  String? receiverId;
  String? senderId;
  String? senderName;
  String? senderUsername;
  String? receiverName;
  String? receiverUsername;
  String? senderImage;
  String? receiverImage;

  SenderReceiverGiftingModel(
      {this.diamond,
      this.receiverId,
      this.senderId,
      this.senderName,
      this.senderUsername,
      this.receiverName,
      this.receiverUsername,
      this.senderImage,
      this.receiverImage});

  SenderReceiverGiftingModel.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    senderName = json['sender_name'];
    senderUsername = json['sender_username'];
    receiverName = json['receiver_name'];
    receiverUsername = json['receiver_username'];
    senderImage = json['senderImage'];
    receiverImage = json['receiverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diamond'] = diamond;
    data['receiverId'] = receiverId;
    data['senderId'] = senderId;
    data['sender_name'] = senderName;
    data['sender_username'] = senderUsername;
    data['receiver_name'] = receiverName;
    data['receiver_username'] = receiverUsername;
    data['senderImage'] = senderImage;
    data['receiverImage'] = receiverImage;
    return data;
  }
}
