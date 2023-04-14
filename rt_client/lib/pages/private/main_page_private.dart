import 'package:flutter/material.dart';

import '../public/main_page_public.dart';
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
    OffersPrivatePage(),
    MyMapPrivate(),
  ];

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('RT'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage("https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="),
                    maxRadius: 20,
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublicMain(),
                      ),
                    );
                  },
                  child: const Icon(Icons.logout),
                )
            ),

            ],
          ),
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
