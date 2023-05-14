import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';

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

  FocusNode funame = FocusNode();
  FocusNode fphone = FocusNode();
  FocusNode femail = FocusNode();
  FocusNode fpass = FocusNode();

  // Extraction username of current user from JWT
  String username = JWT.decode(TOKEN).payload["username"];
  String phone = "+19994567834";
  String email = "picard23@hooli.com";
  String pass = "1234";

  var unameController = TextEditingController(text: JWT.decode(TOKEN).payload["username"]);
  var emailController = TextEditingController(text: "picard23@hooli.com");
  var phoneController = TextEditingController(text: "+19994567834");
  var passController = TextEditingController(text: "1234");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              const Text(
                                "Username: ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              EditableText(
                                controller: unameController,
                                focusNode: funame,
                                style: const TextStyle(fontSize: 20.0),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue,
                              ),
                            ].map((widget) => Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: widget,
                                ))).toList(),
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              const Text(
                                "Email: ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              EditableText(
                                controller: emailController,
                                focusNode: femail,
                                style: const TextStyle(fontSize: 20.0),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue,
                              ),
                            ].map((widget) => Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: widget,
                                ))).toList(),),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              const Text(
                                "Phone: ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              EditableText(
                                controller: phoneController,
                                focusNode: fphone,
                                style: const TextStyle(fontSize: 20.0),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue,
                              ),
                            ].map((widget) => Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: widget,
                                ))).toList(),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              const Text(
                                "Pass: ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              EditableText(
                                controller: passController,
                                focusNode: fpass,
                                style: const TextStyle(fontSize: 20.0),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue,
                              ),
                            ].map((widget) => Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: widget,
                                ))).toList(),),
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
                    child: TextButton(onPressed: () {
                      print("clicked");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PrivateMain(),
                      //   ),
                      // );
                    },
                    child: const Text('UPD INFO',
                        style: TextStyle(color: Colors.blue,
                          fontSize: 35,
                        ),
                      ),
                    ),
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
}
