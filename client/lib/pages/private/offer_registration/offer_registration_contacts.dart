import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../main_page_private.dart';
import '../../../api/utils.dart';
import 'offer_registration_description.dart';

// ignore: must_be_immutable
class OfferRegistrationContactsPage extends StatefulWidget {
  String toolName;
  String toolDescription;
  String price;
  String dateStart;
  String dateFinish;

  OfferRegistrationContactsPage({super.key,
    required this.toolName,
    required this.toolDescription,
    required this.price,
    required this.dateStart,
    required this.dateFinish,
  });

  @override
  State<OfferRegistrationContactsPage> createState() => _OfferRegistrationContactsPageState();
}

class _OfferRegistrationContactsPageState extends State<OfferRegistrationContactsPage> {

  @override
  void initState() {
    super.initState();
  }

  // Extraction username of current user from JWT
  final String username = JWT.decode(TOKEN).payload["username"];

  AlertDialog alert = const AlertDialog(
    title: Text("Offer was created successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<int> _registrationRequest(toolName, toolDescription, price,
      dateStart, dateFinish, lat, lng, ownerName, phoneNumber) async {
    String url = "$URL/api/v1/offer/save";
    Map<String, String> credits = {
      "tool_name": toolName,
      "tool_description": toolDescription,
      "price": price,
      "date_start": dateStart,
      "date_finish": dateFinish,
      "lat": lat,
      "lng": lng,
      "owner_name": ownerName,
      "phone_number": phoneNumber,
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
      TOKEN,
    }, body: bodyData);
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
      throw Exception('Failed to delete post');
    }
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter other details.',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: latController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Latitude',
                          hintText: 'Enter your latitude.'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: lngController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Latitude',
                          hintText: 'Enter your latitude.'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Phone number',
                          hintText: 'Enter your phone number.'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(onPressed: () {
                      _registrationRequest(
                        widget.toolName,
                        widget.toolDescription,
                        widget.price,
                        widget.dateStart,
                        widget.dateFinish,
                        latController.value.text,
                        lngController.value.text,
                        username,
                        phoneNumberController.value.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivateMain(),
                        ),
                      );
                    },
                      child:
                      const Text('Register offer.',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (
                              context) => const OfferRegistrationDescriptionPage()
                          ),
                        );
                      },
                      child: const Text('Return to previous step.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
