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
//Applying get request.
	Future<List<Offer>> getOffersRequest() async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/offer/all_all";
		final response = await http.get(Uri.parse(url),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    },);

		var responseData = json.decode(response.body);
    print(responseData);
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
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				bottomNavigationBar: BottomAppBar(
					child: new Row(
						mainAxisSize: MainAxisSize.max,
						// mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							IconButton(icon: Icon(Icons.local_offer), onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => AllOffersPage()
									),
								);
							},),
							IconButton(icon: Icon(Icons.login), onPressed: () {
								Navigator.pop(context);
							},),
						],
					),
				),
				body: Container(
					padding: EdgeInsets.all(16.0),
					child: FutureBuilder(
						future: getOffersRequest(),
						builder: (BuildContext ctx, AsyncSnapshot snapshot) {

							if (snapshot.data == null) {
								return Container(
									child: Center(
										child: CircularProgressIndicator(),
									),
								);
							} else {
								return ListView.builder(
									itemCount: snapshot.data.length,
									itemBuilder: (ctx, index) => ListTile(
										// title: Text(snapshot.data[index].title),
										subtitle: Text(snapshot.data[index].toolName),
										contentPadding: EdgeInsets.only(bottom: 20.0),
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