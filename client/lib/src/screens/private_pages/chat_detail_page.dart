import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';


import '../../../api/url.dart';
import '../../models/chat_message_model.dart';
import '../../models/chat_users_model.dart';
import '../../models/message.dart';


// class ChatDetailPage extends StatefulWidget{
//   final String name;
//   final String messageText;
//   final String imageUrl;
//   final String time;
//
//   const ChatDetailPage({
//     Key? key,
//     required this.name,
//     required this.messageText,
//     required this.imageUrl,
//     required this.time,
//   }) : super(key: key);
//
//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }
//
// class _ChatDetailPageState extends State<ChatDetailPage> {
//   final TextEditingController _messageController = TextEditingController();
//   late final WebSocket _channel;
//   late final StreamSubscription _subscription;
//   final List<Message> _messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _channel = WebSocket.connect(Uri.parse('$URL/api/v1/chat')) as WebSocket;
//     _subscription = _channel.stream.listen(_handleMessage);
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     _channel.sink.close();
//     super.dispose();
//   }
//
//   void _handleMessage(dynamic data) {
//     final message = Message.fromJson(jsonDecode(data));
//     setState(() {
//       _messages.add(message);
//     });
//   }
//
//   void _sendMessage() {
//     final message = _messageController.text.trim();
//     if (message.isNotEmpty) {
//       final data = jsonEncode({
//         'sender': 'JL',
//         'recipient': 'alice',
//         'text': message,
//         'date': DateTime.now().toString(),
//       });
//       _channel.sink.add(data);
//       _messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // ...
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final isSender = message.sender == 'JL';
//                 return Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: isSender ? Colors.blue[200] : Colors.grey[200],
//                     ),
//                     child: Text(message.text),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: const OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: _sendMessage,
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class ChatDetailPage extends StatefulWidget{
  late String name;
  late String messageText;
  late String imageUrl;
  late String time;


  ChatDetailPage({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
  });

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late Future<List<ChatMessage>> _futureMessages;
  late Future<List<Message>> _futureListMessages;

  @override
  void initState() {
    super.initState();
    _futureListMessages = _getMessages();
  }

  Future<List<Message>> _getMessages() async {
    final response1 = await http.get(Uri.parse('$URL/api/v1/chat/messages?sender=JL&recipient=alice'));
    final response2 = await http.get(Uri.parse('$URL/api/v1/chat/messages?sender=alice&recipient=JL'));
    if (response1.statusCode == 200) {
      final List<dynamic> jsonResponse1 = json.decode(response1.body);
      final messages1 = jsonResponse1.map((message1) => Message.fromJson(message1)).toList();
      final List<dynamic> jsonResponse2 = json.decode(response2.body);
      final messages2 = jsonResponse2.map((message2) => Message.fromJson(message2)).toList();
      var messages = messages1 + messages2;
      // print(messages);
      return messages;
    } else {
      print('Request failed with status: ${response1.statusCode}.');
      throw Exception('Failed to load posts');
    }
  }

  Future<int> sendMessage(message) async {
    String url = "http://127.0.0.1:5000/api/v1/chat/send_message";
    Map credits = {
        "sender": "JL",
        "recipient": "alice",
        "message_type": "sender",
        "text": message,
        "date": "01/03/2027"
      };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), body: bodyData);
    var data = response.statusCode;
    return data;
  }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  TextEditingController messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // print("widget.name: "+widget.name);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  const SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.name, style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                  const Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: FutureBuilder<List<Message>>(
              future: _getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages?.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (messages[index].receiver == "JL"?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].receiver  == "JL"?Colors.grey.shade200:Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(messages[index].text, style: const TextStyle(fontSize: 15),),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                        ),
                        controller: messageController,
                      ),
                    ),
                    const SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: (){
                        sendMessage(messageController.text);
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}