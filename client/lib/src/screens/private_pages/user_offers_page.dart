import 'dart:convert';
import 'dart:io';
import '../../../api/url.dart';
import '../../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OfferPage extends StatefulWidget {
	@override
	_OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {

	Future<List<Offer>> getRequest() async {
		String url = "$URL/api/v1/offer/all";
		final response = await http.get(Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    },);

		var responseData = json.decode(response.body);
		List<Offer> offers = [];
		for (var offer in responseData['result']) {
			Offer offerTmp = Offer(
        id: offer["id"],
        toolName: offer["tool_name"],
        toolDescription: offer["tool_description"],
        price: offer["price"],
				dateStart: offer["date_start"],
				dateFinish: offer["date_finish"],
				ownerName: offer["owner_name"],
				phoneNumber: offer["phone_number"],
				location: offer["location"],
				lat: offer["lat"],
				lng: offer["lng"],
			);
			offers.add(offerTmp);
		}
		return offers;
	}

	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				appBar: AppBar(
					title: const Text("Offers"),
					backgroundColor: const Color.fromARGB(255, 65, 203, 83),
					actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            )
          ],
				),
				body: Container(
					padding: const EdgeInsets.all(16.0),
					child: FutureBuilder(
						future: getRequest(),
						builder: (BuildContext ctx, AsyncSnapshot snapshot) {

							if (snapshot.data == null) {
								return const Center(
									child: CircularProgressIndicator(),
								);
							} else {
								return ListView.builder(
									itemCount: snapshot.data.length,
									itemBuilder: (ctx, index) => ListTile(
										// title: Text(snapshot.data[index].title),
										subtitle: Text(snapshot.data[index].toolName),
										contentPadding: const EdgeInsets.only(bottom: 20.0),
									),
								);
							}
						},
					),
				),
			),
		);
	}
}