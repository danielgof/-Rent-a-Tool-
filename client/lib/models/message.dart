/// Class to present message entity
class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});

  factory ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    return ChatMessage(
      messageContent: json["messageContent"],
      messageType: json["messageType"],
    );
  }
}
