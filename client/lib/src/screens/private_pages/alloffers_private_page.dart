import 'dart:convert';
import 'dart:io';
import '../../../api/url.dart';
import '../../models/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllOffersPrivatePage extends StatefulWidget {
  const AllOffersPrivatePage({super.key});

  @override
  _AllOffersPrivatePageState createState() => _AllOffersPrivatePageState();
}

class _AllOffersPrivatePageState extends State<AllOffersPrivatePage> {
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
        HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
      },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, parse the JSON.
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      // print(jsonList.map((json) => Post.fromJson(json)).toList());
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load posts');
    }
  }

  TextEditingController _searchController = TextEditingController();
  bool _searchIconClicked = false;

  void _searchPressed() {
    setState(() {
      _searchIconClicked = true;
    });
  }


  void _cancelSearch() {
    setState(() {
      _searchIconClicked = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: _searchIconClicked ?
          TextField(
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
            ),
          )
              : const Text("Search for available items."),
          leading: _searchIconClicked ?
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _cancelSearch();
            },
          )
              : IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchPressed();
            },
          ),
          actions: _searchIconClicked ? null : <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
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

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: const Color.fromARGB(255, 65, 203, 83),
  //         title: _searchIconClicked ?
  //         TextField(
  //           cursorColor: const Color.fromARGB(255, 65, 203, 83),
  //           decoration: InputDecoration(
  //             hintText: "Search...",
  //             hintStyle: TextStyle(color: Colors.grey.shade600),
  //             prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
  //             filled: true,
  //             fillColor: Colors.grey.shade100,
  //             contentPadding: const EdgeInsets.all(8),
  //             enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //                 borderSide: BorderSide(
  //                     color: Colors.grey.shade100
  //                 )
  //             ),
  //           ),
  //         )
  //             : const Text("Search for available items."),
  //         leading: _searchIconClicked ?
  //         IconButton(
  //           icon: const Icon(Icons.arrow_back),
  //           onPressed: () {
  //             _cancelSearch();
  //           },
  //         )
  //             : IconButton(
  //           icon: const Icon(Icons.search),
  //           onPressed: () {
  //             _searchPressed();
  //           },
  //         ),
  //         actions: _searchIconClicked ? null : <Widget>[
  //           IconButton(
  //             icon: Icon(Icons.more_vert),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.add),
  //             onPressed: () {},
  //           ),
  //         ],
  //       ),
  //       body: Center(
  //         child: FutureBuilder<List<Offer>>(
  //           future: _futurePosts,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               // If we successfully fetched the list of posts, display them in a ListView
  //               final List<Offer> posts = snapshot.data!;
  //               return ListView.builder(
  //                 itemCount: posts.length,
  //                 itemBuilder: (context, index) {
  //                   final post = posts[index];
  //                   return GestureDetector(
  //                     onTap: () {
  //                       // Navigate to the PostDetailsPage when a post is tapped
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => PostDetailsPage(post: post),
  //                         ),
  //                       );
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.all(16.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             post.toolName,
  //                             style: const TextStyle(fontSize: 20.0),
  //                           ),
  //                           const SizedBox(height: 8.0),
  //                           Text(post.toolDescription),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               );
  //             } else if (snapshot.hasError) {
  //               // If an error occurred while fetching the posts, display an error message
  //               return Text('${snapshot.error}');
  //             }
  //             // By default, show a loading spinner
  //             return const CircularProgressIndicator();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
            // const SizedBox(height: 16.0),
            // Text
            //   'Post ID: ${post.id}',
            //   style: const TextStyle(fontSize: 16.0),
            // ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(post.toolName),
  //       backgroundColor: const Color.fromARGB(255, 65, 203, 83),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             post.toolName,
  //             style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16.0),
  //           Text(
  //             post.toolDescription,
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Price: ${post.price}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Location: ${post.location}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Date Start: ${post.dateStart}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Date Finish: ${post.dateFinish}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Owner Name: ${post.ownerName}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           Text(
  //             'Phone Number: ${post.phoneNumber}',
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           // const SizedBox(height: 16.0),
  //           // Text
  //           //   'Post ID: ${post.id}',
  //           //   style: const TextStyle(fontSize: 16.0),
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
