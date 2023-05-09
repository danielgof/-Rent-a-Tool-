import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../api/utils.dart';
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
  void initState() {
    super.initState();
  }

  // Extraction username of current user from JWT
  String username = JWT.decode(TOKEN).payload["username"];
  String name = "Jack";
  String lastname = "Picard";
  String phone = "+19994567834";
  String email = "picard23@hooli.com";

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    body: Center(
      child: SafeArea(
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
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"),
                      maxRadius: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username: $username",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "Name: $name",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "Lastname: $lastname",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "Email: $email",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "Phone: $phone",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ].map((widget) => Flexible(
                      flex: 1,
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: widget,
                  ))).toList(),
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
                    child: const Text('Return back.', style: TextStyle(color: Colors.blue),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
