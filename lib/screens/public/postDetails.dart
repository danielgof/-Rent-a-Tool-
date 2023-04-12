import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/offer.dart';
import 'chatPageDetail.dart';

class PostDetailsPagePrivate extends StatelessWidget {
  final Offer post;

  const PostDetailsPagePrivate({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.toolName),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.toolName,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              post.toolDescription,
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Price: ${post.price}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Location: ${post.location}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Date Start: ${post.dateStart}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Date Finish: ${post.dateFinish}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Owner Name: ${post.ownerName}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Phone Number: ${post.phoneNumber}',
              style: const TextStyle(fontSize: 18.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatDetailPage(
                    name: post.ownerName,
                    messageText: "",
                    imageUrl: "widget.imageUrl",
                    time: "widget.time",
                  );
                }));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage("widget.imageUrl"),
                            maxRadius: 30,
                          ),
                          SizedBox(width: 16,),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(post.ownerName, style: const TextStyle(fontSize: 16),),
                                  const SizedBox(height: 6,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}