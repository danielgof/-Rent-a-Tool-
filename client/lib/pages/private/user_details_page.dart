import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:async/async.dart';
// import 'package:path/path.dart' as Path;

import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../../api/utils.dart';
import 'main_page_private.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({
    super.key,
  });

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  static var token = Utils.TOKEN;
  // static var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZW1haWwiOiJDYXBpdGFuSkxAbWFpbC5jb20iLCJwaG9uZSI6IisxOTk5MzQ1OTg3MiIsInBhc3MiOiJOQ0MtMTcwMS1EIiwiZXhwIjoxNzE1OTkyNzI2fQ.pVruL9qUrBCZj2rmdFNfequUZ0DNX5dExK9AZByn8Qw";
  String username = JWT.decode(token).payload["phone"];
  String email = JWT.decode(token).payload["phone"];
  String phone = JWT.decode(token).payload["phone"];
  String pass = JWT.decode(token).payload["phone"];

  String _base64 = "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";
  // String _base64 = "";

  @override
  void initState() {
    _getAvatar();
    // (() {
    //   var _bs64 = _getAvatar();
    //   setState(() {
    //     _base64 = _bs64.toString();
    //   });
    // })();
    super.initState();
  }

  FocusNode funame = FocusNode();
  FocusNode fphone = FocusNode();
  FocusNode femail = FocusNode();
  FocusNode fpass = FocusNode();

  var unameController =
      TextEditingController(text: JWT.decode(Utils.TOKEN).payload["username"]);
  var emailController =
      TextEditingController(text: JWT.decode(Utils.TOKEN).payload["email"]);
  var phoneController =
      TextEditingController(text: JWT.decode(Utils.TOKEN).payload["phone"]);
  var passController =
      TextEditingController(text: JWT.decode(Utils.TOKEN).payload["pass"]);

  AlertDialog alert = const AlertDialog(
    title: Text("User's details updated successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  Future<int> updProfile(uname, email, phone, pass) async {
    String url = "$URL/api/v1/auth/upd";
    String new_uname;
    if (uname == JWT.decode(Utils.TOKEN).payload["username"]) {
      new_uname = "";
    } else {
      new_uname = uname;
    }
    if (email == JWT.decode(Utils.TOKEN).payload["email"]) {
      email = "";
    }
    if (phone == JWT.decode(Utils.TOKEN).payload["phone"]) {
      phone = "";
    }
    if (pass == JWT.decode(Utils.TOKEN).payload["pass"]) {
      pass = "";
    }
    Map<String, String> credits = {
      "username": uname,
      "new_uname": new_uname,
      "email": email,
      "phone": phone,
      "passwd": pass,
    };
    var bodyData = json.encode(credits);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: Utils.TOKEN,
      },
      body: bodyData,
    );
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
      throw Exception("Failed to upd user\'s info");
    }
  }

  Future<void> sendFileToApi(Uint8List fileBytes, String fileName) async {
    String url = "$URL/api/v1/auth/save_avatar";
    // Create a POST request with the file content as the request body
    var headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzEzMDEwMTEzfQ.4Yas1txQ9uK3xDafKzwjpUpLB59wpvvY44M-14E6Ook'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:5000/api/v1/auth/save_avatar'));
    request.files.add(
      await http.MultipartFile.fromBytes(
        'logo',
        fileBytes,
        filename: fileName,
      ),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  File? imageFile;

  _getFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = File(result.files.single.path!);
      String? fileName = result.files.single.name;
      // Retrieve the file as Uint8List
      Uint8List? fileBytes = result.files.single.bytes;
      // print("=========================");
      // print(fileName);

      if (fileBytes != null) {
        // Process the file further as per your requirement
        // For example, you can upload the file to a server using the sendImageToServer function mentioned in the previous response
        await sendFileToApi(fileBytes, fileName);
        // Print the file size
        print('Selected file size: ${fileBytes.lengthInBytes} bytes');
      } else {
        // File bytes are null
        print('Failed to read file');
      }
    } else {
      // User canceled the file selection
      print('No file selected');
    }
  }

  Future<void> _getAvatar() async {
    var headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkpMIiwiZXhwIjoxNzEzMDEwMTEzfQ.4Yas1txQ9uK3xDafKzwjpUpLB59wpvvY44M-14E6Ook'
    };
    var request = http.Request(
        'GET', Uri.parse('http://localhost:5000/api/v1/auth/avatar'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("==============================");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // setState(() async {
      //   _base64 = await response.stream.bytesToString();  
      // });
      print(_base64);
      // setState(() async {
      // });
      // return response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
      throw Exception("Failed to upd user\'s info");
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytesImage = const Base64Decoder().convert(_base64);
    // var unameController = TextEditingController(text: username);
    // var emailController = TextEditingController(text: email);
    // var phoneController = TextEditingController(text: phone);
    // var passController = TextEditingController(text: pass);
    // print(JWT.decode(Utils.TOKEN).payload);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("User\' profile page",
                      style: Theme.of(context).textTheme.headlineMedium),
                  // const CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //       "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"),
                  //   maxRadius: 40,
                  // ),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: MemoryImage(bytesImage),
                          //  NetworkImage(
                          //     "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"),
                        ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () {
                                _getAvatar();
                                print("worked!!!!");
                              },
                              elevation: 2.0,
                              fillColor: Color(0xFFF5F6F9),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )),
                      ],
                    ),
                  ),
                  // Center(
                  //   child: Image.memory(bytesImage, width: 200, height: 200),
                  // ),
                  TextButton(
                    onPressed: () {
                      _getFromGallery();
                    },
                    child: const Text("Select image."),
                  ),
                  TextButton(
                    onPressed: () {
                      // _getFromGallery();
                      print(imageFile);
                      // _saveLogo(imageFile!);
                    },
                    child: const Text("Save image."),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Username: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      EditableText(
                        controller: unameController,
                        focusNode: funame,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.blue,
                      ),
                    ]
                        .map((widget) => Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: widget,
                            )))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Email: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      EditableText(
                        controller: emailController,
                        focusNode: femail,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.blue,
                      ),
                    ]
                        .map((widget) => Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: widget,
                            )))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Phone: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      EditableText(
                        controller: phoneController,
                        focusNode: fphone,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.blue,
                      ),
                    ]
                        .map((widget) => Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: widget,
                            )))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Pass: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      EditableText(
                        controller: passController,
                        focusNode: fpass,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.blue,
                      ),
                    ]
                        .map((widget) => Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: widget,
                            )))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        // print("clicked");
                        String uname = unameController.value.text;
                        String email = emailController.value.text;
                        String phone = phoneController.value.text;
                        String pass = passController.value.text;
                        print(uname);
                        var statusCode = updProfile(uname, email, phone, pass);
                        if (statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        } else {
                          throw Exception("Failed to upd user\'s info");
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => PrivateMain(),
                        //   ),
                        // );
                      },
                      child: const Text(
                        "UPD INFO",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {
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
                        "Return back.",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
