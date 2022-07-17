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
import 'package:csc_picker/csc_picker.dart';

const red = Color(0xffde2c2c);
const primaryColor = Color(0xffc10110);
const accentColor = Color(0xffffffff);
const double borderRadius = 15;
var opacity = 0.3;
String city = "";

class editRegion extends StatefulWidget {
  const editRegion({Key? key}) : super(key: key);

  @override
  State<editRegion> createState() => _editRegionState();
}

class _editRegionState extends State<editRegion>
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
                  Column(
                    children: [
                      SizedBox(
                        height: width * 0.1,
                      ),
                      Text(
                        'Region',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      regionFunction(),
                      buttonPair(formkey: _formkey, context: context)
                    ],
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

edit_func(city) async {
  var url = base_url + "/editProfile/region";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In region");
  print(phone);
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone.toString(),
        'region': city,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["region"] == null) {
      print("it is null");
      await prefs.setString('region', "null");
    } else {
      await prefs.setString('region', parse["region"].toString());
    }
    print("Message received:");
    print(parse["region"]);
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

class regionFunction extends StatefulWidget {
  const regionFunction({Key? key}) : super(key: key);

  @override
  State<regionFunction> createState() => _regionFunctionState();
}

class _regionFunctionState extends State<regionFunction> {
  @override
  Widget build(BuildContext context) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Adding CSC Picker Widget in app
          CSCPicker(
            ///Enable disable state dropdown [OPTIONAL PARAMETER]
            ///
            ///
            showStates: true,

            /// Enable disable city drop down [OPTIONAL PARAMETER]
            showCities: true,

            ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
            flagState: CountryFlag.DISABLE,

            ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1)),

            ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1)),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Pakistan",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            stateDropdownLabel: "Province",
            cityDropdownLabel: "City",

            ///Default Country
            defaultCountry: DefaultCountry.Pakistan,

            ///Disable country dropdown (Note: use it with default country)
            disableCountry: true,

            ///selected item style [OPTIONAL PARAMETER]
            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 5.0,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 5.0,

            ///triggers once country selected in dropdown

            ///triggers once state selected in dropdown
            onCountryChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value ?? "";
              });
            },

            ///triggers once city selected in dropdown
            onCityChanged: (value) {
              setState(() {
                ///store value in city variable
                cityValue = value ?? "";
                city = value ?? "";
              });
            },
          )
        ],
      ),
    );
  }
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
                    print("worked!");
                    print(city);
                    await edit_func(city);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? msg = prefs.getString("region");
                    print("message is:");
                    print(msg);
                    if (msg == "null") {
                      errorGenerator(context, "Error",
                          "There was an error with the server. \nPlease try again later.");
                    } else {
                      UserSimplePreferences.setRegion(city);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => homepage(
                                userName: "user",
                              )));
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
