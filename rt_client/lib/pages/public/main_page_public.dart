import 'package:flutter/material.dart';

import '../../models/credentials.dart';
import 'login_page.dart';
import 'mapOffers.dart';
import 'offers_page.dart';


class PublicMain extends StatefulWidget {

  @override
  State<PublicMain> createState() => _PublicMainScreenState();
}

class _PublicMainScreenState extends State<PublicMain> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    AllOffersPageState(),
    SignInScreen(onSignIn: (Credentials value) {  },),
    MyMap(),
    // Icon(
    //   Icons.chat,
    //   size: 150,
    // ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: _pages.elementAt(_selectedIndex), //New
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Offers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
      ],
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
    ),
  );
}
