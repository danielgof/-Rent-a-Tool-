import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

import '../../../api/url.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
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

  Future<List<Marker>> fetchMarkers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader:
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
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
              ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                content: Text('Tapped on Marker'),
              ));
            },
            child: const Icon(Icons.pin_drop),
          ),
          // builder: (context) => const Icon(Icons.pin_drop),
        );
      }).toList();
    } else {
      throw Exception('Failed to load markers');
    }
  }

  // Future<List<Marker>> fetchMarkers() async {
  //   // Replace this with your own logic to fetch marker data
  //   return [
  //     Marker(
  //       point: LatLng(51.5, -0.09),
  //       builder: (context) => Icon(Icons.pin_drop),
  //     ),
  //     Marker(
  //       point: LatLng(52.5, -1.9),
  //       builder: (context) => Icon(Icons.pin_drop),
  //     ),
  //     Marker(
  //       point: LatLng(53.5, -2.9),
  //       builder: (context) => Icon(Icons.pin_drop),
  //     ),
  //   ];
  // }

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