import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils.dart';


class OfferRegistrationPage extends StatelessWidget {
  OfferRegistrationPage({Key? key}) : super(key: key);

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
    print(bodyData);
    final response = await http.post(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader:
    TOKEN,
    }, body: bodyData);
    var data = response.statusCode;
    print(data);
    return data;
  }

  TextEditingController tool_nameController = TextEditingController();
  TextEditingController tool_descriptionController = TextEditingController();
  TextEditingController owner_nameController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController date_startController = TextEditingController();
  TextEditingController date_finishController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: <Widget>[
                Text('Offer registration',
                  style: Theme.of(context).textTheme.headlineMedium),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: tool_nameController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Tool name',
                        hintText: 'Enter tool name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: tool_descriptionController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Tool description',
                        hintText: 'Enter detailed description of the tool'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: locationController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Location',
                        hintText: 'Enter location'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: priceController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                        hintText: 'Enter price'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: date_startController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Date start',
                        hintText: 'Enter date_start'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: date_finishController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Date finish',
                        hintText: 'Enter date finish'
                    ),
                  ),
                ),
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
                        labelText: 'Lat',
                        hintText: 'Enter lat'
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
                        labelText: 'Lng',
                        hintText: 'Enter lng'
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
                        labelText: 'Owner name',
                        hintText: 'Enter owner name'
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
                        hintText: 'Enter phone number'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: TextButton(
                    onPressed: () async {
                      var tool_name = tool_nameController.text;
                      var tool_description = tool_descriptionController.text;
                      var location = locationController.text;
                      var price = priceController.text;
                      var date_start = date_startController.text;
                      var date_finish = date_finishController.text;
                      var lat = latController.text;
                      var lng = lngController.text;
                      var owner_name = owner_nameController.text;
                      var phone_number = phone_numberController.text;
                      var status = await registrationRequest(tool_name, tool_description, location, price,
                          date_start, date_finish, lat, lng, owner_name, phone_number);
                      if (tool_name != "" && tool_description != "" && date_start != "" && phone_number != "") {
                        if (200 == status) {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Success!'),
                              content: const Text('The user was registered successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error!'),
                              content: const Text('The error occurred when register a user.'),
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
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error!'),
                            content: const Text('All fields should be filled in order to register.'),
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
                    },
                    child: const Text('Register.',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),
            ]
        )
    );
  }
}
