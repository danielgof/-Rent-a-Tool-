import 'dart:io';
import 'package:intl/intl.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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
            roomId: widget.room_id,
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
  int roomId;
  ChatDetailPage({
    super.key,
    required this.username,
    required this.roomId,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailPageState createState() =>
      // ignore: no_logic_in_create_state
      _ChatDetailPageState(username: username, roomId: roomId);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String username;
  int roomId;
  late Future<List<ChatMessage>> _messages;

  _ChatDetailPageState({
    required this.username,
    required this.roomId,
  });

  late IO.Socket socket;
  List<Map<String, String>> messages = [];

  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socket = IO.io('http://127.0.0.1:8080', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
      socket.emit('join', {'room': 2, 'username': 'JL'});
      // print('Received message: $data');
    });
    socket.on('join', (data) {
      // Map<String, dynamic> msg = {"username": "JL", "room": 2};
      // socket.emit(json.encode(msg));
      print('Received message: $data');
      // setState(() {
      //   messages = List.from(data); // Update the list of messages
      // });
    });
    _messages = _getMessages();
  }

  Future<int> _sendMessage(Map data) async {
    print(data);
    final response = await http.post(
      Uri.parse("$URL/api/v1/chat/save_msg/$roomId/"),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
      body: json.encode(data),
    );
    // print(response.statusCode);
    return response.statusCode;
  }

  Future<List<ChatMessage>> _getMessages() async {
    final response = await http.get(
      Uri.parse("$URL/api/v1/chat/room/$roomId/"),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)["data"];
      // print(jsonResponse);
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
                    padding: const EdgeInsets.only(top: 10, bottom: 60),
                    physics: const BouncingScrollPhysics(),
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
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Map data = {
                        "user_name":
                            JWT.decode(Utils.TOKEN).payload["username"],
                        "date": DateFormat("EEE, dd MMM yyyy ss:mm:hh")
                            .format(DateTime.now()),
                        "message": myController.value.text,
                      };
                      _sendMessage(data);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatDetailPage(
                          username: JWT.decode(Utils.TOKEN).payload["username"],
                          roomId: roomId,
                        );
                      }));
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
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
