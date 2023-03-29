import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../../api/url.dart';
import '../../models/chat_message_model.dart';


class ChatDetailPage extends StatefulWidget{
  const ChatDetailPage({super.key});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late Future<List<ChatMessage>> _futureMessages;

  @override
  void initState() {
    super.initState();
    _futureMessages = _fetchMessages();
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


  // Future<List<ChatMessage>> fetchMessages() async {
  //   String url = "$URL/api/v1/chat/messages?sender=JL&recipient=test";
  //   final response = await http.get(Uri.parse(url),
  //     headers: {
  //       HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
  //     },);
  //
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response, parse the JSON.
  //     final List<dynamic> jsonList = json.decode(response.body);
  //     print(jsonList);
  //     List<ChatMessage> messages = [];
  //     return messages;
  //     // print(jsonList.map((json) => Post.fromJson(json)).toList());
  //     // return jsonList.map((json) => ChatMessage.fromJson(json)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response, throw an error.
  //     throw Exception('Failed to load posts');
  //   }
  // }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

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
          FutureBuilder<List<ChatMessage>>(
              future: _fetchMessages(),
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
                            child: Text(messages[index].messageContent, style: const TextStyle(fontSize: 15),),
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
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: (){},
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