import 'package:flutter/material.dart';
import 'package:client/api/ApiAuth.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  String dropdownvalue = '+1, US';

  // List of items in our dropdown menu
  var items = [
    '+1, US',
    '+7, RUS',
    '+90 TUR',
  ];

  // Future<int> registrationRequest(username, pass, phone, email) async {
  //   String url = "$URL/api/v1/auth/register";
  //   Map credits = {
  //     "username": username,
  //     "phone": phone,
  //     "email":email,
  //     "password":pass,
  //   };
  //   var bodyData = json.encode(credits);
  //   final response = await http.post(Uri.parse(url), body: bodyData);
  //   var data = response.statusCode;
  //   return data;
  // }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Return to login page."),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Card(
          child: Container(
            constraints: BoxConstraints.loose(const Size(600, 600)),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Registration",
                  style: Theme.of(context).textTheme.headlineMedium),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Username",
                      hintText: "Enter username",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter secure password",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: emailController,
                    // onChanged: (String val) async {
                    //   String curEmail = emailController.value.text;
                    //   // print(emailController.value.text);
                    //   bool emailValid =
                    //   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(curEmail);
                    // },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "Enter email",
                    ),
                  ),
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Phone number",
                      hintText: "Enter ten digits phone number",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "By clicking REGISTER, you agree to our Terms and Privacy Policy.",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () async {
                      var username = usernameController.text;
                      var pass = passController.text;
                      var phone = dropdownvalue + phoneController.text;
                      var email = emailController.text;
                      bool phoneValid =
                      RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                          .hasMatch(phoneController.text);
                      bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (username != "" && pass != "" && phone != "" && email != "" && emailValid && phoneValid) {
                        var status = await ApiAuth().registrationRequest(username, pass, phone, email);
                        if (200 == status) {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Success!"),
                              content: const Text("The user was registered successfully."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, "OK"),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error!"),
                              content: const Text("The error occurred when register a user."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, "OK"),
                                  child: const Text("OK",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (context) =>
                            AlertDialog(
                              title: const Text("Error!"),
                              content: const Text(
                                  "All fields should be filled in order to register."),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "OK"),
                                  child: const Text("OK",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                        );
                      }
                    },
                    child: const Text("REGISTER",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: 26,
                      // width: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.facebook,
                        color: Colors.indigo,
                        size: 75,
                      ),
                    ),
                    Container(
                      // height: 26,
                      // width: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.reddit,
                        color: Colors.deepOrange,
                        size: 75,
                      ),
                    ),
                    Container(
                      // height: 26,
                      // width: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.alternate_email_sharp,
                        color: Colors.deepPurpleAccent,
                        size: 75,
                      ),
                    ),
                  ].map((widget) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: widget,
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ), // Center
    ); // Scaffold
  }
}