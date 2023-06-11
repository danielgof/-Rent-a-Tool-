import 'dart:convert';
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

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
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
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
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
