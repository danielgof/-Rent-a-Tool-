import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/chats.dart';
import '../../api/utils.dart';
import '../../models/inbox.dart';
import '../../models/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Inbox>> _futureListChats;

  @override
  void initState() {
    super.initState();
    _futureListChats = getChats();
  }

  Future<List<Inbox>> getChats() async {
    final response = await http.get(
      Uri.parse("$URL/api/v1/chat/inbox"),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      final messages =
          jsonResponse.map((message) => Inbox.fromJson(message)).toList();
      return messages;
    } else {
      throw Exception("Failed to load chats");
    }
  }

  Future<List<Inbox>> queryInbox(query) async {
    String url = "$URL/api/v1/chat/search";
    Map credits = {
      "query": query,
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), body: bodyData);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      // print(json.decode(response.body)["data"]);
      return jsonList.map((json) => Inbox.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement logic to add a new chat.
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: searchController,
                  onChanged: (String val) async {
                    setState(() {
                      print(searchController.value.text);
                      _futureListChats = new Future<List<Inbox>>.value([]);
                      // queryInbox(searchController.value.text);
                      if (searchController.value.text == "") {
                        _futureListChats = getChats();
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() {
                        searchController.clear();
                        _futureListChats = getChats();
                      }),
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
              future: getChats(),
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
                        time: snapshot.data![index].date,
                        roomId: snapshot.data![index].roomId,
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
  String time;
  bool isMessageRead;
  int roomId;

  ConversationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.time,
    required this.isMessageRead,
    required this.roomId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  // Method to get message for a chat
  Future<String> _fetchAvatarBytes(String username) async {
    Map<String, String> head = <String, String>{};
    head["Authorization"] = Utils.TOKEN;
    final response =
        await http.get(Uri.parse("$URL/api/v1/auth/user_avtr/$username/"));
    if (response.statusCode == 200) {
      return json.decode(response.body)["message"];
    } else {
      // return "Failed";
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            username: widget.name,
            roomId: widget.roomId,
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
                  FutureBuilder<String>(
                    future: _fetchAvatarBytes(widget.name),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(
                          child: Image.asset("assets/placeholders/user.png"),
                        );
                      } else if (snapshot.hasError) {
                        return CircleAvatar(
                          child: Image.asset("assets/placeholders/user.png"),
                        );
                      } else if (snapshot.hasData) {
                        Uint8List bytesImage =
                            const Base64Decoder().convert(snapshot.data!);
                        // print(bytesImage);
                        return CircleAvatar(
                          backgroundImage: MemoryImage(bytesImage),
                        );
                      } else {
                        return const Text('No image data');
                      }
                    },
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
              Jiffy.parse(widget.time, pattern: "EEE, dd MMM yyyy ss:mm:hh")
                  .format(pattern: "dd/MM/yyyy"),
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
  late List<dynamic> _messages = [];

  _ChatDetailPageState({
    required this.username,
    required this.roomId,
  });

  late IO.Socket socket;
  ScrollController _scrollController = ScrollController();
  TextEditingController myController = TextEditingController();

  // Method to get message for a chat
  Future<String> fetchAvatarBytes(String username) async {
    Map<String, String> head = <String, String>{};
    head["Authorization"] = Utils.TOKEN;
    final response =
        await http.get(Uri.parse("$URL/api/v1/auth/user_avtr/$username/"));
    if (response.statusCode == 200) {
      return json.decode(response.body)["message"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    socket = IO.io('http://127.0.0.1:8080', <String, dynamic>{
      'transports': ['websocket'],
      'force new connection': true,
    });
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
      socket.emit('join',
          {'room': 2, 'username': JWT.decode(Utils.TOKEN).payload["username"]});
    });
    socket.on('join', (data) {
      setState(() {
        _messages =
            data.map((message) => ChatMessage.fromJson(message)).toList();
      });
    });
    socket.on('message', (data) {
      String msgType =
          (data["user_name"] == JWT.decode(Utils.TOKEN).payload["username"])
              ? "sender"
              : "receiver";
      setState(() {
        _messages.add(
            ChatMessage(messageContent: data["message"], messageType: msgType));
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    socket.on('disconnect', (_) {
      print('Disconnected from Socket.IO server');
    });
  }

  /// Method used to send [Map] with data on server
  _sendMessage(Map data) {
    socket.emit('message', data);
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
                FutureBuilder<String>(
                  future: fetchAvatarBytes(widget.username),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircleAvatar(
                        child: Image.asset("assets/placeholders/user.png"),
                      );
                    } else if (snapshot.hasError) {
                      return CircleAvatar(
                        child: Image.asset("assets/placeholders/user.png"),
                      );
                    } else if (snapshot.hasData) {
                      Uint8List bytesImage =
                          const Base64Decoder().convert(snapshot.data!);
                      // print(bytesImage);
                      return CircleAvatar(
                        backgroundImage: MemoryImage(bytesImage),
                      );
                    } else {
                      return const Text('No image data');
                    }
                  },
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
          ListView.builder(
            itemCount: _messages.length,
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 10, bottom: 120),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (_messages.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 17),
                  child: Align(
                    alignment: (_messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (_messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _messages[index].messageContent,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 0),
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
                        "date": DateFormat("dd/MM/yyyy").format(DateTime.now()),
                        "message": myController.value.text,
                        "room_id": widget.roomId,
                      };
                      _sendMessage(data);
                      setState(() {
                        myController.clear();
                      });
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

  @override
  void dispose() {
    // print("Dispose");
    _scrollController.dispose();
    socket.disconnect();
    super.dispose();
  }
}
