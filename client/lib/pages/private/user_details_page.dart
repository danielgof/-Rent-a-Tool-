import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';
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

  // Variable to store avatar's file
  File? imageFile;

  AlertDialog alertUpdate = const AlertDialog(
    title: Text("User's details updated successfully"),
    // content: Text("This is my message."),
    // actions: [
    //   okButton,
    // ],
  );

  AlertDialog alertAvatar = const AlertDialog(
    title: Text("Avatar has been updated."),
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
          return alertUpdate;
        },
      );
      return response.statusCode;
    } else {
      throw Exception("Failed to upd user\'s info");
    }
  }

  Future<void> sendFileToApi(String file) async {
    String url = "$URL/api/v1/auth/save_avatar";
    var headers = {
      "Authorization": Utils.TOKEN,
    };
    // print(file);
    var data = {
      "img": file,
    };
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(),
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertAvatar;
        },
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  /*
    Gets file from local storage and send it to server
   */
  Future<void> getFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    // FilePickerResult? result = await FilePickerWeb.platform.pickFiles();
    print("filed picked");

    if (result != null) {
      // File file = File(result.files.single.path!);
      String? fileName = result.files.single.name;
      /*
        Mobile verion of image loader
       */
      // String? filePath = result.files.single.path;
      // imageFile = File(filePath!);
      // Uint8List? fileBytes = imageFile?.readAsBytesSync();
      /*
        Web version of image loader
       */
      // Retrieve the file as Uint8List
      Uint8List? fileBytes = result.files.single.bytes;
      if (fileBytes != null) {
        // Process the file further as per your requirement
        // For example, you can upload the file to a server using the sendImageToServer function mentioned in the previous response
        // print(result.files.single.toString());
        String file = base64Encode(fileBytes);
        // new String.fromCharCodes(fileBytes);
        await sendFileToApi(file);
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

  Future<String> fetchImageBytes() async {
    Map<String, String> head = new Map<String, String>();
    head['Authorization'] = Utils.TOKEN;
    final response =
        await http.get(Uri.parse("$URL/api/v1/auth/avatar"), headers: head);
    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      return json.decode(response.body)["message"];
    } else {
      // return "Failed";
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  Text(
                      JWT.decode(Utils.TOKEN).payload["username"] +
                          "\'s profile page",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Container(
                    child: FutureBuilder<String>(
                      future: fetchImageBytes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                    "assets/placeholders/user.png",
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -25,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      getFromGallery();
                                      print("worked!!!!");
                                    },
                                    elevation: 2.0,
                                    fillColor: Color(0xFFF5F6F9),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // return Text('Error: ${snapshot.error}');
                          return SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                      "assets/placeholders/user.png"),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -25,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      // _getAvatar();
                                      getFromGallery();
                                      print("worked!!!!");
                                    },
                                    elevation: 2.0,
                                    fillColor: Color(0xFFF5F6F9),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          Uint8List bytesImage =
                              const Base64Decoder().convert(snapshot.data!);
                          return SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(bytesImage),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -25,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      // _getAvatar();
                                      getFromGallery();
                                      print("worked!!!!");
                                    },
                                    elevation: 2.0,
                                    fillColor: Color(0xFFF5F6F9),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          );
                          // CircleAvatar(backgroundImage: MemoryImage(bytesImage),);
                          // return Image.memory(bytesImage);
                        } else {
                          return const Text("No image data");
                        }
                      },
                    ),
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
                        setState(() {});
                        // ignore: unrelated_type_equality_checks
                        if (statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertUpdate;
                            },
                          );
                        } else {
                          throw Exception("Failed to upd user\'s info");
                        }
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
