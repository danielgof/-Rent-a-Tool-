import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rt_client/pages/public/main_page_public.dart';

import 'pages/public/offers_page.dart';

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
      home: PublicMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}