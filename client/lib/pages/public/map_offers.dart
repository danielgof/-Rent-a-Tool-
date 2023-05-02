import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../models/offer.dart';
import '../../api/utils.dart';
import 'offers_page.dart';


class MapOffersPublicPage extends StatefulWidget {
  const MapOffersPublicPage({super.key});

  @override
  _MapOffersPublicState createState() => _MapOffersPublicState();
}

class _MapOffersPublicState extends State<MapOffersPublicPage> {
  late Future<List<Marker>> _markers;
  late double zoom = 6.0;
  late MapOptions _mapOptions;


  @override
  void initState() {
    super.initState();
    _markers = fetchMarkers();
    _mapOptions = MapOptions(
      center: LatLng(51.5, -0.09),
      zoom: zoom,
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
      zoom += 1.0;
      _mapOptions = MapOptions(
        center: _mapOptions.center,
        zoom: zoom,
        maxZoom: _mapOptions.maxZoom,
        minZoom: _mapOptions.minZoom,
        );
      },
    );
  }

  void _onZoomOutPressed() {
    setState(() {
      zoom -= 1.0;
      _mapOptions = MapOptions(
        center: _mapOptions.center,
        zoom: zoom,
        maxZoom: _mapOptions.maxZoom,
        minZoom: _mapOptions.minZoom,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Marker>>(
        future: _markers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              mapController: MapController(),
              options: _mapOptions,
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: snapshot.data!,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Failed to load markers');
          } else {
            return const Center(child: CircularProgressIndicator());
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


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class MapOffersPublicPage extends StatefulWidget {
//   @override
//   _ZoomableMapState createState() => _ZoomableMapState();
// }
//
// class _ZoomableMapState extends State<MapOffersPublicPage> {
//   MapController mapController = MapController();
//   double currentZoom = 13.0;
//
//   void _onMapCreated(MapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
//
//   void _onZoomChanged(MapPosition position, bool hasGesture) {
//     setState(() {
//       currentZoom = mapController.zoom;
//     });
//   }
//
//   void _zoomIn() {
//     setState(() {
//       currentZoom += 1;
//       mapController.move(mapController.center, currentZoom);
//     });
//   }
//
//   void _zoomOut() {
//     setState(() {
//       currentZoom -= 1;
//       mapController.move(mapController.center, currentZoom);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                 center: LatLng(37.7749, -122.4194),
//                 zoom: currentZoom,
//                 onPositionChanged: _onZoomChanged,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: const ['a', 'b', 'c'],
//                 ),
//               ],
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _zoomIn,
//                 child: const Icon(Icons.add),
//               ),
//               ElevatedButton(
//                 onPressed: _zoomOut,
//                 child: const Icon(Icons.remove),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
