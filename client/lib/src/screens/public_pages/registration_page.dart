import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'alloffers_public_page.dart';


class RegistrationPage extends StatelessWidget {
	RegistrationPage({Key? key}) : super(key: key);

	Future<int> registrationRequest(username, pass, phone, email) async {
		String url = "http://localhost:5000/api/v1/auth/register";
		Map credits = {
			"username": username,
			"phone": phone,
      "email":email,
      "password":pass,
		};
		var bodyData = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: bodyData);
		var data = response.statusCode;
		return data;
	}
	TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
	TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
	@override
	Widget build(BuildContext context) {
		return Scaffold(
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
			body: Center(
				child: Card(
					child: Container(
						constraints: BoxConstraints.loose(const Size(600, 600)),
						padding: const EdgeInsets.all(8),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							const Text('Registration'),
							Padding(
								padding: const EdgeInsets.only(
								left: 15.0, right: 15.0, top: 15, bottom: 0),
								child: TextField(
									controller: usernameController,
									decoration: const InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Username',
										hintText: 'Enter username'),
								),
							),
							Padding(
								padding: const EdgeInsets.only(
								left: 15.0, right: 15.0, top: 15, bottom: 0),
								child: TextField(
									controller: passController,
									obscureText: true,
									decoration: const InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Password',
										hintText: 'Enter secure password'),
								),
							),
							Padding(
								padding: const EdgeInsets.only(
								left: 15.0, right: 15.0, top: 15, bottom: 0),
								child: TextField(
									controller: emailController,
									decoration: const InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Email',
										hintText: 'Enter email'),
								),
							),
							Padding(
								padding: const EdgeInsets.only(
								left: 15.0, right: 15.0, top: 15, bottom: 0),
								child: TextField(
									controller: phoneController,
									decoration: const InputDecoration(
										border: OutlineInputBorder(),
										labelText: 'Phone number',
										hintText: 'Enter phone number'),
								),
							),
							Padding(
								padding: const EdgeInsets.all(16),
								child: TextButton(
									onPressed: () async {
										var username = usernameController.text;
										var pass = passController.text;
										var phone = phoneController.text;
										var email = emailController.text;
										var status = await registrationRequest(username, pass, phone, email);
										if (username != "" && pass != "" && phone != "" && email != "") {
											if (200 == status) {
												showDialog<String>(
													context: context,
													builder: (context) => AlertDialog(
														title: const Text('Success!'),
														content: const Text('The user was registered successfully.'),
														actions: [
															TextButton(
																onPressed: () => Navigator.pop(context, 'OK'),
																child: const Text('OK'),
															),
														],
													),
												);
												// Navigator.pushNamed(context, '/user_offers');
											} else {
												showDialog<String>(
													context: context,
													builder: (context) => AlertDialog(
														title: const Text('Error!'),
														content: const Text('The error occurred when register a user.'),
														actions: [
															TextButton(
																onPressed: () => Navigator.pop(context, 'OK'),
																child: const Text('OK'),
															),
														],
													),
												);
											}
										} else {
											showDialog<String>(
												context: context,
												builder: (context) => AlertDialog(
													title: const Text('Error!'),
													content: const Text('All fields should be filled in order to register.'),
													actions: [
														TextButton(
															onPressed: () => Navigator.pop(context, 'OK'),
															child: const Text('OK'),
														),
													],
												),
											);
										}
									},
									child: const Text('Register.'),
								),
							),
						],
					),
				),
				),
			 ), // Center
		); // Scaffold
	}
}
