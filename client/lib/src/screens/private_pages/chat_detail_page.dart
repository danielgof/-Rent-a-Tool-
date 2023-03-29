import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../../api/url.dart';
import '../../models/chat_message_model.dart';
import '../../models/message.dart';


class ChatDetailPage extends StatefulWidget{
  const ChatDetailPage({super.key});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late Future<List<ChatMessage>> _futureMessages;
  late Future<List<Message>> _futureListMessages;

  @override
  void initState() {
    super.initState();
    _futureMessages = _fetchMessages();
    _futureListMessages = _getMessages();
  }

  Future<List<ChatMessage>> _fetchMessages() async {
    final response = await http.get(Uri.parse('$URL/api/v1/chat/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final messages = jsonResponse.map((message) => ChatMessage.fromJson(message)).toList();
      return messages;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Message>> _getMessages() async {
    final response = await http.get(Uri.parse('$URL/api/v1/chat/messages?sender=JL&recipient=alice'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final messages = jsonResponse.map((message) => Message.fromJson(message)).toList();
      // print(messages);
      return messages;
    } else {
      print('Request failed with status: ${response.statusCode}.');
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  const SizedBox(width: 2,),
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
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
          // FutureBuilder<List<ChatMessage>>(
            FutureBuilder<List<Message>>(
              // future: _fetchMessages(),
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
                          alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
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