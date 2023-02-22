import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
		var body_data = json.encode(credits);
		final response = await http.post(Uri.parse(url), body: body_data);
		var responseData = json.decode(response.body);
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
            Text('Registration'),
						Padding(
							padding: const EdgeInsets.only(
							left: 15.0, right: 15.0, top: 15, bottom: 0),
							child: TextField(
								controller: usernameController,
								decoration: InputDecoration(
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
								decoration: InputDecoration(
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
								decoration: InputDecoration(
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
								decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                  hintText: 'Enter phone number'),
							),
						),
						ElevatedButton(
							child: const Text('Register'),
							onPressed: () async {
								var username = usernameController.text;
                var pass = passController.text;
								var phone = phoneController.text;
                var email = emailController.text;
								var status = await registrationRequest(username, pass, phone, email);
								if (200 == status) {
                  print("user was registered");
									// Navigator.pushNamed(context, '/user_offers');
								} else {
									print("incorrect data");
								}
							},
						),
					], 
				), // Column
			), // Center
		); // Scaffold
	}
}
