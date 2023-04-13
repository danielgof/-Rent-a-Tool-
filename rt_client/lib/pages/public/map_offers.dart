import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../models/offer.dart';
import '../../../utils.dart';
import 'offers_page.dart';


class MapOffersPublicPage extends StatefulWidget {
  @override
  _MapOffersPublicState createState() => _MapOffersPublicState();
}

class _MapOffersPublicState extends State<MapOffersPublicPage> {
  late Future<List<Marker>> _markers;
  var _zoom = 6.0;
  late MapOptions _mapOptions;


  @override
  void initState() {
    super.initState();
    _markers = fetchMarkers();
    _mapOptions = MapOptions(
      center: LatLng(51.5, -0.09),
      zoom: _zoom,
      maxZoom: 18.0,
      minZoom: 3.0,
    );
  }

  AlertDialog alert = const AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<List<Marker>> fetchMarkers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
      TOKEN,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> tmp = data["data"];
      return tmp.map((markerData) {
        final point = LatLng(
          double.parse(markerData['lat'].toString()),
          double.parse(markerData['lng'].toString()),
        );
        return Marker(
          point: point,
          builder: (ctx) => GestureDetector(
            onTap: () {
              // print("clicked");
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return alert;
              //   },
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsPage(post: Offer(
                    id: markerData['id'],
                    toolName: markerData['tool_name'],
                    toolDescription: markerData['tool_description'],
                    price: markerData['price'],
                    dateStart: markerData['date_start'],
                    dateFinish: markerData['date_finish'],
                    ownerName: markerData['owner_name'],
                    phoneNumber: markerData['phone_number'],
                    location: markerData['location'],
                    lng: markerData['lng'],
                    lat: markerData['lat'],
                  )),
                ),
              );
            },
            child: const Icon(Icons.pin_drop),
          ),
        );
      }).toList();
    } else {
      throw Exception('Failed to load markers');
    }
  }

  void _onZoomInPressed() {
    setState(() {
      _zoom += 1.0;
      // _mapOptions = _mapOptions.copyWith(zoom: _zoom);
    });
  }

  void _onZoomOutPressed() {
    setState(() {
      _zoom -= 1.0;
      // _mapOptions = _mapOptions.copyWith(zoom: _zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Marker>>(
        future: _markers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StatefulBuilder(
              builder: (context, setState) => FlutterMap(
                options: _mapOptions,
                // options: _mapOptions,
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: snapshot.data!,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching markers'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _onZoomInPressed,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: _onZoomOutPressed,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}