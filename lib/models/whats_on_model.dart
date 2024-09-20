class WhatsonModel {
  String? id;
  String? eventTopic;
  String? eventCreaterId;
  String? description;
  String? eventStartTime;
  String? eventType;
  String? eventImage;
  String? eventSubscriberCounts;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? username;
  String? dob;
  List<String>? eventSubscribers;
  bool? isSubscribe;
  String? imageDp;

  WhatsonModel(
      {this.id,
      this.eventTopic,
      this.eventCreaterId,
      this.description,
      this.eventStartTime,
      this.eventType,
      this.eventImage,
      this.eventSubscriberCounts,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.username,
      this.dob,
      this.eventSubscribers,
      this.isSubscribe,
      this.imageDp});

  WhatsonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventTopic = json['event_topic'];
    eventCreaterId = json['eventCreaterId'];
    description = json['description'];
    eventStartTime = json['event_startTime'];
    eventType = json['event_Type'];
    eventImage = json['event_image'];
    eventSubscriberCounts = json['eventSubscriber_counts'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    username = json['username'];
    dob = json['dob'];
    eventSubscribers = json['eventSubscribers'].cast<String>();
    isSubscribe = json['isSubscribe'];
    imageDp = json['imageDp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_topic'] = eventTopic;
    data['eventCreaterId'] = eventCreaterId;
    data['description'] = description;
    data['event_startTime'] = eventStartTime;
    data['event_Type'] = eventType;
    data['event_image'] = eventImage;
    data['eventSubscriber_counts'] = eventSubscriberCounts;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['username'] = username;
    data['dob'] = dob;
    data['eventSubscribers'] = eventSubscribers;
    data['isSubscribe'] = isSubscribe;
    data['imageDp'] = imageDp;
    return data;
  }
}
