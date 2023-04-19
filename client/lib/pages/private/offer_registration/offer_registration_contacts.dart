import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../main_page_private.dart';
import '../../../utils.dart';
import '../offers_page.dart';


class OfferRegistrationContactsPage extends StatefulWidget {
  String tool_name;
  String tool_description;
  String location;
  String price;
  String date_start;
  String date_finish;

  OfferRegistrationContactsPage({super.key,
    required this.tool_name,
    required this.tool_description,
    required this.location,
    required this.price,
    required this.date_start,
    required this.date_finish,
  });


  @override
  State<OfferRegistrationContactsPage> createState() => _OfferRegistrationContactsPageState();
}

class _OfferRegistrationContactsPageState extends State<OfferRegistrationContactsPage> {

  @override
  void initState() {
    super.initState();
  }


  Future<int> registrationRequest(tool_name, tool_description, location, price,
      date_start, date_finish, lat, lng, owner_name, phone_number) async {
    String url = "$URL/api/v1/offer/save";
    Map credits = {
      "tool_name": tool_name,
      "tool_description": tool_description,
      "location": location,
      "price": price,
      "date_start": date_start,
      "date_finish": date_finish,
      "lat": lat,
      "lng": lng,
      "owner_name": owner_name,
      "phone_number": phone_number
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
      TOKEN,
    }, body: bodyData);
    var data = response.statusCode;
    return data;
  }

  TextEditingController owner_nameController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();


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
              Text('Enter other details.',
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: latController,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
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
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
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
                  controller: owner_nameController,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name.'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: phone_numberController,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
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
                    registrationRequest(
                      widget.tool_name,
                      widget.tool_description,
                      widget.location,
                      widget.price,
                      widget.date_start,
                      widget.date_finish,
                      latController.value.text,
                      lngController.value.text,
                      owner_nameController.value.text,
                      phone_numberController.value.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivateMain()
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
                child: ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivateMain()
                    ),
                  );
                },
                  child:
                  const Text('Return to previous step.',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
