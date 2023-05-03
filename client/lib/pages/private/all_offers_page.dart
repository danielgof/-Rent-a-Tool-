import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../models/offer.dart';
import '../../api/utils.dart';


class AllOffersPrivatePage extends StatefulWidget {
  const AllOffersPrivatePage({Key? key}) : super(key: key);

  @override
  _AllOffersPageState createState() => _AllOffersPageState();
}

class _AllOffersPageState extends State<AllOffersPrivatePage> {
  late Future<List<Offer>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchOffers();
  }

  Future<List<Offer>> fetchOffers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: TOKEN,
      },);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.all(8),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailsPagePrivate(post: post),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage("https://www.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg"),
                                        maxRadius: 40,
                                      ),
                                      Text(
                                        post.toolName,
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ].map((widget) => Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: widget,
                                    )).toList(),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}

class PostDetailsPagePrivate extends StatelessWidget {
  final Offer post;

  const PostDetailsPagePrivate({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.toolName),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  post.toolName,
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  post.toolDescription,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Price: ${post.price}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Date Start: ${post.dateStart}',
                  // semanticsLabel: "${DateTime.parse(post.dateStart).year.toString()}-${DateTime.parse(post.dateStart).month.toString().padLeft(2,'0')}-${DateTime.parse(post.dateStart).toString().padLeft(2,'0')}",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Date Finish: ${post.dateFinish}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Owner Name: ${post.ownerName}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Phone Number: ${post.phoneNumber}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: StatefulBuilder(
                    builder: (context, setState) => FlutterMap(
                      // options: _mapOptions,
                      // options: _mapOptions,
                      options: MapOptions(
                        center: LatLng(double.parse(post.lat), double.parse(post.lng)),
                        zoom: 6,
                        maxZoom: 18.0,
                        minZoom: 3.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(double.parse(post.lat), double.parse(post.lng)),
                              builder: (ctx) => GestureDetector(
                                onTap: () {
                                  print("clicked");
                                },
                                child: const Icon(Icons.pin_drop),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
