import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

DateTime dateSelection = DateTime.now();
var red = Color(0xffde2c2c);
var backgroundColor = Color.fromARGB(255, 229, 229, 229);
var darkred = Color(0xffc10110);
var opacity = 0.3;
var pass = "";
var confirmPass = "";

class changePassword extends StatefulWidget {
  String phoneNo;
  changePassword({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController();

  var name = "";
  var phone = "";
  var email = "";
  var age = "";

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailEditingController.dispose(); // newly added
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    userNameEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController, //check this
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      validator: (value) => value != null && !EmailValidator.validate(value)
          ? 'Enter a valid email'
          : null,
      textInputAction: TextInputAction.next,
      decoration: decoration("Email", "Required", red, opacity),
    );
    final passwordField = passwordBuilder(
        label: "Password",
        hint: "Required",
        controller: passwordEditingController);
    final confirmPasswordField = passwordBuilder(
        label: "Confirm New Password",
        hint: "Required",
        controller: confirmPasswordEditingController);
    final userNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: userNameEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        name = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Username", "Required", red, opacity),
    );
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            final form = _formkey.currentState;
            if (form != null && form.validate()) {
              print(name);
              print(pass);
              print(confirmPass);
              print(widget.phoneNo);
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
                await signup_func(pass, widget.phoneNo);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? msg = prefs.getString("signup");
                print("message is:");
                print(msg);
                if (msg == "null") {
                  errorGenerator(
                      context, "Empty fields", "Please fill all the fields");
                } else if (msg == "updated") {
                  print("IT WORKED"); // CHECK --/ CHECK --
                  Fluttertoast.showToast(
                      msg: "Password Changed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 193, 0, 0),
                      textColor: Colors.white,
                      fontSize: 16.0);
                  UserSimplePreferences.setPassword(pass); // CHECK --
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => login()));
                } else {
                  print("THERE WAS AN ERROR");
                  errorGenerator(context, 'There was an error in server',
                      'Please try again in some time');
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //           title: const Text('There was an error in server'),
                  //           content:
                  //               const Text('Please try again in some time'),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               onPressed: () => Navigator.pop(context, 'Ok'),
                  //               child: const Text('Ok'),
                  //             ),
                  //           ],
                  //         ));
                }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloodlink"),
        backgroundColor: red,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 35),
                      confirmPasswordField,
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

signup_func(pass, phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("TESTING");

  var url = base_url + "/password_change";
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'password': pass,
        'phoneNumber': phone,
      }),
    );
    var parse = jsonDecode(response.body);
    if (parse["msg"] == "null") {
      print("it is null");
      // message = "null";
      await prefs.setString('signup', "null");
    } else
      await prefs.setString('signup', parse["msg"]);

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

decoration(String label, String hint, red, opacity) => InputDecoration(
      labelText: label,
      errorMaxLines: 4,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hint,
      labelStyle: TextStyle(color: red),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: red.withOpacity(opacity), width: 2.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: red, width: 2.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: red, width: 2.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: red.withOpacity(opacity), width: 2.0),
      ),
    );

class passwordBuilder extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  const passwordBuilder(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller})
      : super(key: key);

  @override
  State<passwordBuilder> createState() => _passwordBuilderState();
}

class _passwordBuilderState extends State<passwordBuilder> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) => TextFormField(
      controller: widget.controller,
      obscureText: isHidden,
      decoration: InputDecoration(
        errorMaxLines: 4,
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: widget.hint,
        labelStyle: TextStyle(color: red),
        suffixIcon: IconButton(
          color: red,
          icon: isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onPressed: togglePasswordVisibility,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: red.withOpacity(opacity), width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: red, width: 2.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: red, width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: red.withOpacity(opacity), width: 2.0),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      autofillHints: [AutofillHints.password],
      validator: (password) => checkPass(password ?? "") == false
          ? 'Enter minimum 8 characters + 1 Uppercase + 1 Digit + 1 Special Character'
          : null,
      onChanged: (password) => {
            if (widget.label == "Password")
              pass = password
            else
              confirmPass = password
          },
      onSaved: (password) => {
            if (widget.label == "Password")
              password != null ? pass = password : null
            else
              password != null ? confirmPass = password : null
          });

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}

errorGenerator(context, title, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Ok'),
                child: const Text('Ok'),
              ),
            ],
          ));
}

bool checkPass(String password) {
  print("in pass");
  print(password);
  if (password == null || password.isEmpty) {
    return false;
  }
  var minLength = 8;

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  print("Returning");
  print(hasDigits & hasUppercase & hasSpecialCharacters & hasMinLength);
  return hasDigits & hasUppercase & hasSpecialCharacters & hasMinLength;
}
