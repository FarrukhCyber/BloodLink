import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';

class editProfile extends StatefulWidget {
  String phoneNo;
  editProfile({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController();
  String dropDownValue = 'A Positive (A+)';
  String genderValue = 'Male';
  var name = "";
  var pass = "";
  var confirmPass = "";
  var phone = "";
  var email = "";
  var age = "";
  var gender = "Male";
  var blood = 'A Positive (A+)';
  var items = [
    'A Positive (A+)',
    'A Negative (A-)',
    'B Positive (B+)',
    'B Negative (B-)',
    'O Positive (O+)',
    'O Negative (O-)'
  ];
  var genderItems = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController, //check this
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        //emailEditingController.text = value!;
        email = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordEditingController, //check this
      onChanged: (value) {
        //passwordEditingController.text = value!;
        pass = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPasswordEditingController, //check this
      onChanged: (value) {
        // confirmPasswordEditingController.text = value!;
        confirmPass = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final userNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: userNameEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        name = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final phoneField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: phoneNumberEditingController, //check this
      onChanged: (value) {
        // phoneNumberEditingController.text = value!;
        phone = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            print("In func");
            print(name);
            print(pass);
            print(confirmPass);
            print(phone);
            print(blood);
            print(email);
            print("Hello from signup on press");
            if (pass != confirmPass) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Passwords dont match'),
                        content: const Text('Please re-enter the passwords'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ok'),
                            child: const Text('Ok'),
                          ),
                        ],
                      ));
            } else {
              await signup_func(name, pass, email, phone, blood, gender, age);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? msg = prefs.getString("signup");
              print("message is:");
              print(msg);
              if (msg == "Email exists") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Email exists'),
                          content: const Text(
                              'Please choose another email or login'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],
                        ));
              } else if (msg != "null") {
                UserSimplePreferences.setUsername(name); // CHECK --
                UserSimplePreferences.setEmail(email); // CHECK --
                UserSimplePreferences.setPhoneNumber(phone); // CHECK --
                UserSimplePreferences.setGender(gender); // CHECK --
                UserSimplePreferences.setBloodType(blood); // CHECK --
                UserSimplePreferences.setAge(age); // CHECK --
                UserSimplePreferences.setPassword(pass); // CHECK --
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => homepage(
                          userName: name,
                        )));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('There was an error'),
                          content: const Text('Checking'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],
                        ));
              }
            }
          },
          child: Text(
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final ageField = TextFormField(
      autofocus: false,
      controller: ageEditingController, //check this
      keyboardType: TextInputType.number,
      onChanged: (value) {
        //emailEditingController.text = value!;
        age = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Age",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloodlink"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "UserName",
                      ),
                      SizedBox(height: 5),
                      userNameField,
                      SizedBox(height: 35),
                      Text(
                        "Email",
                      ),
                      SizedBox(height: 5),
                      emailField,
                      SizedBox(height: 35),
                      Text(
                        "Password",
                      ),
                      SizedBox(height: 5),
                      passwordField,
                      SizedBox(height: 35),
                      Text(
                        "Confirm Password",
                      ),
                      SizedBox(height: 5),
                      confirmPasswordField,
                      SizedBox(height: 35),
                      Text(
                        "Phone",
                      ),
                      SizedBox(height: 5),
                      phoneField,
                      SizedBox(height: 35),
                      Text(
                        "Age",
                      ),
                      SizedBox(height: 5),
                      ageField,
                      SizedBox(height: 20),
                      DropdownButton(
                        value: dropDownValue, // Change
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                            blood = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButton(
                        value: genderValue, // Change
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: genderItems.map((String genderItems) {
                          return DropdownMenuItem(
                            value: genderItems,
                            child: Text(genderItems),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderValue = newValue!;
                            gender = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      signupButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ))),
      )),
    );
  }
}

signup_func(name, pass, email, phone, blood, gender, age) async {
  var url = "http://localhost:8080/auth/signup";
  print("In signup");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': name,
        'password': pass,
        'phoneNumber': phone,
        'bloodType': blood,
        'email': email,
        'age': age,
        'gender': gender
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["signup"] == null) {
      print("it is null");
      // message = "null";
      await prefs.setString('signup', "null");
    } else
      await prefs.setString('signup', parse["signup"]);

    print("Message received:");
    print(parse["signup"]);
  } on HttpException catch (err) {
    print(err);
    return null;
  } on Error catch (error) {
    print(error);
    return null;
  } on Object catch (error) {
    print(error);
    return null;
  }
}
