import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

import '../../models/offer.dart';
import '../../api/utils.dart';
import 'main_page_private.dart';

class UserOffersPage extends StatefulWidget {
  const UserOffersPage({Key? key}) : super(key: key);

  @override
  _AllOffersPageState createState() => _AllOffersPageState();
}

class _AllOffersPageState extends State<UserOffersPage> {
  late Future<List<Offer>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchOffers();
  }

  Future<List<Offer>> fetchOffers() async {
    String url = "$URL/api/v1/offer/all";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  AlertDialog alert = const AlertDialog(
    title: Text("Offer was deleted successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<int> _deleteOffer(id) async {
    String url = "$URL/api/v1/offer/delete";
    Map body = {"id": id};
    var bodyData = json.encode(body);
    final response = await http.delete(
      Uri.parse(url),
      body: bodyData,
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return response.statusCode;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<List<Offer>> queryOffer(query) async {
    String url = "$URL/api/v1/offer/query";
    Map credits = {
      "query": query,
    };
    var bodyData = json.encode(credits);
    final response = await http.post(Uri.parse(url), body: bodyData);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: Colors.blue,
              controller: searchController,
              onChanged: (String val) async {
                setState(() {
                  _futurePosts = queryOffer(searchController.value.text);
                  if (searchController.value.text == "") {
                    _futurePosts = fetchOffers();
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() {
                    searchController.clear();
                    _futurePosts = fetchOffers();
                  }),
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
                        Uint8List bytesImage =
                            const Base64Decoder().convert(post.img);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetailsPagePrivate(post: post),
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
                                  ListTile(
                                    title: Text(
                                      post.toolName,
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                                    subtitle: Text(
                                        "Available from ${Jiffy.parse(post.dateStart, pattern: "EEE, dd MMM yyyy ss:mm:hh").format(pattern: "dd/MM/yyyy")} to ${Jiffy.parse(post.dateFinish, pattern: "EEE, dd MMM yyyy ss:mm:hh").format(pattern: "dd/MM/yyyy")}"),
                                    // trailing: Icon(Icons.favorite_outline),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        _deleteOffer(post.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PrivateMain(
                                              selectedIndex: 0,
                                              isAuth: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200.0,
                                    width: 400.0,
                                    child: Image(
                                      image: MemoryImage(bytesImage),
                                    ),
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

  const PostDetailsPagePrivate({Key? key, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List bytesImage = const Base64Decoder().convert(post.img);
    return Scaffold(
      appBar: AppBar(
        title: Text(post.toolName),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        post.toolName,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 200.0,
                      width: 400.0,
                      child: Image(
                        image: MemoryImage(bytesImage),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Description: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                post.toolDescription,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  backgroundColor:
                                      Color.fromARGB(25, 23, 2, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Price: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${post.price} US Dollars',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  backgroundColor:
                                      Color.fromARGB(25, 23, 2, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Date Start: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                Jiffy.parse(post.dateStart,
                                        pattern: "EEE, dd MMM yyyy ss:mm:hh")
                                    .format(pattern: "dd/MM/yyyy"),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  backgroundColor:
                                      Color.fromARGB(25, 23, 2, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Date Finish: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                Jiffy.parse(post.dateFinish,
                                        pattern: "EEE, dd MMM yyyy ss:mm:hh")
                                    .format(pattern: "dd/MM/yyyy"),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  backgroundColor:
                                      Color.fromARGB(25, 23, 2, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: StatefulBuilder(builder: (context, setState) {
                      return GoogleMap(
                        markers: {
                          Marker(
                            markerId: MarkerId(post.toolName.toString()),
                            position: LatLng(
                              double.parse(post.lat.toString()),
                              double.parse(post.lng.toString()),
                            ),
                          )
                        },
                        // on below line setting camera position
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(post.lat.toString()),
                            double.parse(post.lng.toString()),
                          ),
                          zoom: 14.4746,
                        ),
                        // on below line specifying map type.
                        mapType: MapType.normal,
                        // on below line setting user location enabled.
                        myLocationEnabled: true,
                        // on below line setting compass enabled.
                        compassEnabled: true,
                        // on below line specifying controller on map complete.
                        onMapCreated: (GoogleMapController controller) {
                          Completer().complete(controller);
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
