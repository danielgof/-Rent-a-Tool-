import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:client/pages/private/settings_page.dart';
import 'package:client/pages/private/user_details_page.dart';
import 'package:client/pages/private/user_offers.dart';

import '../../api/utils.dart';
import '../public/main_page_public.dart';
import 'all_offers_page.dart';
import 'chat_page.dart';
import 'map_offers_private.dart';
import 'offer_registration/offer_registration_description.dart';

class PrivateMain extends StatefulWidget {
  int selectedIndex;
  bool isAuth;
  PrivateMain({
    super.key,
    required this.selectedIndex,
    required this.isAuth,
  });

  @override
  State<PrivateMain> createState() => _PrivateMainScreenState(
        selectedIndex: this.selectedIndex,
        isAuth: this.isAuth,
      );
}

class _PrivateMainScreenState extends State<PrivateMain> {
  int selectedIndex;
  bool isAuth;
  _PrivateMainScreenState({
    required this.selectedIndex,
    required this.isAuth,
  });

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const AllOffersPrivatePage(),
    MyMapPrivate(),
    const ChatPage(),
    const UserOffersPage(),
    const OfferRegistrationDescriptionPage()
  ];

  @override
  Widget build(BuildContext context) {
    if (isAuth == true) {
      return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: const Text("RT"),
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          // UserPage(),
                          UserDetailsPage(),
                    ),
                  );
                },
                child: CircleAvatar(
                  child: Image.asset("assets/placeholders/user.png"),
                ),
                // FutureBuilder<String>(
                //   future: fetchImageBytes(),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<String> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircleAvatar(
                //         child: Image.asset("assets/placeholders/user.png"),
                //       );
                //     } else if (snapshot.hasError) {
                //       return CircleAvatar(
                //         child: Image.asset("assets/placeholders/user.png"),
                //       );
                //     } else if (snapshot.hasData) {
                //       Uint8List bytesImage =
                //           const Base64Decoder().convert(snapshot.data!);
                //       // print(bytesImage);
                //       return CircleAvatar(
                //         backgroundImage: MemoryImage(bytesImage),
                //       );
                //     } else {
                //       return Text('No image data');
                //     }
                //   },
                // ),
              ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAuth = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PublicMain(),
                    ),
                  );
                },
                child: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: Center(
          child: _pages.elementAt(selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: "Offers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "My chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books),
              label: "My offers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Create offer',
            ),
          ],
          currentIndex: selectedIndex, //New
          onTap: _onItemTapped,
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("You have not been authorized.",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PublicMain()),
                        );
                      },
                      child: const Text("Return to home page.",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
