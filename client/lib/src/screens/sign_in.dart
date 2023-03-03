import 'package:RT/src/screens/public_pages/alloffers_public_page.dart';
import 'package:RT/src/screens/public_pages/registration_page.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(icon: const Icon(Icons.local_offer), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllOffersPage()
              ),
            );
          },),
          IconButton(icon: const Icon(Icons.login), onPressed: () {},),
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
              TextField(
                decoration: const InputDecoration(labelText: 'Username'),
                controller: _usernameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () async {
                    if (_usernameController.value.text != "" && _passwordController.value.text != "") {
                      widget.onSignIn(Credentials(
                          _usernameController.value.text,
                          _passwordController.value.text)
                      );
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error!',
                              style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
                          content: const Text('All fields should be filled in order to login.',
                              style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK',
                                  style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Color.fromARGB(255, 65, 203, 83)),
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
                    style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
