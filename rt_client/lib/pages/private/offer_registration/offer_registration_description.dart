import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils.dart';
import 'offer_registration_contacts.dart';


class OfferRegistrationDescriptionPage extends StatelessWidget {
  OfferRegistrationDescriptionPage({Key? key}) : super(key: key);

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
            child:
            TextField(
                controller: date_startController, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                ),
                readOnly: true,  // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  print("pickedDate" + pickedDate.toString());
                }
            )
            // TextField(
            //   cursorColor: Colors.blue,
            //   controller: date_startController,
            //   decoration: const InputDecoration(
            //       labelStyle: TextStyle(color: Colors.blue),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey, width: 0.0),
            //       ),
            //       border: OutlineInputBorder(),
            //       labelText: 'Date start',
            //       hintText: 'Enter date_start'
            //   ),
            // ),
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
            padding: const EdgeInsets.all(6),
            child: TextButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfferRegistrationContactsPage(
                    tool_name: tool_nameController.value.text,
                    tool_description: tool_descriptionController.value.text,
                    location: locationController.value.text,
                    price: priceController.value.text,
                    date_start: date_startController.value.text,
                    date_finish: date_finishController.value.text,
                    ),
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => OfferRegistrationContactsPage(
                //       tool_name: "tool_nameController.text",
                //       tool_description: "tool_descriptionController.text",
                //     ),
                //   ),
                // );
              },
              child: const Text('Next step.',
                  style: TextStyle(color: Colors.blue)),
            ),
          ),
        ]
      )
    );
  }
}
