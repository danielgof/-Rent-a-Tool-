// {
// "id": message.id,
// "receiver": message.receiver,
// "sender": message.sender,
// "text": message.text,
// "date": message.date,
// }

class Message{
  int id;
  String receiver;
  String sender;
  String text;
  String date;

  Message({
    required this.id,
    required this.receiver,
    required this.sender,
    required this.text,
    required this.date
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      receiver: json['receiver'],
      sender: json['sender'],
      text: json['text'],
      date: json['date'],
    );
  }
}