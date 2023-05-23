import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
  var emailController = TextEditingController(text: JWT.decode(TOKEN).payload["email"]);
  var phoneController = TextEditingController(text: JWT.decode(TOKEN).payload["phone"]);
  var passController = TextEditingController(text: JWT.decode(TOKEN).payload["pass"]);

  AlertDialog alert = const AlertDialog(
    title: Text("User's details updated successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<int> updProfile(uname, email, phone, pass) async {
    String url = "$URL/api/v1/auth/upd";
    String new_uname;
    if (uname == JWT.decode(TOKEN).payload["username"]) {
      new_uname = "";
    } else {
      new_uname = uname;
    }
    if (email == JWT.decode(TOKEN).payload["email"]) {
      email = "";
    }
    if (phone == JWT.decode(TOKEN).payload["phone"]) {
      phone = "";
    }
    if (pass == JWT.decode(TOKEN).payload["pass"]) {
      pass = "";
    }
    Map<String, String> credits = {
      "username": uname,
      "new_uname": new_uname,
      "email": email,
      "phone": phone,
      "passwd": pass,
    };
    var bodyData = json.encode(credits);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader:
        TOKEN,
      },
      body: bodyData,
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return response.statusCode;
    } else {
      throw Exception('Failed to upd user\'s info');
    }
  }

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
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
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
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
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
                                "Phone: ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              EditableText(
                                controller: phoneController,
                                focusNode: fphone,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
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
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
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
                        ],
                      ),
                    ].map((widget) => Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: widget,
                        ))).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(onPressed: () async {
                      print("clicked");
                      String uname = unameController.value.text;
                      String email = emailController.value.text;
                      String phone = phoneController.value.text;
                      String pass = passController.value.text;
                      print(uname);
                      var statusCode = updProfile(uname, email, phone, pass);
                      if (statusCode == 200) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        throw Exception('Failed to upd user\'s info');
                      }
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
                      child: const Text('Return back.', style: TextStyle(color: Colors.blue),
                      ),
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
