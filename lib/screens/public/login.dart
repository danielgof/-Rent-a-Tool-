import 'dart:convert';
import 'package:RT/screens/public/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils.dart';
import '../private/offers.dart';
import 'mapOffers.dart';
import 'offers.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class SignInScreen extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInScreen({
    required this.onSignIn,
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<int> loginRequest(login, pass) async {
    String url = "$URL/api/v1/auth/login";
    Map credits = {
      "username": login,
      "password": pass
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), body: bodyData);
    var data = response.statusCode;
    return data;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(icon: const Icon(Icons.local_offer), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllOffersPageState()
              ),
            );
          },),
          IconButton(icon: const Icon(Icons.login), onPressed: () {
            Navigator.pop(context);
          },),
          IconButton(icon: const Icon(Icons.map), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyMap()
              ),
            );
          },),
        ],
      ),
    ),
    body: Center(
      child: Card(
        child: Container(
          constraints: BoxConstraints.loose(const Size(600, 600)),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sign in',
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child:
                TextField(
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Username',),
                  controller: _usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child:
                TextField(
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      // cursorColor: Colors.green,
                    ),

                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () async {
                    if (_usernameController.value.text == "" && _passwordController.value.text == "") {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error!'),
                          content: const Text('All fields should be filled in order to login.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (_usernameController.value.text != "" || _passwordController.value.text != "") {
                        if (_usernameController.value.text != "" && _passwordController.value.text == "") {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error!'),
                              content: const Text('You forgot your pass.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK',
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            ),
                          );
                        }
                        if (_usernameController.value.text == "" && _passwordController.value.text != "") {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error!'),
                              content: const Text('You forgot your username.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK',
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // print(_usernameController.value.text + "     "+ _passwordController.value.text);
                          // widget.onSignIn(Credentials(
                          //     _usernameController.value.text,
                          //     _passwordController.value.text)
                          // );
                          var login = _usernameController.value.text;
                          var pass = _passwordController.value.text;
                          var status = await loginRequest(login, pass);
                          if (status == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AllOffersPrivatePage(isAuth: true,)
                              ),
                            );
                          } else {

                          }
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()
                      ),
                    );
                  },
                  child: const Text('New user? Click to register.',
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