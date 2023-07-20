import 'package:shared_preferences/shared_preferences.dart';

// const String URL = "https://brodon.pythonanywhere.com";
const String URL = "http://localhost:5000";

class Utils {
  static String TOKEN = "";
  // static String TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZW1haWwiOiJDYXBpdGFuSkxAbWFpbC5jb20iLCJwaG9uZSI6IisxOTk5MzQ1OTg3MiIsInBhc3MiOiJOQ0MtMTcwMS1EIiwiZXhwIjoxNzE1OTkyNzI2fQ.pVruL9qUrBCZj2rmdFNfequUZ0DNX5dExK9AZByn8Qw";
  // Future<void> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String tokenTmp = prefs.getString("JWT").toString();
  //   print("===============================");
  //   print(tokenTmp);
  //   TOKEN = tokenTmp;
  // }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('key').toString();
    return stringValue;
  }
}
