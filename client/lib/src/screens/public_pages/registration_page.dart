import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../api/url.dart';
import 'alloffers_public_page.dart';


class RegistrationPage extends StatelessWidget {
	RegistrationPage({Key? key}) : super(key: key);

	Future<int> registrationRequest(username, pass, phone, email) async {
		String url = "$URL/api/v1/auth/register";
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
								MaterialPageRoute(builder: (context) => const AllOffersPageState()
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
										cursorColor: Colors.blue,
										controller: usernameController,
										decoration: const InputDecoration(
												labelStyle: TextStyle(color: Colors.blue),
												focusedBorder: OutlineInputBorder(
													borderSide: BorderSide(color: Colors.grey, width: 0.0),
													// enabledBorder: new OutlineInputBorder(
													// 	// borderRadius: new BorderRadius.circular(25.0),
													// 	borderSide:  BorderSide(color: Colors.pinkAccent ),
													//
													// ),
													// focusedBorder: new OutlineInputBorder(
													// 	borderRadius: new BorderRadius.circular(25.0),
													// 	borderSide:  BorderSide(color: Colors.pinkAccent ),
													//
													// ),
												),
												border: OutlineInputBorder(),
												labelText: 'Username',
												hintText: 'Enter username'),
									),
								),
								Padding(
									padding: const EdgeInsets.only(
											left: 15.0, right: 15.0, top: 15, bottom: 0),
									child: TextField(
										cursorColor: Colors.blue,
										controller: passController,
										obscureText: true,
										decoration: const InputDecoration(
												labelStyle: TextStyle(color: Colors.blue),
												focusedBorder: OutlineInputBorder(
													borderSide: BorderSide(color: Colors.grey, width: 0.0),
												),
												border: OutlineInputBorder(),
												labelText: 'Password',
												hintText: 'Enter secure password'
										),
									),
								),
								Padding(
									padding: const EdgeInsets.only(
											left: 15.0, right: 15.0, top: 15, bottom: 0),
									child: TextField(
										cursorColor: Colors.blue,
										controller: emailController,
										decoration: const InputDecoration(
												labelStyle: TextStyle(color: Colors.blue),
												focusedBorder: OutlineInputBorder(
													borderSide: BorderSide(color: Colors.grey, width: 0.0),
												),
												border: OutlineInputBorder(),
												labelText: 'Email',
												hintText: 'Enter email'
										),
									),
								),
								Padding(
									padding: const EdgeInsets.only(
											left: 15.0, right: 15.0, top: 15, bottom: 0),
									child: TextField(
										cursorColor: Colors.blue,
										controller: phoneController,
										decoration: const InputDecoration(
												labelStyle: TextStyle(color: Colors.blue),
												focusedBorder: OutlineInputBorder(
													borderSide: BorderSide(color: Colors.grey, width: 0.0),
												),
												border: OutlineInputBorder(),
												labelText: 'Phone number',
												hintText: 'Enter phone number'
										),
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
												} else {
													showDialog<String>(
														context: context,
														builder: (context) => AlertDialog(
															title: const Text('Error!'),
															content: const Text('The error occurred when register a user.'),
															actions: [
																TextButton(
																	onPressed: () => Navigator.pop(context, 'OK'),
																	child: const Text('OK',
																			style: TextStyle(color: Colors.blue)),
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
																child: const Text('OK',
																		style: TextStyle(color: Colors.blue)),
															),
														],
													),
												);
											}
										},
										child: const Text('Register.',
												style: TextStyle(color: Colors.blue)),
									),
								),
							],
						),
					),
				),
			), // Center
		); // Scaffold
	}

	// @override
	// Widget build(BuildContext context) {
	// 	return Scaffold(
	// 		bottomNavigationBar: BottomAppBar(
	// 			child: Row(
	// 				mainAxisSize: MainAxisSize.max,
	// 				children: <Widget>[
	// 					IconButton(icon: const Icon(Icons.local_offer), onPressed: () {
	// 						Navigator.push(
	// 							context,
	// 							MaterialPageRoute(builder: (context) => AllOffersPageState()
	// 							),
	// 						);
	// 					},),
	// 					IconButton(icon: const Icon(Icons.login), onPressed: () {
	// 						Navigator.pop(context);
	// 					},),
	// 				],
	// 			),
	// 		),
	// 		body: Center(
	// 			child: Card(
	// 				child: Container(
	// 					constraints: BoxConstraints.loose(const Size(600, 600)),
	// 					padding: const EdgeInsets.all(8),
	// 				child: Column(
	// 					mainAxisAlignment: MainAxisAlignment.center,
	// 					children: <Widget>[
	// 						const Text('Registration'),
	// 						Padding(
	// 							padding: const EdgeInsets.only(
	// 							left: 15.0, right: 15.0, top: 15, bottom: 0),
	// 							child: TextField(
	// 								cursorColor: const Color.fromARGB(255, 65, 203, 83),
	// 								controller: usernameController,
	// 								decoration: const InputDecoration(
	// 									labelStyle: TextStyle(color: Colors.green),
	// 									focusedBorder: OutlineInputBorder(
	// 											borderSide: BorderSide(color: Colors.grey, width: 0.0),
	// 										// enabledBorder: new OutlineInputBorder(
	// 										// 	// borderRadius: new BorderRadius.circular(25.0),
	// 										// 	borderSide:  BorderSide(color: Colors.pinkAccent ),
	// 										//
	// 										// ),
	// 										// focusedBorder: new OutlineInputBorder(
	// 										// 	borderRadius: new BorderRadius.circular(25.0),
	// 										// 	borderSide:  BorderSide(color: Colors.pinkAccent ),
	// 										//
	// 										// ),
	// 									),
	// 									border: OutlineInputBorder(),
	// 									labelText: 'Username',
	// 									hintText: 'Enter username'),
	// 							),
	// 						),
	// 						Padding(
	// 							padding: const EdgeInsets.only(
	// 							left: 15.0, right: 15.0, top: 15, bottom: 0),
	// 							child: TextField(
	// 								cursorColor: const Color.fromARGB(255, 65, 203, 83),
	// 								controller: passController,
	// 								obscureText: true,
	// 								decoration: const InputDecoration(
	// 									labelStyle: TextStyle(color: Colors.green),
	// 									focusedBorder: OutlineInputBorder(
	// 											borderSide: BorderSide(color: Colors.grey, width: 0.0),
	// 									),
	// 									border: OutlineInputBorder(),
	// 									labelText: 'Password',
	// 									hintText: 'Enter secure password'
	// 								),
	// 							),
	// 						),
	// 						Padding(
	// 							padding: const EdgeInsets.only(
	// 							left: 15.0, right: 15.0, top: 15, bottom: 0),
	// 							child: TextField(
	// 								cursorColor: const Color.fromARGB(255, 65, 203, 83),
	// 								controller: emailController,
	// 								decoration: const InputDecoration(
	// 										labelStyle: TextStyle(color: Colors.green),
	// 										focusedBorder: OutlineInputBorder(
	// 											borderSide: BorderSide(color: Colors.grey, width: 0.0),
	// 										),
	// 									border: OutlineInputBorder(),
	// 									labelText: 'Email',
	// 									hintText: 'Enter email'
	// 								),
	// 							),
	// 						),
	// 						Padding(
	// 							padding: const EdgeInsets.only(
	// 							left: 15.0, right: 15.0, top: 15, bottom: 0),
	// 							child: TextField(
	// 								cursorColor: const Color.fromARGB(255, 65, 203, 83),
	// 								controller: phoneController,
	// 								decoration: const InputDecoration(
	// 										labelStyle: TextStyle(color: Colors.green),
	// 										focusedBorder: OutlineInputBorder(
	// 											borderSide: BorderSide(color: Colors.grey, width: 0.0),
	// 										),
	// 									border: OutlineInputBorder(),
	// 									labelText: 'Phone number',
	// 									hintText: 'Enter phone number'
	// 								),
	// 							),
	// 						),
	// 						Padding(
	// 							padding: const EdgeInsets.all(16),
	// 							child: TextButton(
	// 								onPressed: () async {
	// 									var username = usernameController.text;
	// 									var pass = passController.text;
	// 									var phone = phoneController.text;
	// 									var email = emailController.text;
	// 									var status = await registrationRequest(username, pass, phone, email);
	// 									if (username != "" && pass != "" && phone != "" && email != "") {
	// 										if (200 == status) {
	// 											showDialog<String>(
	// 												context: context,
	// 												builder: (context) => AlertDialog(
	// 													title: const Text('Success!'),
	// 													content: const Text('The user was registered successfully.'),
	// 													actions: [
	// 														TextButton(
	// 															onPressed: () => Navigator.pop(context, 'OK'),
	// 															child: const Text('OK'),
	// 														),
	// 													],
	// 												),
	// 											);
	// 										} else {
	// 											showDialog<String>(
	// 												context: context,
	// 												builder: (context) => AlertDialog(
	// 													title: const Text('Error!'),
	// 													content: const Text('The error occurred when register a user.'),
	// 													actions: [
	// 														TextButton(
	// 															onPressed: () => Navigator.pop(context, 'OK'),
	// 															child: const Text('OK',
	// 																	style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
	// 														),
	// 													],
	// 												),
	// 											);
	// 										}
	// 									} else {
	// 										showDialog<String>(
	// 											context: context,
	// 											builder: (context) => AlertDialog(
	// 												title: const Text('Error!'),
	// 												content: const Text('All fields should be filled in order to register.'),
	// 												actions: [
	// 													TextButton(
	// 														onPressed: () => Navigator.pop(context, 'OK'),
	// 														child: const Text('OK',
	// 																style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
	// 													),
	// 												],
	// 											),
	// 										);
	// 									}
	// 								},
	// 								child: const Text('Register.',
	// 										style: TextStyle(color: Color.fromARGB(255, 65, 203, 83))),
	// 							),
	// 						),
	// 					],
	// 				),
	// 			),
	// 			),
	// 		 ), // Center
	// 	); // Scaffold
	// }
}
