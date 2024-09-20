class LiveRoomGiftHistoryModel {
  String? diamond;
  String? senderId;
  String? giftId;
  String? giftType;
  String? senderName;
  String? senderUsername;
  String? senderDob;
  String? senderGender;
  String? receiverId;
  String? receiverName;
  String? receiverUsername;
  String? receiverDob;
  String? receiverGender;
  String? receiverImg;
  String? senderImg;

  LiveRoomGiftHistoryModel(
      {this.diamond,
      this.senderId,
      this.giftId,
      this.giftType,
      this.senderName,
      this.senderUsername,
      this.senderDob,
      this.senderGender,
      this.receiverId,
      this.receiverName,
      this.receiverUsername,
      this.receiverDob,
      this.receiverGender,
      this.receiverImg,
      this.senderImg});

  LiveRoomGiftHistoryModel.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    senderId = json['senderId'];
    giftId = json['giftId'];
    giftType = json['gift_type'];
    senderName = json['sender_name'];
    senderUsername = json['sender_username'];
    senderDob = json['sender_dob'];
    senderGender = json['sender_gender'];
    receiverId = json['receiverId'];
    receiverName = json['receiver_name'];
    receiverUsername = json['receiver_username'];
    receiverDob = json['receiver_dob'];
    receiverGender = json['receiver_gender'];
    receiverImg = json['receiver_img'];
    senderImg = json['sender_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diamond'] = diamond;
    data['senderId'] = senderId;
    data['giftId'] = giftId;
    data['gift_type'] = giftType;
    data['sender_name'] = senderName;
    data['sender_username'] = senderUsername;
    data['sender_dob'] = senderDob;
    data['sender_gender'] = senderGender;
    data['receiverId'] = receiverId;
    data['receiver_name'] = receiverName;
    data['receiver_username'] = receiverUsername;
    data['receiver_dob'] = receiverDob;
    data['receiver_gender'] = receiverGender;
    data['receiver_img'] = receiverImg;
    data['sender_img'] = senderImg;
    return data;
  }
}
