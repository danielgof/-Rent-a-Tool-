import 'dart:convert';
import 'dart:io';
import '../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OfferPage extends StatefulWidget {
	@override
	_OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
//Applying get request.
	Future<List<Offer>> getRequest() async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/offer/all";
		final response = await http.get(Uri.parse(url),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    },);

		var responseData = json.decode(response.body);
    print(responseData['result']);
    // var offersResponce = responseData["responce"];
    // print(offersResponce);
		//Creating a list to store input data;
		List<Offer> offers = [];
		for (var offer in responseData['result']) {
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
				appBar: AppBar(
					title: Text("Offers"),
					actions: <Widget>[
            IconButton(
              icon: Icon(
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
					padding: EdgeInsets.all(16.0),
					child: FutureBuilder(
						future: getRequest(),
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