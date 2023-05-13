import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'offer_registration_contacts.dart';

class OfferRegistrationDescriptionPage extends StatefulWidget {
  const OfferRegistrationDescriptionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OfferRegistrationDescriptionPage> {
  DateTime dateStart = DateTime.now();
  DateTime dateFinish = DateTime.now();

  // Function to select start date of an offer's rent
  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateStart,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      );
    if (pickedDate != null && pickedDate != dateStart) {
      setState(() {
        dateStart = pickedDate;
      });
    }
  }

  // Function to select end date of an offer's rent
  Future<void> _selectDateFinish(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateFinish,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != dateFinish) {
      setState(() {
        dateFinish = pickedDate;
      });
    }
  }

  // Text fields controllers
  TextEditingController toolNameController = TextEditingController();
  TextEditingController toolDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Offer registration',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0,
                    ),
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: toolNameController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Tool name',
                        hintText: 'Enter tool name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: toolDescriptionController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Tool description',
                        hintText: 'Enter detailed description of the tool',
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
                        hintText: 'Enter price',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${dateStart.year.toString()}-${dateStart.month.toString().padLeft(2,'0')}-${dateStart.day.toString().padLeft(2,'0')}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _selectDateStart(context),
                            child: const Text('Select start date'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${dateFinish.year.toString()}-${dateFinish.month.toString().padLeft(2,'0')}-${dateFinish.day.toString().padLeft(2,'0')}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _selectDateFinish(context),
                            child: const Text('Select end date'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfferRegistrationContactsPage(
                              toolName: toolNameController.value.text,
                              toolDescription: toolDescriptionController.value.text,
                              price: priceController.value.text,
                              dateStart: DateFormat("EEE, dd MMM yyyy ss:mm:hh").format(dateStart),
                              dateFinish: DateFormat("EEE, dd MMM yyyy ss:mm:hh").format(dateFinish),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Next step',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
