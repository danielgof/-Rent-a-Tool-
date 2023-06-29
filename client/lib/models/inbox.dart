import 'package:flutter/cupertino.dart';

class Inbox {
  String id;
  String opponent;
  String roomId;
  String date;
  String lastMessage;
  String imageURL;
  Inbox({
    required this.id,
    required this.opponent,
    required this.roomId,
    required this.date,
    required this.lastMessage,
    required this.imageURL,
  });

  factory Inbox.fromJson(Map<dynamic, dynamic> json) {
    return Inbox(
      id: json['id'],
      opponent: json['opponent'],
      roomId: json['room_id'],
      date: json['date'],
      lastMessage: json['last_message'],
      imageURL: json['img'],
    );
  }
}
