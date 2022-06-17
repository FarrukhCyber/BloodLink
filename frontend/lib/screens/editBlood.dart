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

const red = Color(0xffde2c2c);
const primaryColor = Color(0xffc10110);
const accentColor = Color(0xffffffff);
const double borderRadius = 15;
var opacity = 0.3;
var blood = '';
var bloodItems = [
  'Choose a blood group',
  'A Positive (A+)',
  'A Negative (A-)',
  'B Positive (B+)',
  'B Negative (B-)',
  'AB Positive (AB+)',
  'AB Negative (AB-)',
  'O Positive (O+)',
  'O Negative (O-)'
];
String bloodValue = 'Choose a blood group';

class editBlood extends StatefulWidget {
  const editBlood({Key? key}) : super(key: key);

  @override
  State<editBlood> createState() => _editBloodState();
}

class _editBloodState extends State<editBlood>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                          DropDownMenu(
                              item: bloodItems,
                              dropDownValue: bloodValue,
                              selection: "blood"),
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

                                          final form = _formkey.currentState;
                                          if (form != null && form.validate()) {
                                            print("worked!");
                                            await edit_func(blood);
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? msg =
                                                prefs.getString("blood");
                                            print("message is:");
                                            print(msg);
                                            if (msg == "null") {
                                              errorGenerator(context, "Error",
                                                  "There was an error with the server. \nPlease try again later.");
                                            } else {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          homepage(
                                                            userName: "user",
                                                          )));
                                            }
                                          }
                                        },
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

edit_func(blood) async {
  var url = base_url + "/editProfile/blood";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In gender");
  print(phone);
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone.toString(),
        'blood': blood,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["blood"] == null) {
      print("it is null");
      await prefs.setString('blood', "null");
    } else {
      await prefs.setString('blood', parse["blood"].toString());
    }
    print("Message received:");
    print(parse["blood"]);
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

class DropDownMenu extends StatefulWidget {
  var item;
  String dropDownValue;
  String selection;
  DropDownMenu(
      {Key? key,
      required this.item,
      required this.dropDownValue,
      required this.selection})
      : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.01, 0, 0),
        child: DropdownButton(
          value: widget.dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: widget.item.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropDownValue = newValue!;
              blood = newValue;
            });
          },
        ));
  }
}
