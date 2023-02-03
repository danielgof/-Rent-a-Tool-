import 'dart:convert';
import './pages/offers_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: OfferPage(),
		);
	}
}



