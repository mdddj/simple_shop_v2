// To parse this JSON data, do
//
//     final topic = topicFromJson(jsonString);

import 'dart:convert';

List<Topic> topicFromJson(String str) => List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

String topicToJson(List<Topic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topic {
  Topic({
    this.topicId,
    this.topBanner,
    this.topicName,
    this.banner,
    this.startTime,
    this.endTime,
  });

  int topicId;
  List<String> topBanner;
  String topicName;
  List<String> banner;
  DateTime startTime;
  DateTime endTime;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    topicId: json["topicId"],
    topBanner: List<String>.from(json["topBanner"].map((x) => x)),
    topicName: json["topicName"],
    banner: List<String>.from(json["banner"].map((x) => x)),
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
  );

  Map<String, dynamic> toJson() => {
    "topicId": topicId,
    "topBanner": List<dynamic>.from(topBanner.map((x) => x)),
    "topicName": topicName,
    "banner": List<dynamic>.from(banner.map((x) => x)),
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
  };
}
