class Message{
  int id;
  String receiver;
  String sender;
  String messageType;
  String text;
  String date;

  Message({
    required this.id,
    required this.receiver,
    required this.sender,
    required this.messageType,
    required this.text,
    required this.date
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      receiver: json['receiver'],
      sender: json['sender'],
      messageType: json['message_type'],
      text: json['text'],
      date: json['date'],
    );
  }
}