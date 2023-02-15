import 'package:client/src/models/offer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

dynamic offers = Offers();

class Offers {
  Future<List<Offer>> getOffersRequest() async {
    //replace your restFull API here.
    String url = "http://localhost:5000/api/v1/offer/all_all";
    final response = await http.get(Uri.parse(url),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzM3MzA2NTE4fQ.D7PYSvlImUFUuFs-nBfJobQrq7tg-mUQ9kiQj83pY5M',
      },);

    var responseData = json.decode(response.body);
    print(responseData);
    // var offersResponce = responseData["responce"];
    // print(offersResponce);
    //Creating a list to store input data;
    List<Offer> offers = [];
    for (var offer in responseData) {
      Offer offerTmp = Offer(
          id: offer["id"],
          toolName: offer["tool_name"],
          toolDescription: offer["tool_description"],
          price: offer["price"]);
      //Adding user to the list.
      offers.add(offerTmp);
    }
    return offers;
  }
  // final List<Offer> allOffers = getOffersRequest();
}