import 'dart:convert';
import 'dart:io';
import '../../../api/url.dart';
import '../../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chat_detail_page.dart';

class OfferPage extends StatefulWidget {
	const OfferPage({super.key});

	@override
	_OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
	late Future<List<Offer>> _futurePosts;

	@override
	void initState() {
		super.initState();
		_futurePosts = fetchOffers();
	}

	Future<List<Offer>> fetchOffers() async {
		String url = "$URL/api/v1/offer/all";
		final response = await http.get(Uri.parse(url),
			headers: {
				HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
			},);

		if (response.statusCode == 200) {
			// If the server did return a 200 OK response, parse the JSON.
			final List<dynamic> jsonList = json.decode(response.body)["result"];
			// print(jsonList.map((json) => Post.fromJson(json)).toList());
			return jsonList.map((json) => Offer.fromJson(json)).toList();
		} else {
			// If the server did not return a 200 OK response, throw an error.
			throw Exception('Failed to load posts');
		}
	}

	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				body: Center(
					child: FutureBuilder<List<Offer>>(
						future: _futurePosts,
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								// If we successfully fetched the list of posts, display them in a ListView
								final List<Offer> posts = snapshot.data!;
								return ListView.builder(
									itemCount: posts.length,
									itemBuilder: (context, index) {
										final post = posts[index];
										return GestureDetector(
											onTap: () {
												// Navigate to the PostDetailsPage when a post is tapped
												Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => PostDetailsPage(post: post),
													),
												);
											},
											child: Container(
												padding: const EdgeInsets.all(16.0),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text(
															post.toolName,
															style: const TextStyle(fontSize: 20.0),
														),
														const SizedBox(height: 8.0),
														Text(post.toolDescription),
													],
												),
											),
										);
									},
								);
							} else if (snapshot.hasError) {
								// If an error occurred while fetching the posts, display an error message
								return Text('${snapshot.error}');
							}
							// By default, show a loading spinner
							return const CircularProgressIndicator();
						},
					),
				),
			),
		);
	}
}

class PostDetailsPage extends StatelessWidget {
	final Offer post;

	const PostDetailsPage({Key? key, required this.post}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(post.toolName),
				backgroundColor: Colors.blue,
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							post.toolName,
							style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
						),
						const SizedBox(height: 16.0),
						Text(
							post.toolDescription,
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Price: ${post.price}',
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Location: ${post.location}',
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Date Start: ${post.dateStart}',
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Date Finish: ${post.dateFinish}',
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Owner Name: ${post.ownerName}',
							style: const TextStyle(fontSize: 18.0),
						),
						Text(
							'Phone Number: ${post.phoneNumber}',
							style: const TextStyle(fontSize: 18.0),
						),
						GestureDetector(
							onTap: () {
								Navigator.push(context, MaterialPageRoute(builder: (context) {
									return ChatDetailPage(
										name: post.ownerName,
										messageText: "",
										imageUrl: "widget.imageUrl",
										time: "widget.time",
									);
								}));
							},
							child: Container(
								padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
								child: Row(
									children: <Widget>[
										Expanded(
											child: Row(
												children: <Widget>[
													CircleAvatar(
														backgroundImage: NetworkImage("widget.imageUrl"),
														maxRadius: 30,
													),
													SizedBox(width: 16,),
													Expanded(
														child: Container(
															color: Colors.transparent,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: <Widget>[
																	Text(post.ownerName, style: const TextStyle(fontSize: 16),),
																	const SizedBox(height: 6,),
																],
															),
														),
													),
												],
											),
										),
										// Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
									],
								),
							),
						)
					],
				),
			),
		);
	}

	// @override
	// Widget build(BuildContext context) {
	// 	return Scaffold(
	// 		appBar: AppBar(
	// 			title: Text(post.toolName),
	// 			backgroundColor: const Color.fromARGB(255, 65, 203, 83),
	// 		),
	// 		body: Padding(
	// 			padding: const EdgeInsets.all(16.0),
	// 			child: Column(
	// 				crossAxisAlignment: CrossAxisAlignment.start,
	// 				children: [
	// 					Text(
	// 						post.toolName,
	// 						style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
	// 					),
	// 					const SizedBox(height: 16.0),
	// 					Text(
	// 						post.toolDescription,
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Price: ${post.price}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Location: ${post.location}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Date Start: ${post.dateStart}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Date Finish: ${post.dateFinish}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Owner Name: ${post.ownerName}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					Text(
	// 						'Phone Number: ${post.phoneNumber}',
	// 						style: const TextStyle(fontSize: 18.0),
	// 					),
	// 					// const SizedBox(height: 16.0),
	// 					// Text
	// 					//   'Post ID: ${post.id}',
	// 					//   style: const TextStyle(fontSize: 16.0),
	// 					// ),
	// 				],
	// 			),
	// 		),
	// 	);
	// }
}


// import 'dart:convert';
// import 'dart:io';
// import '../../../api/url.dart';
// import '../../models/offer.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class OfferPage extends StatefulWidget {
// 	@override
// 	_OfferPageState createState() => _OfferPageState();
// }
//
// class _OfferPageState extends State<OfferPage> {
//
// 	Future<List<Offer>> getRequest() async {
// 		String url = "$URL/api/v1/offer/all";
// 		final response = await http.get(Uri.parse(url),
//     headers: {
//       HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
//     },);
//
// 		var responseData = json.decode(response.body);
// 		List<Offer> offers = [];
// 		for (var offer in responseData['result']) {
// 			Offer offerTmp = Offer(
//         id: offer["id"],
//         toolName: offer["tool_name"],
//         toolDescription: offer["tool_description"],
//         price: offer["price"],
// 				dateStart: offer["date_start"],
// 				dateFinish: offer["date_finish"],
// 				ownerName: offer["owner_name"],
// 				phoneNumber: offer["phone_number"],
// 				location: offer["location"],
// 				lat: offer["lat"],
// 				lng: offer["lng"],
// 			);
// 			offers.add(offerTmp);
// 		}
// 		return offers;
// 	}
//
// 	@override
// 	Widget build(BuildContext context) {
// 		return SafeArea(
// 			child: Scaffold(
// 				appBar: AppBar(
// 					title: const Text("Offers"),
// 					backgroundColor: const Color.fromARGB(255, 65, 203, 83),
// 					actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.logout,
//                 color: Colors.white,
//                 ),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/');
//               },
//             )
//           ],
// 				),
// 				body: Container(
// 					padding: const EdgeInsets.all(16.0),
// 					child: FutureBuilder(
// 						future: getRequest(),
// 						builder: (BuildContext ctx, AsyncSnapshot snapshot) {
//
// 							if (snapshot.data == null) {
// 								return const Center(
// 									child: CircularProgressIndicator(),
// 								);
// 							} else {
// 								return ListView.builder(
// 									itemCount: snapshot.data.length,
// 									itemBuilder: (ctx, index) => ListTile(
// 										// title: Text(snapshot.data[index].title),
// 										subtitle: Text(snapshot.data[index].toolName),
// 										contentPadding: const EdgeInsets.only(bottom: 20.0),
// 									),
// 								);
// 							}
// 						},
// 					),
// 				),
// 			),
// 		);
// 	}
// }