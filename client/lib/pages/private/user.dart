import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<String> fetchImageBytes() async {
    Map<String, String> head = new Map<String, String>();
    head['Authorization'] = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzEzMDEwMTEzfQ.4Yas1txQ9uK3xDafKzwjpUpLB59wpvvY44M-14E6Ook';
    final response = await http.get(Uri.parse('http://localhost:5000/api/v1/auth/avatar'), headers: head); 
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image From Server'),
      ),
      body: Container(
        child: FutureBuilder<String>(
          future: fetchImageBytes(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Uint8List bytesImage = const Base64Decoder().convert(snapshot.data!);
              // print(bytesImage);
              return CircleAvatar(backgroundImage: MemoryImage(bytesImage),);
              // return Image.memory(bytesImage);
            } else {
              return Text('No image data');
            }
          },
        ),
      ),
    );
  }
}
