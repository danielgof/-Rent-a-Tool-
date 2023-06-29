import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/chats.dart';
import '../../api/utils.dart';
import '../../models/inbox.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // ignore: unused_field
  late Future<List<Inbox>> _futureListChats;

  @override
  void initState() {
    super.initState();
    _futureListChats = _geChats();
  }

  Future<List<Inbox>> _geChats() async {
    final response = await http.get(
      Uri.parse("$URL/api/v1/chat/inbox"),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final messages =
          jsonResponse.map((message) => Inbox.fromJson(message)).toList();
      return messages;
    } else {
      throw Exception("Failed to load chats");
    }
  }

  // List<ChatUsers> chatUsers = [
  //   ChatUsers(
  //     name: "Jane Russel",
  //     messageText: "Awesome Setup",
  //     imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
  //     time: "Now",
  //   ),
  //   ChatUsers(
  //       name: "Glady's Murphy",
  //       messageText: "That's Great",
  //       imageURL: "https://randomuser.me/api/portraits/men/2.jpg",
  //       time: "Yesterday"
  //   ),
  //   ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "https://randomuser.me/api/portraits/men/15.jpg", time: "31 Mar"),
  //   ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "https://randomuser.me/api/portraits/men/1.jpg", time: "28 Mar"),
  //   ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "https://randomuser.me/api/portraits/women/5.jpg", time: "23 Mar"),
  //   ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "https://randomuser.me/api/portraits/men/25.jpg", time: "17 Mar"),
  //   ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "https://randomuser.me/api/portraits/men/8.jpg", time: "24 Feb"),
  //   ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "https://randomuser.me/api/portraits/men/9.jpg", time: "18 Feb"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _geChats(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ConversationList(
                        name: snapshot.data![index].opponent,
                        messageText: snapshot.data![index].lastMessage,
                        imageUrl: snapshot.data![index].imageURL,
                        time: snapshot.data![index].date,
                        room_id: snapshot.data![index].roomId,
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  int room_id;

  ConversationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
    required this.room_id,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            username: widget.name,
            room_id: widget.room_id,
            // messageText: widget.messageText,
            // imageUrl: widget.imageUrl,
            // time: widget.time,
          );
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

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

class ChatDetailPage extends StatefulWidget {
  String username;
  int room_id;
  ChatDetailPage({
    super.key,
    required this.username,
    required this.room_id,
  });
  @override
  _ChatDetailPageState createState() =>
      _ChatDetailPageState(username: username, room_id: room_id);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String username;
  int room_id;
  late Future<List<ChatMessage>> _messages;
  _ChatDetailPageState({
    required this.username,
    required this.room_id,
  });

  @override
  void initState() {
    super.initState();
    _messages = _getMessages();
  }

  Future<List<ChatMessage>> _getMessages() async {
    final response = await http.get(
      Uri.parse("$URL/api/v1/chat/room/$room_id/"),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
        // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZW1haWwiOiJwaWNhcmRAZ21haWwuY29tIiwicGhvbmUiOiIrMTk5OTM0NTk4NzIiLCJwYXNzIjoiTkNDLTE3MDEtRCIsImV4cCI6MTcxOTU4MzI5MX0.8LoE9CUGNo5eWk4otXhFcWX6ltbBEdorz77LRV9p388",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)["data"];
      print(jsonResponse);
      final messages =
          jsonResponse.map((message) => ChatMessage.fromJson(message)).toList();
      return messages;
    } else {
      throw Exception("Failed to load chats");
    }
  }

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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
              future: _messages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<ChatMessage> messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // If an error occurred while fetching the posts, display an error message
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner
                return const CircularProgressIndicator();
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
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
