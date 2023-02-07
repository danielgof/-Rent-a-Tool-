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
			'/': (context) => HomeRoute(),
			'/second': (context) => OfferPage(),
			'/third': (context) => AllOffersPage(),
		},
	)); //MaterialApp
}

class HomeRoute extends StatelessWidget {
	HomeRoute({Key? key}) : super(key: key);

  // get loginController => null;
	Future<int> getRequest(login, pass) async {
		//replace your restFull API here.
		String url = "http://localhost:5000/api/v1/auth/login";
		Map credits = {
			"username": login,
			"password": pass
		};
		// Map credits = {
		// 	"username": "JL",
		// 	"password": "NCC-1701-D"
		// };
		var body_data = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: body_data);
		var responseData = json.decode(response.body);
		var data = response.statusCode;
		return data;
	}
	TextEditingController loginController = TextEditingController();
	TextEditingController passwordController = TextEditingController();
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
						),
						Padding(
							//padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
							padding: EdgeInsets.symmetric(horizontal: 15),
							child: TextField(
								controller: loginController,
								decoration: InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Login',
										hintText: 'Enter valid login'),
							),
						),
						Padding(
							padding: const EdgeInsets.only(
									left: 15.0, right: 15.0, top: 15, bottom: 0),
							//padding: EdgeInsets.symmetric(horizontal: 15),
							child: TextField(
								controller: passwordController,
								obscureText: true,
								decoration: InputDecoration(
									
										border: OutlineInputBorder(),
										labelText: 'Password',
										hintText: 'Enter secure password'),
							),
						),
						ElevatedButton(
							child: const Text('Login'),
							onPressed: () async {
								var login = loginController.text;
								var pass = passwordController.text;
								var status = await getRequest(login, pass);
								// print("status");
								// print(status);
								print(loginController.text);
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
