import 'dart:convert';

import 'package:flutter/widgets.dart'; // basic set of widgets
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

// When Dart is running the application, it calls to the main() function
main() => runApp(
	Directionality(
		textDirection: TextDirection.ltr,
		child: Center(
				child: MyStatelessWidget()
		),
	),
);

class MyStatelessWidget extends StatelessWidget {
	// @override annotation is needed for optimization, by using it
	// we say that we don't need the same method from the parent class
	// so the compiler can drop it
	@override
	Widget build(BuildContext context) { // I'll describe [context] later
		// print(http.get('https://jsonplaceholder.typicode.com/albums'));
		final response = http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
		print(response);
		print("test");
		return Text('Hello!');
	}
}
