import 'dart:convert';

class CreateEvent {
  String? event_topic;
  String? userId;
  String? description;
  String? event_startTime;
  String? event_Type;
  String? event_image;
  CreateEvent({
    this.event_topic,
    this.userId,
    this.description,
    this.event_startTime,
    this.event_Type,
    this.event_image,
  });

  CreateEvent copyWith({
    String? event_topic,
    String? userId,
    String? description,
    String? event_startTime,
    String? event_Type,
    String? event_image,
  }) {
    return CreateEvent(
      event_topic: event_topic ?? this.event_topic,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      event_startTime: event_startTime ?? this.event_startTime,
      event_Type: event_Type ?? this.event_Type,
      event_image: event_image ?? this.event_image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (event_topic != null) {
      result.addAll({'event_topic': event_topic});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (event_startTime != null) {
      result.addAll({'event_startTime': event_startTime});
    }
    if (event_Type != null) {
      result.addAll({'event_Type': event_Type});
    }
    if (event_image != null) {
      result.addAll({'event_image': event_image});
    }

    return result;
  }

  factory CreateEvent.fromMap(Map<String, dynamic> map) {
    return CreateEvent(
      event_topic: map['event_topic'],
      userId: map['userId'],
      description: map['description'],
      event_startTime: map['event_startTime'],
      event_Type: map['event_Type'],
      event_image: map['event_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateEvent.fromJson(String source) =>
      CreateEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateEvent(event_topic: $event_topic, userId: $userId, description: $description, event_startTime: $event_startTime, event_Type: $event_Type, event_image: $event_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateEvent &&
        other.event_topic == event_topic &&
        other.userId == userId &&
        other.description == description &&
        other.event_startTime == event_startTime &&
        other.event_Type == event_Type &&
        other.event_image == event_image;
  }

  @override
  int get hashCode {
    return event_topic.hashCode ^
        userId.hashCode ^
        description.hashCode ^
        event_startTime.hashCode ^
        event_Type.hashCode ^
        event_image.hashCode;
  }
}
