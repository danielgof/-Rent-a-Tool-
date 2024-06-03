import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:client/api/ApiOffer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import '../main_page.dart';
import '../../../api/utils.dart';
import 'offer_registration_description.dart';

// ignore: must_be_immutable
class OfferRegistrationContactsPage extends StatefulWidget {
  String toolName;
  String toolDescription;
  String price;
  String dateStart;
  String dateFinish;
  String img;

  OfferRegistrationContactsPage({
    super.key,
    required this.toolName,
    required this.toolDescription,
    required this.price,
    required this.dateStart,
    required this.dateFinish,
    required this.img,
  });

  @override
  State<OfferRegistrationContactsPage> createState() =>
      _OfferRegistrationContactsPageState();
}

class _OfferRegistrationContactsPageState
    extends State<OfferRegistrationContactsPage> {
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = {};
  }

  // Extraction username of current user from JWT
  final String username = JWT.decode(Utils.TOKEN).payload["username"];

  final String phoneNumber = "+123239203902";

  AlertDialog alert = const AlertDialog(
    title: Text("Offer was created successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<int> _registrationRequest(toolName, toolDescription, price, dateStart,
      dateFinish, lat, lng, ownerName, phoneNumber, img) async {
    String url = "$URL/api/v1/offer/save";
    Map<String, String> credits = {
      "tool_name": toolName,
      "tool_description": toolDescription,
      "price": price,
      "date_start": dateStart,
      "date_finish": dateFinish,
      "lat": lat,
      "lng": lng,
      "owner_name": ownerName,
      "phone_number": phoneNumber,
      "img": img,
    };
    // print(credits["date_start"]);
    var bodyData = json.encode(credits);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
      body: bodyData,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return response.statusCode;
    } else {
      throw Exception("Failed to create offer");
    }
  }

  _handleTap(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: const InfoWindow(
          title: "I am a marker",
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }

  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Card(
          child: Container(
            constraints: BoxConstraints.loose(
              const Size(600, 800),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Choose location.",
                    style: Theme.of(context).textTheme.headlineMedium),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: StatefulBuilder(builder: (context, setState) {
                      return GoogleMap(
                        markers: _markers,
                        // on below line setting camera position
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(37.422131, -122.084801),
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
                        onTap: _handleTap,
                      );
                    }),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _markers = {};
                    });
                  },
                  child: const Text("Clear markers."),
                ),
                TextButton(
                  onPressed: () {
                    _registrationRequest(
                      widget.toolName,
                      widget.toolDescription,
                      widget.price,
                      widget.dateStart,
                      widget.dateFinish,
                      _markers.elementAt(0).position.latitude.toString(),
                      _markers.elementAt(0).position.longitude.toString(),
                      username,
                      phoneNumber,
                      widget.img,
                    );
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
                  child: const Text(
                    "REGISTER OFFER.",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivateMain(
                          selectedIndex: 4,
                          isAuth: true,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.navigate_before),
                      Text(
                        "Return to previous step.",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
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
