import 'package:RT/src/screens/private_pages/create_offer_page.dart';
import 'package:RT/src/screens/private_pages/user_offers_page.dart';
import 'package:flutter/material.dart';

class AuthorsScreen extends StatelessWidget {
  final String title = 'Profile';

  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OfferRegistrationPage()
                    ),
                  );
                },
                child: const Text('Create new offer.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OfferPage()
                    ),
                  );
                },
                child: const Text('My offers.'),
              ),
            ),
            ],
          ),
        ),
      ),
    ),
  );
}
