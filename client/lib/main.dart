import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'package:mobile/pages/alloffers_page.dart';

import './pages/offers_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './pages/main_page.dart';
import './models/login_user.dart';

void main() {
	runApp(MaterialApp(
		initialRoute: '/',
		routes: {
			'/': (context) => const HomeRoute(),
			'/second': (context) => OfferPage(),
			'/third': (context) => AllOffersPage(),
		},
	)); //MaterialApp
}

class HomeRoute extends StatelessWidget {
	const HomeRoute({Key? key}) : super(key: key);
	Future<int> getRequest() async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/auth/login";
		Map credits = {
			"username": "JL",
			"password": "NCC-1701-D"
		};
		var body_data = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: body_data);
		var responseData = json.decode(response.body);
		var data = response.statusCode;
		return data;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Rent a Tool'),
				backgroundColor: Color.fromARGB(255, 76, 173, 175),
			), // AppBar
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						ElevatedButton(
							child: const Text('All offers'),
							onPressed: () {
								print("test");
								Navigator.pushNamed(context, '/third');
							},
						), // ElevatedButton
						ElevatedButton(
							child: const Text('Login'),
							onPressed: () async {
								var status = await getRequest();
								// print("status");
								// print(status);
								if (200 == status) {
									Navigator.pushNamed(context, '/second');
								} else {
									print("incorrect data");
								}
							},
						), // ElevatedButton
					], // <Widget>[]
				), // Column
			), // Center
		); // Scaffold
	}
}

class SecondRoute extends StatelessWidget {
	const SecondRoute({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Click Me Page"),
				backgroundColor: Colors.green,
			), // AppBar
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						Navigator.pop(context);
					},
					child: const Text('Back!'),
				), // ElevatedButton
			), // Center
		); // Scaffold
	}
}

class ThirdRoute extends StatelessWidget {
	const ThirdRoute({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Tap Me Page"),
				backgroundColor: Colors.green,
			), // AppBar
		); // Scaffold
	}
}
