import 'package:RT/src/screens/public_pages/alloffers_public_page.dart';
import 'package:RT/src/screens/pages/registration_page.dart';
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
    // appBar: AppBar(title: const Text('Bottom App Bar')),
    bottomNavigationBar: BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.local_offer), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllOffersPage()
              ),
            );
          },),
          IconButton(icon: Icon(Icons.login), onPressed: () {},),
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
                    widget.onSignIn(Credentials(
                        _usernameController.value.text,
                        _passwordController.value.text));
                  },
                  child: const Text('Sign in'),
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
                  child: const Text('New user? Click to register.'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _tabController {

}
