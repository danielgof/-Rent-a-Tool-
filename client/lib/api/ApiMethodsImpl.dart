import 'dart:convert';
import 'dart:io';

import 'package:rt_client/api/ApiMethods.dart';
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
  Future<Response> post(String url, Map credits) async {
    // TODO: implement post
    var bodyData = json.encode(credits);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: TOKEN,
      },
      body: bodyData,
    );
    return response;
  }

  @override
  Future<Response> put(String url, Map credits) async {
    // TODO: implement put
    var bodyData = json.encode(credits);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: TOKEN,
      },
      body: bodyData,
    );
    return response;
  }

  @override
  Future<Response> delete(String url, Map credits) async {
    var bodyData = json.encode(credits);
    var response = await http.delete(
      Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: TOKEN,
        },
        body: bodyData
    );
    return response;
  }
}