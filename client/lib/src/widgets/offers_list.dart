import 'package:RT/src/models/offer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class OffersList extends StatelessWidget {
  final ValueChanged<Offer>? onTap;
  final List<Offer> offers;

  const OffersList({
    required this.offers,
    this.onTap,
    super.key,
  });

  // Future<List<Offer>> getOffersRequest() async {
  //   String url = "http://localhost:5000/api/v1/offer/all_all";
  //   final response = await http.get(Uri.parse(url),
  //     headers: {
  //       HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
  //     },);
  //
  //   var responseData = json.decode(response.body);
  //   List<Offer> offers = [];
  //   for (var offer in responseData["data"]) {
  //     Offer offerTmp = Offer(
  //         id: offer["id"],
  //         toolName: offer["tool_name"],
  //         toolDescription: offer["tool_description"],
  //         price: offer["price"]);
  //     //Adding user to the list.
  //     offers.add(offerTmp);
  //   }
  //   return offers;
  // }

  @override
  Widget build(BuildContext context) =>
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
