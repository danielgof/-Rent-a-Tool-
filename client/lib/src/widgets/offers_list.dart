import 'package:RT/src/models/offer.dart';
// import 'package:client/src/models/offers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class OffersList extends StatelessWidget {
  // final Future<List<Offer>> offers;
  final ValueChanged<Offer>? onTap;
  final List<Offer> offers;

  const OffersList({
    required this.offers,
    this.onTap,
    super.key,
  });

  Future<List<Offer>> getOffersRequest() async {
    //replace your restFull API here.
    String url = "http://localhost:5000/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
      },);

    var responseData = json.decode(response.body);
    // print(responseData);
    // var offersResponce = responseData["responce"];
    // print(offersResponce);
    //Creating a list to store input data;
    List<Offer> offers = [];
    for (var offer in responseData["data"]) {
      Offer offerTmp = Offer(
          id: offer["id"],
          toolName: offer["tool_name"],
          toolDescription: offer["tool_description"],
          price: offer["price"]);
      //Adding user to the list.
      offers.add(offerTmp);
    }
    return offers;
  }

  @override
  Widget build(BuildContext context) =>
    //   return SafeArea(child: Scaffold(
    //     body: Container(
    //       padding: EdgeInsets.all(16.0),
    //       child: FutureBuilder(
    //         future: getOffersRequest(),
    //         builder: (BuildContext ctx, AsyncSnapshot snapshot) {
    //
    //           if (snapshot.data == null) {
    //             return Container(
    //               child: Center(
    //                 child: CircularProgressIndicator(),
    //               ),
    //             );
    //           } else {
    //             return ListView.builder(
    //               itemCount: snapshot.data.length,
    //               itemBuilder: (ctx, index) => ListTile(
    //                 // title: Text(snapshot.data[index].title),
    //                 subtitle: Text(snapshot.data[index].toolName),
    //                 contentPadding: EdgeInsets.only(bottom: 20.0),
    //               ),
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    //   );
    // }
    ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(
              offers[index].toolName,
            ),
            subtitle: Text(
              offers[index].toolDescription,
            ),
            onTap: onTap != null ? () => onTap!(offers[index]) : null,
          ),
    );
}
