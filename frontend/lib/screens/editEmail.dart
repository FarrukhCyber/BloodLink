import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:bloodlink/screens/editPageProfile.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/registerDonor.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/widgets/navbar.dart';
import 'package:bloodlink/widgets/optionCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/base_url.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

const red = Color(0xffde2c2c);
const primaryColor = Color(0xffc10110);
const accentColor = Color(0xffffffff);
const double borderRadius = 15;

class editEmail extends StatefulWidget {
  const editEmail({Key? key}) : super(key: key);

  @override
  State<editEmail> createState() => _editEmailState();
}

class _editEmailState extends State<editEmail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final emailEditingController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  var email = "";
  var opacity = 0.3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailEditingController.dispose(); // newly added
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController, //check this
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        value != null ? email = value : null;
        print("save");
        print(value);
      },
      onChanged: (value) {
        value != null ? email = value : null;
        print("change");
        print(value);
      },
      validator: (value) => value != null && !EmailValidator.validate(value)
          ? 'Enter a valid email'
          : null,
      textInputAction: TextInputAction.next,
      decoration: decoration("Email", "Required", red, opacity),
    );
    return Scaffold(
        body: Container(
            width: width,
            child: ListView(children: <Widget>[
              Column(
                children: [
                  AppBarFb2(),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: width * 0.1,
                          ),
                          emailField,
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    MediaQuery.of(context).size.height * 0.03,
                                    0,
                                    0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                          0,
                                          0,
                                          0),
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            alignment: Alignment.center,
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.only(
                                                    right: 30,
                                                    left: 30,
                                                    top: 10,
                                                    bottom: 10)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        borderRadius),
                                              ),
                                            )),
                                        onPressed: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    editPageProfile())),
                                        child: Text(
                                          "Cancel",
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                          0,
                                          0,
                                          0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            alignment: Alignment.center,
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.only(
                                                    right: 30,
                                                    left: 30,
                                                    top: 10,
                                                    bottom: 10)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          borderRadius)),
                                            )),
                                        onPressed: () async {
                                          print("Continue pls");
                                          var oldEmail =
                                              UserSimplePreferences.getEmail();

                                          final form = _formkey.currentState;
                                          print(form.toString());
                                          if (form != null && form.validate()) {
                                            if (email == oldEmail) {
                                              print("same email entered");
                                              // in case they enter same email
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          homepage(
                                                            userName: "user",
                                                          )));
                                            } else {
                                              print("worked!");
                                              await edit_func(email);
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String? msg =
                                                  prefs.getString("edit");
                                              print("message is:");
                                              print(msg);
                                              if (msg == "null") {
                                                errorGenerator(context, "Error",
                                                    "There was an error with the server. \nPlease try again later.");
                                              } else if (msg == "exists") {
                                                errorGenerator(
                                                    context,
                                                    "Email exists",
                                                    "Please enter another email");
                                              } else {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            homepage(
                                                              userName: "user",
                                                            )));
                                              }
                                            }
                                          }
                                        },
                                        // onPressed: () => CreateBloodRequestPage2(key: key),
                                        child: Text(
                                          "Submit",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ))
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
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.keyboard_arrow_left,
      //     color: accentColor,
      //   ),
      //   onPressed: () {},
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

edit_func(email) async {
  var url = base_url + "/editProfile/email";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In email");
  print(phone);
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone.toString() ?? "",
        'email': email,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["edit"] == null) {
      print("it is null");
      await prefs.setString('edit', "null");
    } else {
      await prefs.setString('edit', parse["edit"].toString());
    }
    print("Message received:");
    print(parse["edit"]);
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
