import 'dart:convert';
import 'dart:io';
import '../../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
	@override
	_MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
//Applying get request.
	Future<List<Offer>> getOffersRequest() async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/offer/all_all";
		final response = await http.get(Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
    },);
		var responseData = json.decode(response.body);
    print(responseData);
		List<Offer> offers = [];
		for (var offer in responseData) {
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
					title: Text('Rent a Tool'),
					backgroundColor: Color.fromARGB(255, 76, 173, 175),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
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