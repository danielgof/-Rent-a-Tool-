import 'package:flutter/material.dart';

import '../../models/credentials.dart';
import 'loginPage.dart';
import 'mapPage.dart';
import 'offers_page.dart';

class PublicMain extends StatefulWidget {
  const PublicMain({Key? key}) : super(key: key);

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
    const AllOffersPublicPage(),
    SignInScreen(
      onSignIn: (Credentials value) {},
      isAuth: false,
    ),
    SimpleMap(),
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
              label: "Offers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: "Login",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      );
}
