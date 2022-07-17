import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/viewProfile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bloodlink/widgets/navbar.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/screens/homepage.dart';

const red = Color(0xffde2c2c);
const primaryColor = Color(0xffc10110);
const accentColor = Color(0xffffffff);
const double borderRadius = 15;
var password = "";
var confirmPassword = "";
var opacity = 0.3;

class editPassword extends StatefulWidget {
  const editPassword({Key? key}) : super(key: key);

  @override
  State<editPassword> createState() => _editPasswordState();
}

class _editPasswordState extends State<editPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    passwordEditingController.dispose(); // newly added
    confirmPasswordEditingController.dispose(); // newly added
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final passwordField = passwordBuilder(
        label: "Password",
        hint: "Required",
        controller: passwordEditingController);
    final confirmPasswordField = passwordBuilder(
        label: "Confirm Password",
        hint: "Required",
        controller: confirmPasswordEditingController);

    return Scaffold(
        body: Container(
            width: width,
            child: ListView(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBarFb2(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: width * 0.1,
                            ),
                            passwordField,
                            SizedBox(
                              height: width * 0.1,
                            ),
                            confirmPasswordField,
                            buttonPair(formkey: _formkey, context: context)
                          ],
                        )),
                  )
                ],
              ),
            ])));
  }
}

class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarFb2({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffc10110);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
    );
  }
}

decoration(String label, String hint, red, opacity) => InputDecoration(
      labelText: label,
      errorMaxLines: 4,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hint,
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

edit_func(password) async {
  var url = base_url + "/editProfile/password";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In password");
  print(phone);
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone.toString() ?? "",
        'password': password,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["password"] == null) {
      print("it is null");
      await prefs.setString('password', "null");
    } else {
      await prefs.setString('password', parse["password"].toString());
    }
    print("Message received:");
    print(parse["password"]);
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
      onChanged: (value) => {
            if (widget.label == "Password")
              value != null ? password = value : null
            else
              value != null ? confirmPassword = value : null
          },
      onSaved: (value) => {
            if (widget.label == "Password")
              value != null ? password = value : null
            else
              value != null ? confirmPassword = value : null
          });

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}

class buttonPair extends StatelessWidget {
  GlobalKey<FormState> formkey;
  var context;
  buttonPair({required this.formkey, required this.context, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
        child: Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.03, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: OutlinedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.center,
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          right: 30, left: 30, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      )),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => viewProfile())),
                  child: Text(
                    "Cancel",
                    style: const TextStyle(color: primaryColor, fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.02, 0, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.center,
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          right: 30, left: 30, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)),
                      )),
                  onPressed: () async {
                    print("Continue pls");

                    final form = formkey.currentState;
                    if (form != null && form.validate()) {
                      print("worked!");
                      print(password);
                      print(confirmPassword);
                      if (password != confirmPassword) {
                        errorGenerator(context, "Passwords don't match",
                            "Please enter same passwords and try again");
                      } else {
                        print("so far so good");
                      }
                      await edit_func(password);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? msg = prefs.getString("password");
                      print("message is:");
                      print(msg);
                      if (msg == "null") {
                        errorGenerator(context, "Error",
                            "There was an error with the server. \nPlease try again later.");
                      } else {
                        UserSimplePreferences.setPassword(password);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => homepage(
                                  userName: "user",
                                )));
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
