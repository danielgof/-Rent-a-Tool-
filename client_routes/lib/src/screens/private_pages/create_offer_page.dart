import 'dart:convert';
import 'dart:io';
import 'package:RT/api/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OfferRegistrationPage extends StatelessWidget {
  OfferRegistrationPage({Key? key}) : super(key: key);

  Future<int> offerRegistrationRequest(toolName, toolDescription, location, price, dateStart, dateFinish, ownerName, phoneNumber) async {
    String url = "$URL/api/v1/offer/save";
    Map credits = {
      "tool_description": toolDescription,
      "tool_name": toolName,
      "location":location,
      "price":price,
      "date_start":dateStart,
      "date_finish":dateFinish,
      "owner_name":ownerName,
      "phone_number":phoneNumber,
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), body: bodyData, headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    });
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
        appBar: AppBar(
          title: const Text("Offer registration."),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Card(
              child: Container(
                constraints: BoxConstraints.loose(const Size(600, 600)),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Offer Registration'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextField(
                        controller: tool_nameController,
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),),
                            border: OutlineInputBorder(),
                            labelText: 'tool name',
                            hintText: 'Enter tool name'
                        ),
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'tool description',
                            hintText: 'tool description'
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'location',
                            hintText: 'location'
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'price',
                            hintText: 'price'
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),),
                            border: OutlineInputBorder(),
                            labelText: 'date_start',
                            hintText: 'date_start'
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'date_finish',
                            hintText: 'date_finish'),
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'owner_name',
                            hintText: 'owner_name'),
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
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'phone_number',
                            hintText: 'phone_number'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () async {
                          var toolName = tool_nameController.text;
                          var toolDescription = tool_descriptionController.text;
                          var location = locationController.text;
                          var price = priceController.text;
                          var dateStart = date_startController.text;
                          var dateFinish = date_finishController.text;
                          var ownerName = owner_nameController.text;
                          var phoneNumber = phone_numberController.text;
                          if (toolName != "" && toolDescription != "" && location != "" && price != "" && dateStart != "" && dateFinish != ""
                              && ownerName != "" && phoneNumber != "") {
                            var status = await offerRegistrationRequest(toolName, toolDescription, location, price, dateStart, dateFinish, ownerName, phoneNumber);
                            if (200 == status) {
                              showDialog<String>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Success!'),
                                  content: const Text('Offer was crated.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK',
                                          style: TextStyle(color: Colors.blue)
                                      ),
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
                                  content: const Text('The error occurred when register an offer.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK',
                                        style: TextStyle(color: Colors.blue)
                                      ),
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
                                content: const Text('Enter valid data.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK',
                                        style: TextStyle(color: Colors.blue
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Register',
                          style: TextStyle(color: Colors.blue
                          )
                        ),
                      ),
                    ),
                  ],
                ), // Column
              ),
            )
        )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text("Offer registration."),
  //         backgroundColor: const Color.fromARGB(255, 65, 203, 83),
  //       ),
  //     body: Center(
  //       child: Card(
  //       child: Container(
  //       constraints: BoxConstraints.loose(const Size(600, 600)),
  //       padding: const EdgeInsets.all(8),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Text('Offer Registration'),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //                controller: tool_nameController,
  //                cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //                decoration: const InputDecoration(
  //                labelStyle: TextStyle(color: Colors.green),
  //                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),),
  //                border: OutlineInputBorder(),
  //                labelText: 'tool name',
  //                hintText: 'Enter tool name'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: tool_descriptionController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //                   ),
  //                border: OutlineInputBorder(),
  //                labelText: 'tool description',
  //                hintText: 'tool description'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: locationController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //                   ),
  //                border: OutlineInputBorder(),
  //                labelText: 'location',
  //                hintText: 'location'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: priceController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //                   ),
  //                border: OutlineInputBorder(),
  //                labelText: 'price',
  //                hintText: 'price'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: date_startController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),),
  //                border: OutlineInputBorder(),
  //                labelText: 'date_start',
  //                hintText: 'date_start'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: date_finishController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //               ),
  //               border: OutlineInputBorder(),
  //               labelText: 'date_finish',
  //               hintText: 'date_finish'),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: owner_nameController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //                   ),
  //                   border: OutlineInputBorder(),
  //                   labelText: 'owner_name',
  //                   hintText: 'owner_name'),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 15.0, right: 15.0, top: 15, bottom: 0),
  //             child: TextField(
  //               cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //               controller: phone_numberController,
  //               decoration: const InputDecoration(
  //                   labelStyle: TextStyle(color: Colors.green),
  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0),
  //                   ),
  //                   border: OutlineInputBorder(),
  //                   labelText: 'phone_number',
  //                   hintText: 'phone_number'),
  //             ),
  //           ),
  //         Padding(
  //           padding: const EdgeInsets.all(10),
  //           child: TextButton(
  //             onPressed: () async {
  //               var toolName = tool_nameController.text;
  //               var toolDescription = tool_descriptionController.text;
  //               var location = locationController.text;
  //               var price = priceController.text;
  //               var dateStart = date_startController.text;
  //               var dateFinish = date_finishController.text;
  //               var ownerName = owner_nameController.text;
  //               var phoneNumber = phone_numberController.text;
  //               if (toolName != "" && toolDescription != "" && location != "" && price != "" && dateStart != "" && dateFinish != ""
  //                   && ownerName != "" && phoneNumber != "") {
  //                 var status = await offerRegistrationRequest(toolName, toolDescription, location, price, dateStart, dateFinish, ownerName, phoneNumber);
  //                 if (200 == status) {
  //                   showDialog<String>(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                       title: const Text('Success!'),
  //                       content: const Text('Offer was crated.'),
  //                       actions: [
  //                         TextButton(
  //                           onPressed: () => Navigator.pop(context, 'OK'),
  //                           child: const Text('OK',
  //                               style: TextStyle(color: Color.fromARGB(255, 65, 203, 83)
  //                               )
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                   // Navigator.pushNamed(context, '/user_offers');
  //                 } else {
  //                   showDialog<String>(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                       title: const Text('Error!'),
  //                       content: const Text('The error occurred when register an offer.'),
  //                       actions: [
  //                         TextButton(
  //                           onPressed: () => Navigator.pop(context, 'OK'),
  //                           child: const Text('OK',
  //                               style: TextStyle(color: Color.fromARGB(255, 65, 203, 83)
  //                               )
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }
  //               } else {
  //                 showDialog<String>(
  //                   context: context,
  //                   builder: (context) => AlertDialog(
  //                     title: const Text('Error!'),
  //                     content: const Text('Enter valid data.'),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context, 'OK'),
  //                         child: const Text('OK',
  //                             style: TextStyle(color: Color.fromARGB(255, 65, 203, 83)
  //                             )
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }
  //             },
  //             child: const Text('Register',
  //                 style: TextStyle(color: Color.fromARGB(255, 65, 203, 83)
  //                 )
  //             ),
  //           ),
  //          ),
  //         ],
  //       ), // Column
  //      ),
  //     )
  //    )
  //   );
  // }
}
