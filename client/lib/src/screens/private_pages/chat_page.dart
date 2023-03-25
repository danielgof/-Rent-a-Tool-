import 'package:flutter/material.dart';

import '../../models/chat_users_model.dart';
import '../../widgets/conversationList.dart';



class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "Jane Russel",
      messageText: "Awesome Setup",
      imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
      time: "Now",
    ),
    ChatUsers(
      name: "Glady's Murphy",
      messageText: "That's Great",
      imageURL: "https://randomuser.me/api/portraits/men/2.jpg",
      time: "Yesterday"
    ),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "https://randomuser.me/api/portraits/men/15.jpg", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "https://randomuser.me/api/portraits/men/1.jpg", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "https://randomuser.me/api/portraits/women/5.jpg", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "https://randomuser.me/api/portraits/men/25.jpg", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "https://randomuser.me/api/portraits/men/8.jpg", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "https://randomuser.me/api/portraits/men/9.jpg", time: "18 Feb"),
  ];

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
                padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 65, 203, 83),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.grey.shade100
                        )
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}