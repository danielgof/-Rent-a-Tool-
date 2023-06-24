import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api/utils.dart';

class MyMapPrivate extends StatefulWidget {
  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<MyMapPrivate> {
  // on below line we are initializing our controller for google maps.
  Completer<GoogleMapController> _controller = Completer();

  late Future<List<Marker>> _markers;

  @override
  void initState() {
    super.initState();
    _markers = fetchMarkers();
  }

  Future<List<Marker>> fetchMarkers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> tmp = data["data"];
      // print(response.statusCode);
      return tmp.map((markerData) {
        final point = LatLng(
          double.parse(markerData['lat'].toString()),
          double.parse(markerData['lng'].toString()),
        );
        return Marker(
          markerId: MarkerId(markerData["tool_name"]),
          position: point,
        );
      }).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

// on below line we are specifying our camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(39.96, -82.99),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Marker>>(
      future: _markers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GoogleMap(
            markers: snapshot.data!.toSet(),
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load markers');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
