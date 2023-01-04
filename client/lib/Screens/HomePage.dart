import 'package:flutter/material.dart';
import 'package:mobile/Screens/WelcomePage.dart';
import '../BottomNavBar/RentOffer.dart';
import '../BottomNavBar/RentRequest.dart';
import 'LoginPage.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const WelcomePage(), "title": "ReTool"},
    {"screen": const LoginPage(), "title": "ReTool"},
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'welcome'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'login')
        ],
      ),
    );
  }
}