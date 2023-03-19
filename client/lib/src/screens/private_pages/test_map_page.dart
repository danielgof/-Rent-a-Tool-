import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

import '../../../api/url.dart';

class MapWithMarkers extends StatefulWidget {
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  final MapController mapController = MapController();

  Future<List<Marker>> fetchMarkers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    final data = jsonDecode(response.body) as List;
    print(data.map((userData) => Marker(
      point: LatLng(userData['address']['geo']['lat'], userData['address']['geo']['lng']),
      builder: (context) => Icon(Icons.location_on),
    )).toList());
    return data.map((userData) => Marker(
      point: LatLng(userData['address']['geo']['lat'], userData['address']['geo']['lng']),
      builder: (context) => Icon(Icons.location_on),
    )).toList();
  }
  // Future<List<Marker>> fetchMarkers() async {
  //   String url = "https://api.latlonglab.com/api/v1/destinations";
  //   // String url = "$URL/api/v1/offer/all_all";
  //   final response = await http.get(Uri.parse(url));
  //
  //   final data = json.decode(response.body);
  //   print("test");
  //   print(data);
  //
  //   return data.map((markerData) =>
  //       Marker(
  //     point: LatLng(markerData['lat'], markerData['lng']),
  //     builder: (context) => const Icon(Icons.location_on),
  //   )).toList();
  // }

  void _zoomIn() {
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void _zoomOut() {
    mapController.move(mapController.center, mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Marker>>(
      future: fetchMarkers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final markers = snapshot.data;
          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(37.7749, -122.4194),
                  zoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: markers ?? [],
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

