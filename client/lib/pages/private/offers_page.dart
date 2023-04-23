import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rt_client/pages/private/user_offers.dart';

import '../../models/offer.dart';
import '../../api/utils.dart';
import 'offer_registration/offer_registration_description.dart';


class OffersPrivatePage extends StatefulWidget {
  const OffersPrivatePage({Key? key}) : super(key: key);

  @override
  _AllOffersPageState createState() => _AllOffersPageState();
}

class _AllOffersPageState extends State<OffersPrivatePage> {
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
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt)),
              Tab(icon: Icon(Icons.create)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const UserOffersPage(),
            OfferRegistrationDescriptionPage(),
          ],
        ),
      ),
    );
  }
}