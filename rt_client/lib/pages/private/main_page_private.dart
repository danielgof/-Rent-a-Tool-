import 'package:flutter/material.dart';

import '../../models/credentials.dart';
import 'map_offers_private.dart';
import 'offers_page.dart';


class PrivateMain extends StatefulWidget {

  @override
  State<PrivateMain> createState() => _PrivateMainScreenState();
}

class _PrivateMainScreenState extends State<PrivateMain> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    AllOffersPrivatePage(),
    MyMapPrivate(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBar(
    //   title: const Text('TabBar Widget'),
    //   bottom: const TabBar(
    //     // controller: _tabController,
    //     tabs: <Widget>[
    //       Tab(
    //         icon: Icon(Icons.cloud_outlined),
    //       ),
    //       Tab(
    //         icon: Icon(Icons.beach_access_sharp),
    //       ),
    //       Tab(
    //         icon: Icon(Icons.brightness_5_sharp),
    //       ),
    //     ],
    //   ),
    // ),
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
          icon: Icon(Icons.map),
          label: 'Map',
        ),
      ],
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
    ),
  );
}
