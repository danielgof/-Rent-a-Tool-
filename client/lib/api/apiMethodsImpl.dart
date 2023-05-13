import 'dart:io';

import 'package:rt_client/api/apiMethods.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rt_client/api/utils.dart';

// Implements HTTP-Methods to commute with the server
class APIMethodsImpl extends APIMethods {
  @override
  Future<Response> get(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
       HttpHeaders.authorizationHeader: TOKEN,
      },
    );
    return response;
  }

  @override
  Future<Response> post(String url, Map bodyData) async {
    // TODO: implement post
    final response = await http.post(Uri.parse(url), body: bodyData);
    return response;
  }
}