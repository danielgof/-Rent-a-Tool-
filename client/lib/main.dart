import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/public/mainPagePublic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PublicMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}