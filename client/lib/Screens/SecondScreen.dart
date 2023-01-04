import 'package:flutter/material.dart';

import '../BottomNavBar/RentOffer.dart';
import '../BottomNavBar/RentRequest.dart';

var q1 = "Be vulnerable, be courageous, and find comfort in the uncomfortable.";
var q2 = "Prepare like you have never won and perform like you have never lost.";
var q3 = "Trust the process.";
var q4 = "A vision is a dream with a plan.";
var q5 = "You only fail when you stop trying.";
var list = [q1, q2, q3, q4, q5];

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const RentOffer(), "title": "Screen RentOffer"},
    {"screen": const RentRequest(), "title": "Screen RentRequest"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]["title"]),
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'offer'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'request')
        ],
      ),
    );
  }
}