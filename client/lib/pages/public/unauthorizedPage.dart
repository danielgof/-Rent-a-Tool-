import 'package:flutter/material.dart';

import 'mainPagePublic.dart';

class UnauthorizedScreen extends StatefulWidget {
  const UnauthorizedScreen({super.key});

  @override
  State<UnauthorizedScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<UnauthorizedScreen> {

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
              Text('You have not been authorized.',
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PublicMain()
                      ),
                    );
                  },
                  child: const Text('Return to home page.',
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
