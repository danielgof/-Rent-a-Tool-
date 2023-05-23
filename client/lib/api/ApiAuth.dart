import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:rt_client/api/utils.dart';
import 'ApiMethodsImpl.dart';

class ApiAuth extends APIMethodsImpl {
//  TODO
  // 1) Login method
  Future<int> loginRequest(login, pass) async {
    String url = "$URL/api/v1/auth/login";
    Map credits = {
      "username": login,
      "password": pass
    };
    final response = await APIMethodsImpl().post(url, credits);
    var data = response.statusCode;
    return data;
  }
  // 2) Registration method
  Future<int> registrationRequest(username, pass, phone, email) async {
    String url = "$URL/api/v1/auth/register";
    Map credits = {
      "username": username,
      "phone": phone,
      "email": email,
      "password": pass,
    };
    final response = await APIMethodsImpl().post(url, credits);
    var data = response.statusCode;
    return data;
  }
  // 3) Upd info method
  Future<int> updProfile(uname, email, phone, pass) async {
    String url = "$URL/api/v1/auth/upd";
    String new_uname;
    if (uname == JWT.decode(TOKEN).payload["username"]) {
      new_uname = "";
    } else {
      new_uname = uname;
    }
    if (email == JWT.decode(TOKEN).payload["email"]) {
      email = "";
    }
    if (phone == JWT.decode(TOKEN).payload["phone"]) {
      phone = "";
    }
    if (pass == JWT.decode(TOKEN).payload["pass"]) {
      pass = "";
    }
    Map<String, String> credits = {
      "username": uname,
      "new_uname": new_uname,
      "email": email,
      "phone": phone,
      "passwd": pass,
    };
    final response = await put(url, credits);
    return response.statusCode;
  }
}