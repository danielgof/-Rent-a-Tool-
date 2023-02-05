import 'dart:convert';
import './pages/offers_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './pages/main_page.dart';

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
								Navigator.pushNamed(context, '/third');
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



