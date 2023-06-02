import 'package:flutter/material.dart';
import 'package:rt_client/pages/private/settings_page.dart';
import 'package:rt_client/pages/private/user_details_page.dart';
import 'package:rt_client/pages/private/user_offers.dart';

import '../public/main_page_public.dart';
import 'all_offers_page.dart';
import 'chat_page.dart';
import 'map_offers_private.dart';
import 'offer_registration/offer_registration_description.dart';


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
    const AllOffersPrivatePage(),
    // MyMapPrivate(),
    const ChatPage(),
    const UserOffersPage(),
    const OfferRegistrationDescriptionPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RT'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserDetailsPage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"),
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
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                child: const Icon(Icons.settings),
              )
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PublicMain(),
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
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'My chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'My offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create offer',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}
