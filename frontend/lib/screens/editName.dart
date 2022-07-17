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
var opacity = 0.3;
var name = "";

class editName extends StatefulWidget {
  const editName({Key? key}) : super(key: key);

  @override
  State<editName> createState() => _editNameState();
}

class _editNameState extends State<editName>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final userNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: userNameEditingController, //check this
      onChanged: (value) {
        name = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Username", "Required", red, opacity),
    );

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
                            userNameField,
                            buttonPair(
                              formkey: _formkey,
                              context: context,
                            ),
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

edit_func(name) async {
  var url = base_url + "/editProfile/name";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In name");
  print(phone);
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone.toString(),
        'name': name,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["name"] == null) {
      print("it is null");
      await prefs.setString('name', "null");
    } else {
      await prefs.setString('name', parse["name"].toString());
    }
    print("Message received:");
    print(parse["name"]);
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
                      await edit_func(name);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? msg = prefs.getString("name");
                      print("message is:");
                      print(msg);
                      if (msg == "null") {
                        errorGenerator(context, "Error",
                            "There was an error with the server. \nPlease try again later.");
                      } else {
                        UserSimplePreferences.setUsername(name);
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
