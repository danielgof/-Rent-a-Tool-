import 'package:flutter/cupertino.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});

  factory ChatUsers.fromJson(Map<String, dynamic> json) {
    return ChatUsers(
      name: json['name'],
      messageText: json['messageText'],
      imageURL: json['imageURL'],
      time: json['time'],
    );
  }
}
