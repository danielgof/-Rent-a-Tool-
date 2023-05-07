import 'package:flutter/material.dart';

import 'main_page_private.dart';


class UserDetailsPage extends StatefulWidget {

  const UserDetailsPage({
    super.key,
  });

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

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
              Text('User\' profile page',
                  style: Theme.of(context).textTheme.headlineMedium),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://www.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg"),
                    maxRadius: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "User's first name",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "User's last name",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ].map((widget) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: widget,
                )).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivateMain()
                      ),
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
