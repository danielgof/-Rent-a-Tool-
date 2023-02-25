import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OfferRegistrationPage extends StatelessWidget {
  OfferRegistrationPage({Key? key}) : super(key: key);

  Future<int> offerRegistrationRequest(tool_name, tool_description, location, price, date_start, date_finish, owner_name, phone_number) async {
    String url = "http://localhost:5000/api/v1/offer/save";
    // Map credits = {
    //   "tool_name": tool_name,
    //   "tool_description": tool_description,
    //   "location":location,
    //   "price":price,
    //   "date_start":date_start,
    //   "date_finish":date_finish,
    //   "owner_name":owner_name,
    //   "phone_number":phone_number,
    // };
    Map credits = {
      "tool_name": "test",
      "tool_description": "test test",
      "location": "test, test",
      "price": "test",
      "date_start": "03/01/2001",
      "date_finish": "03/02/2001",
      "owner_name": "test",
      "phone_number": "+1343452243"
    };
    var body_data = json.encode(credits);
    print(body_data);
    final response = await http.post(Uri.parse(url), body: body_data, headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    });
    var responseData = json.decode(response.body);
    print(responseData);
    var data = response.statusCode;
    return data;
  }
  TextEditingController tool_nameController = TextEditingController();
  TextEditingController tool_descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController date_startController = TextEditingController();
  TextEditingController date_finishController = TextEditingController();
  TextEditingController owner_nameController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Rent a Tool'),
      //   backgroundColor: Color.fromARGB(255, 76, 173, 175),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(
      //         Icons.home,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         Navigator.pushNamed(context, '/');
      //       },
      //     )
      //   ],
      // ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Offer Registration'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: tool_nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'tool name',
                    hintText: 'Enter tool name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: tool_descriptionController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'tool description',
                    hintText: 'tool description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'location',
                    hintText: 'location'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'price',
                    hintText: 'price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: date_startController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'date_start',
                    hintText: 'date_start'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: date_finishController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'date_finish',
                    hintText: 'date_finish'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: owner_nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'owner_name',
                    hintText: 'owner_name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: phone_numberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'phone_number',
                    hintText: 'phone_number'),
              ),
            ),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () async {
                var tool_name = tool_nameController.text;
                var tool_description = tool_descriptionController.text;
                var location = locationController.text;
                var price = priceController.text;
                var date_start = date_startController.text;
                var date_finish = date_finishController.text;
                var owner_name = owner_nameController.text;
                var phone_number = phone_numberController.text;
                var status = await offerRegistrationRequest(tool_name, tool_description, location, price, date_start, date_finish, owner_name, phone_number);
                if (200 == status) {
                  showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Succes!'),
                      content: const Text('Offer was added.'),
                      actions: [
                        // TextButton(
                        // 	onPressed: () => Navigator.pop(context, 'Cancel'),
                        // 	child: const Text('Cancel'),
                        // ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  // Navigator.pushNamed(context, '/user_offers');
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error!'),
                      content: const Text('The error occured when register an offer.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
