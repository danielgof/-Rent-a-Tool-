// import 'dart:convert';
// import 'dart:io';
// import '../../models/offer.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../../api/url.dart';


class MapPage extends StatefulWidget {
  static const String route = 'on_tap';

  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<List<LatLng>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchOffers();
  }

  Future<List<LatLng>> fetchOffers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
      },);

    if (response.statusCode == 200) {
      // final List<dynamic> jsonList = json.decode(response.body)["data"];

      var responseData = json.decode(response.body);
      List<LatLng> offers = [];
      for (var offer in responseData['result']) {
        LatLng offerTmp = LatLng(
          offer["lat"],
          offer["lng"],
        );
        offers.add(offerTmp);
      }
      return offers;
      // return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // static LatLng london = LatLng(51.5, -0.09);
  // static LatLng paris = LatLng(48.8566, 2.3522);
  // static LatLng dublin = LatLng(53.3498, -6.2603);

  @override
  Widget build(BuildContext context) {
    var coords = <LatLng>[LatLng(51.5, -0.09), LatLng(48.8566, 2.3522), LatLng(53.3498, -6.2603)];
    var markers = <Marker>[];
    for (var marker in coords) {
      Marker marlerTmp = Marker(
        width: 80,
        height: 80,
        point: marker,
        builder: (ctx) => GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text('Tapped on blue FlutterLogo Marker'),
            ));
          },
          child: const FlutterLogo(),
        ),
      );
      markers.add(marlerTmp);
    }
    // final markers = <Marker>[
    //   Marker(
    //     width: 80,
    //     height: 80,
    //     point: london,
    //     builder: (ctx) => GestureDetector(
    //       onTap: () {
    //         ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
    //           content: Text('Tapped on blue FlutterLogo Marker'),
    //         ));
    //       },
    //       child: const FlutterLogo(),
    //     ),
    //   ),
    //   Marker(
    //     width: 80,
    //     height: 80,
    //     point: dublin,
    //     builder: (ctx) => GestureDetector(
    //       onTap: () {
    //         ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
    //           content: Text('Tapped on green FlutterLogo Marker'),
    //         ));
    //       },
    //       child: const FlutterLogo(
    //         textColor: Colors.green,
    //       ),
    //     ),
    //   ),
    //   Marker(
    //     width: 80,
    //     height: 80,
    //     point: paris,
    //     builder: (ctx) => GestureDetector(
    //       onTap: () {
    //         ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
    //           content: Text('Tapped on purple FlutterLogo Marker'),
    //         ));
    //       },
    //       child: const FlutterLogo(textColor: Colors.purple),
    //     ),
    //   ),
    // ];

    return Scaffold(
      // appBar: AppBar(title: const Text('OnTap')),
      // drawer: buildDrawer(context, OnTapPage.route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text('Try tapping on the markers'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 5,
                  maxZoom: 5,
                  minZoom: 3,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}