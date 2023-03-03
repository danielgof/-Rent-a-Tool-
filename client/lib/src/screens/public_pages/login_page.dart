import 'dart:convert';
import 'package:RT/api/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatelessWidget {
	LoginPage({Key? key}) : super(key: key);

	Future<int> loginRequest(login, pass) async {
		String url = "$URL/api/v1/auth/login";
		Map credits = {
			"username": login,
			"password": pass
		};
		var bodyData = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: bodyData);
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
				backgroundColor: const Color.fromARGB(255, 76, 173, 175),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
							padding: const EdgeInsets.symmetric(horizontal: 15),
							child: TextField(
								controller: loginController,
								decoration: const InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Login',
										hintText: 'Enter valid login'),
							),
						),
						Padding(
							padding: const EdgeInsets.only(
									left: 15.0, right: 15.0, top: 15, bottom: 0),
							child: TextField(
								controller: passwordController,
								obscureText: true,
								decoration: const InputDecoration(
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
