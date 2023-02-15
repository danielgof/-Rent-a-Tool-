import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'alloffers_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatelessWidget {
	LoginPage({Key? key}) : super(key: key);

	Future<int> loginRequest(login, pass) async {
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          )
        ],
			), // AppBar
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Padding(
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
							// padding: EdgeInsets.symmetric(horizontal: 15),
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
								var status = await loginRequest(login, pass);
								print(loginController.text);
								if (200 == status) {
									Navigator.pushNamed(context, '/user_offers');
								} else {
									print("incorrect data");
								}
							},
						),
            ElevatedButton(
							child: const Text('Register'),
							onPressed: () {
								Navigator.pushNamed(context, '/registration');
							},
						), // ElevatedButton
					], 
				), // Column
			), // Center
		); // Scaffold
	}
}
