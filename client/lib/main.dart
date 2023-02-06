import 'dart:convert';
import 'dart:io';
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
			'/third': (context) => const ThirdRoute(),
		},
	)); //MaterialApp
}

class HomeRoute extends StatelessWidget {
	const HomeRoute({Key? key}) : super(key: key);
	Future<LoginUser> getRequest() async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/auth/login";
		Map credits = {
			"username": "JL",
			"password": "NCC-1701-D"
		};
		var body_data = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: body_data);
			// Send authorization headers to the backend.
			// headers: {
			// 	HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
			// },);

		var responseData = json.decode(response.body);
		print(responseData);
		// var offersResponce = responseData["responce"];
		// print(offersResponce);
		//Creating a list to store input data;
		var data = json.decode(response.body);
		return data;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Geeks for Geeks'),
				backgroundColor: Colors.green,
			), // AppBar
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						ElevatedButton(
							child: const Text('Click Me!'),
							onPressed: () {
								Navigator.pushNamed(context, '/second');
							},
						), // ElevatedButton
						ElevatedButton(
							child: const Text('Tap Me!'),
							onPressed: () {
								getRequest();
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


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
// 	@override
// 	Widget build(BuildContext context) {
// 		return MaterialApp(
// 			home: OfferPage(),
// 		);
// 	}
// }

// class MyApp extends StatelessWidget {
// 	@override
// 	Widget build(BuildContext context) {
// 		return MaterialApp(
// 			home: HomePage(),
// 		);
// 	}
// }



