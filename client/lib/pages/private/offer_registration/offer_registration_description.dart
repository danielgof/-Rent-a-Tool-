import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'offer_registration_contacts.dart';

class OfferRegistrationDescriptionPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<OfferRegistrationDescriptionPage> {
  DateTime date_start = DateTime.now();
  DateTime date_finish = DateTime.now();

  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date_start,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date_start) {
      setState(() {
        date_start = pickedDate;
      });
    }
  }

  Future<void> _selectDateFinish(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date_finish,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date_finish) {
      setState(() {
        date_finish = pickedDate;
      });
    }
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: Column(
                children: <Widget>[
                  Text(date_start.toString()),
                  ElevatedButton(
                    onPressed: () => _selectDateStart(context),
                    child: const Text('Select start date'),
                  ),
                ],
              )
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: Column(
                  children: <Widget>[
                    Text(date_finish.toString()),
                    ElevatedButton(
                      onPressed: () => _selectDateFinish(context),
                      child: const Text('Select end date'),
                    ),
                  ],
                )
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
                      date_start: date_start.toString(),
                      date_finish: date_finish.toString(),
                    ),
                    ),
                  );
                },
                child: const Text('Next step.',
                    style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}