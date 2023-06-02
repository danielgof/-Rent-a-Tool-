import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  // on below line we are initializing our controller for google maps.
  Completer<GoogleMapController> _controller = Completer();
 
  String URL = "https://brodon.pythonanywhere.com";

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
      print(response.statusCode);
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
    target: LatLng(37.422131, -122.084801),
    zoom: 14.4746,
  );
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        title: Text("Maps"),
      ),
      body: FutureBuilder<List<Marker>>(
        future: _markers,
        builder: (context, snapshot) {
        print(snapshot);
        if(snapshot.hasData) {
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
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load markers');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        },
      )
    );
  }
}


class Offer {
  final int id;
  final String toolName;
  final String toolDescription;
  final String price;
  final String dateStart;
  final String dateFinish;
  final String ownerName;
  final String phoneNumber;
  final String lat;
  final String lng;

  Offer({
    required this.id,
    required this.toolName,
    required this.toolDescription,
    required this.price,
    required this.dateStart,
    required this.dateFinish,
    required this.ownerName,
    required this.phoneNumber,
    required this.lng,
    required this.lat,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        id: json['id'],
        toolName: json['tool_name'],
        toolDescription: json['tool_description'],
        lat: json['lat'],
        lng: json['lng'],
        price: json['price'],
        dateStart: json['date_start'],
        dateFinish: json['date_finish'],
        ownerName: json['owner_name'],
        phoneNumber: json['phone_number']
    );
  }
}