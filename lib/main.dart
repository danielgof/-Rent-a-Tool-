import 'package:flutter/material.dart';

import 'screens/public/offers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AllOffersPageState(),
    );
  }
}