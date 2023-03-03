import 'dart:convert';
import 'dart:io';
import '../../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllOffersPage extends StatefulWidget {
	@override
	_AllOffersPageState createState() => _AllOffersPageState();
}

class _AllOffersPageState extends State<AllOffersPage> {

	Future<List<Offer>> getOffersRequest() async {
		String url = "http://localhost:5000/api/v1/offer/all_all";
		final response = await http.get(Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    },);

		var responseData = json.decode(response.body);
		List<Offer> offers = [];
		for (var offer in responseData["data"]) {
			Offer offerTmp = Offer(
        id: offer["id"],
        toolName: offer["tool_name"],
        toolDescription: offer["tool_description"],
        price: offer["price"]);
			offers.add(offerTmp);
		}
		return offers;
	}

	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				bottomNavigationBar: BottomAppBar(
					child: Row(
						mainAxisSize: MainAxisSize.max,
						children: <Widget>[
							IconButton(icon: const Icon(Icons.local_offer), onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => AllOffersPage()
									),
								);
							},),
							IconButton(icon: const Icon(Icons.login), onPressed: () {
								Navigator.pop(context);
							},),
						],
					),
				),
				body: Container(
					padding: const EdgeInsets.all(16.0),
					child: FutureBuilder(
						future: getOffersRequest(),
						builder: (BuildContext ctx, AsyncSnapshot snapshot) {

							if (snapshot.data == null) {
								return const Center(
									child: CircularProgressIndicator(),
								);
							} else {
								return ListView.builder(
									itemCount: snapshot.data.length,
									itemBuilder: (ctx, index) => ListTile(
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