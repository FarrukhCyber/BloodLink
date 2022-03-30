import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signup_signin/screens-2/homepage.dart';
import 'signup.dart';
// import 'package:signup_signin/services/authenticate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signup_signin/screens-2/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final userNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: userNameEditingController, //check this
      // onSaved: (value) {
      //   print(value);
      //   userNameEditingController.text = value!;
      //   name = value;
      // },
      onChanged: (value) {
        name = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            print("Hello");
            login_func(name, pass);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? msg = prefs.getString("msg");
            print(msg);
            if (msg != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homepage()));
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final newButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => signup()));
          },
          child: Text(
            "Create a new Account",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
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
                      Image.asset('assets/bloodlink.png',
                          height: 100, fit: BoxFit.fill),
                      SizedBox(height: 35),
                      userNameField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 20),
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
  var url = "http://localhost:8080/login";
  print("In login");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'pass': pass,
      }),
    );
    print("this one");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    await prefs.setString('msg', parse["msg"]);
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
