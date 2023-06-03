import 'dart:convert';

import 'package:client/api/ApiMethodsImpl.dart';
import 'package:client/api/utils.dart';
import '../models/offer.dart';

class ApiOffer extends APIMethodsImpl {
  // 1) add an offer to user
  // url: "/api/v1/offer/save
  // method: POST
  Future<int> registerOfferToUser(toolName, toolDescription, price,
      dateStart, dateFinish, lat, lng, ownerName, phoneNumber) async {
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
    };
    final response = await APIMethodsImpl().post(url, credits);
    var status = response.statusCode;
    return status;
  }
  //  2) get all offers
  // url: "/api/v1/offer/all_all"
  // method: GET
  Future<List<Offer>> fetchOffers() async {
    String url = "$URL/api/v1/offer/all_all";
    final response = await APIMethodsImpl().get(url);
    if (response.statusCode == 200) {
      // print(json.decode(response.body)["data"]);
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      // print(jsonList.map((json) => Offer.fromJson(json)).toList());
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
  // 3) get all offer of a user
  // URL: ”/api/v1/offer/all”
  // method: GET
  Future<List<Offer>> fetchUserOffers() async {
    String url = "$URL/api/v1/offer/all";
    final response = await APIMethodsImpl().get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
  // 4) delete offer by id
  // URL: “/api/v1/offer/delete“
  // method: DELETE
  Future<int> deleteOffer(id) async {
    String url = "$URL/api/v1/offer/delete";
    Map body = {"id": id};
    final response = await APIMethodsImpl().delete(url, body,);
    return response.statusCode;
  }
  // 5) get offer by query
  // URL: “/api/v1/offer/query“
  // method: POST
  Future<List<Offer>> queryOffer(query) async {
    String url = "$URL/api/v1/offer/query";
    Map credits = {
      "query": query,
    };
    final response = await APIMethodsImpl().post(url, credits);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => Offer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }
  // 6) update particular offer
  // URL: “/api/v1/offer/upd“
  // method: PUT
}