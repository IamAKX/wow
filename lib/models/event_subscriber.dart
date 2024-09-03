class EventSubscriber {
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
  String? imageDp;
  bool? subscriberStatus;
  List<EventSubscribers>? eventSubscribers;

  EventSubscriber(
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
      this.imageDp,
      this.subscriberStatus,
      this.eventSubscribers});

  EventSubscriber.fromJson(Map<String, dynamic> json) {
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
    imageDp = json['imageDp'];
    subscriberStatus = json['subscriberStatus'];
    if (json['eventSubscribers'] != null) {
      eventSubscribers = <EventSubscribers>[];
      json['eventSubscribers'].forEach((v) {
        eventSubscribers!.add(EventSubscribers.fromJson(v));
      });
    }
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
    data['imageDp'] = imageDp;
    data['subscriberStatus'] = subscriberStatus;
    if (eventSubscribers != null) {
      data['eventSubscribers'] =
          eventSubscribers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventSubscribers {
  String? id;
  String? eventId;
  String? userId;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? username;
  String? imageDp;

  EventSubscribers(
      {this.id,
      this.eventId,
      this.userId,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.username,
      this.imageDp});

  EventSubscribers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    userId = json['userId'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    username = json['username'];
    imageDp = json['imageDp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventId'] = eventId;
    data['userId'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['username'] = username;
    data['imageDp'] = imageDp;
    return data;
  }
}
