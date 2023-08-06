import 'package:flutter/cupertino.dart';

class Inbox {
  int id;
  String opponent;
  int roomId;
  String date;
  String lastMessage;
  Inbox({
    required this.id,
    required this.opponent,
    required this.roomId,
    required this.date,
    required this.lastMessage,
  });

  factory Inbox.fromJson(Map<dynamic, dynamic> json) {
    return Inbox(
      id: json['id'],
      opponent: json['opponent'],
      roomId: json['room_id'],
      date: json['date'],
      lastMessage: json['last_message'],
    );
  }
}
