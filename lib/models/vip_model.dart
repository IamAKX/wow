class VipModel {
  String? vipLevel;
  String? coins;
  String? days;
  String? message;
  String? topImage;
  List<Privilegs>? privilegs;

  VipModel(
      {this.vipLevel,
      this.coins,
      this.days,
      this.message,
      this.topImage,
      this.privilegs});

  VipModel.fromJson(Map<String, dynamic> json) {
    vipLevel = json['vipLevel'];
    coins = json['coins'];
    days = json['days'];
    message = json['message'];
    topImage = json['topImage'];
    if (json['privilegs'] != null) {
      privilegs = <Privilegs>[];
      json['privilegs'].forEach((v) {
        privilegs!.add(new Privilegs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vipLevel'] = vipLevel;
    data['coins'] = coins;
    data['days'] = days;
    data['message'] = message;
    data['topImage'] = topImage;
    if (privilegs != null) {
      data['privilegs'] = privilegs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Privilegs {
  String? iconNumber;
  String? isHighlight;
  String? icon;
  String? label;
  AlertBoxDetails? alertBoxDetails;

  Privilegs(
      {this.iconNumber,
      this.isHighlight,
      this.icon,
      this.label,
      this.alertBoxDetails});

  Privilegs.fromJson(Map<String, dynamic> json) {
    iconNumber = json['iconNumber'];
    isHighlight = json['isHighlight'];
    icon = json['icon'];
    label = json['label'];
    alertBoxDetails = json['alertBoxDetails'] != null
        ? new AlertBoxDetails.fromJson(json['alertBoxDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconNumber'] = iconNumber;
    data['isHighlight'] = isHighlight;
    data['icon'] = icon;
    data['label'] = label;
    if (alertBoxDetails != null) {
      data['alertBoxDetails'] = alertBoxDetails!.toJson();
    }
    return data;
  }
}

class AlertBoxDetails {
  String? topButton;
  String? icon;
  String? title;
  String? subtitle;
  String? secondary;
  String? buttonText;

  AlertBoxDetails(
      {this.topButton,
      this.icon,
      this.title,
      this.subtitle,
      this.secondary,
      this.buttonText});

  AlertBoxDetails.fromJson(Map<String, dynamic> json) {
    topButton = json['topButton'];
    icon = json['icon'];
    title = json['title'];
    subtitle = json['subtitle'];
    secondary = json['secondary'];
    buttonText = json['buttonText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topButton'] = topButton;
    data['icon'] = icon;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['secondary'] = secondary;
    data['buttonText'] = buttonText;
    return data;
  }
}
