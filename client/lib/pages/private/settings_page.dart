import 'package:flutter/material.dart';

import 'mainPagePrivate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Settings page',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivateMain(
                                    selectedIndex: 0,
                                    isAuth: true,
                                  )),
                        );
                      },
                      child: const Text('Return back.',
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
