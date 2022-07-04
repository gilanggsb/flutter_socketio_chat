// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    required this.id,
    required this.name,
    required this.message,
    required this.timeStamp,
  });

  final int id;
  final String name;
  final String message;
  final String timeStamp;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'].runtimeType == String
            ? int.parse(json['id'])
            : json['id'],
        name: json["name"],
        message: json["message"],
        timeStamp:
            DateFormat("hh:mm").format(DateTime.parse(json["timestamp"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "message": message,
        "timestamp": timeStamp,
      };
}
