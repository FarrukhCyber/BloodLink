import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/screens/phone_auth.dart';
import 'signup.dart';
// import 'package:signup_signin/services/authenticate.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  var name = "";
  var pass = "";
  var message = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    userNameEditingController.dispose();
    passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var red = Color(0xffc10110);
    var backgroundColor = Color.fromARGB(255, 229, 229, 229);
    // appBar:
    // AppBar(title: const Text("Bloodlink"));
    final passwordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: passwordEditingController, //check this
        // onSaved: (value) {
        //   passwordEditingController.text = value!;
        //   pass = value;
        // },
        onChanged: (value) {
          pass = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            // prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            labelText: 'Password',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: red.withOpacity(.1), width: 2.0),
            )));
    final userNameField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        controller: userNameEditingController, //check this
        // onSaved: (value) {
        //   print(value);
        //   userNameEditingController.text = value!;
        //   name = value;
        // },
        // validator: (value) => value != null && !EmailValidator.validate(value)
        //     ? 'Enter a valid email'
        //     : null,
        onChanged: (value) {
          name = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          labelText: 'Username',
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: red.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: red, width: 2.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: red.withOpacity(.1), width: 2.0),
          ),
        ));
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            final form = _formkey.currentState;
            if (form != null && form.validate()) {
              // check this
              // checks if there is any validation issue
              print("Hello");
              await login_func(name, pass);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? msg = prefs.getString("msg");
              print("message is:");
              print(msg);
              if (msg != "null") {
                UserSimplePreferences.setUsername(
                    prefs.getString("userName") ?? "ERROR"); // CHECK --
                UserSimplePreferences.setEmail(
                    prefs.getString("email") ?? "ERROR");
                UserSimplePreferences.setPhoneNumber(
                    prefs.getString("phoneNumber") ?? "ERROR");
                UserSimplePreferences.setAge(prefs.getString("age") ?? "ERROR");
                UserSimplePreferences.setBloodType(
                    prefs.getString("bloodType") ?? "ERROR");
                UserSimplePreferences.setPassword(
                    prefs.getString("password") ?? "ERROR");
                UserSimplePreferences.setGender(
                    prefs.getString("gender") ?? "ERROR");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => homepage(
                          userName: name,
                        )));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Creddentials are Incorrect!'),
                          content: const Text(
                              'Please re-enter the credentials or signup instead'),
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
            "Login",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, color: Colors.white //Color(0xffC10100),
                    ),
          )),
    );
    final newButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
          },
          child: Text(
            "Create a new Account",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, color: Colors.white //Color(0xffC10100),
                    ),
          )),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            color: backgroundColor,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/bloodlink.png',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fill,
                        color: red,
                      ),
                      SizedBox(height: 35),
                      userNameField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 45),
                      loginButton,
                      SizedBox(height: 15),
                      newButton,
                    ],
                  ),
                ))),
      )),
    );
  }
}

login_func(name, pass) async {
  var url = "http://localhost:8080/auth/login";
  print("In login");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': name,
        'password': pass,
      }),
    );
    print("this one");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["msg"] == null) {
      print("it is null");
      // message = "null";
      await prefs.setString('msg', "null");
    } else {
      await prefs.setString('msg', parse["msg"]);
      await prefs.setString('userName', parse["userName"]);
      await prefs.setString('phoneNumber', parse["phoneNumber"]);
      await prefs.setString('bloodType', parse["bloodType"]);
      await prefs.setString('password', parse["password"]);
      await prefs.setString('gender', parse["gender"]);
      await prefs.setString('age', parse["age"]);
      await prefs.setString('email', parse["email"]);
      print("Here they are");
      print(parse["userName"]);
      print(parse["email"]);
      print(parse["gender"]);
      print(parse["age"]);
      print(parse["phoneNumber"]);
      print(parse["password"]);
      print(parse["bloodType"]);
    }

    print("Message received:");
    print(parse["msg"]);
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
