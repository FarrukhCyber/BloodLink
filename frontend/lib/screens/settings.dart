import 'package:bloodlink/screens/createBloodRequest.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/networkHandler.dart';

bool email = true;
bool notification = true;
bool available = true;
bool plasma = true;
bool disease = false;
bool diabetes = false;
bool vaccinated = false;
bool gotEm = false;
bool error = false;

NetworkHandler networkHandler = NetworkHandler();
String userPhoneNum = UserSimplePreferences.getPhoneNumber() ?? "Error";
// Future<void> fetchData() async {
//   final response = await networkHandler.get(
//       '/register_donor/fetch', userPhoneNum, "user_contact_num");
//   if (response.statusCode == 200) {
//     print(jsonDecode(response.body));
//     print(jsonDecode(response.body)["emailIs"]);
//     print(jsonDecode(response.body)["notificationIs"]);
//     print(jsonDecode(response.body)["availableIs"]);
//     if (jsonDecode(response.body)["fetch"] == null) {
//       print("fetch --- its null");
//       error = true;
//     } else {
//       email = jsonDecode(response.body)["emailIs"];
//       notification = jsonDecode(response.body)["notificationIs"];
//       available = jsonDecode(response.body)["availableIs"];
//       gotEm = true;
//       print("done with this");
//     }
//   }
// }

class Settings extends StatefulWidget {
  // final String userName;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _homepageState();
}

class _homepageState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Future<void> fetchData() async {
    final response = await networkHandler.get(
        '/register_donor/fetch', userPhoneNum, "user_contact_num");
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      print(jsonDecode(response.body)["emailIs"]);
      print(jsonDecode(response.body)["notificationIs"]);
      print(jsonDecode(response.body)["availableIs"]);
      if (jsonDecode(response.body)["fetch"] == null) {
        print("fetch --- its null");
        error = true;
      } else {
        setState(() {
          email = jsonDecode(response.body)["emailIs"];
          notification = jsonDecode(response.body)["notificationIs"];
          available = jsonDecode(response.body)["availableIs"];
          vaccinated = jsonDecode(response.body)["vaccinatedIs"];
          disease = jsonDecode(response.body)["diseaseIs"];
          diabetes = jsonDecode(response.body)["diabetesIs"];
          plasma = jsonDecode(response.body)["plasmaIs"];
          gotEm = true;
        });
        print("done with this");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    fetchData();
    if (error) {
      errorGenerator(
          context, "Error", "Problem in Server Connection. Please try later");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

//

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 229, 229, 229),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          width: width,
          child: ListView(children: [
            Column(children: [
              AppBarFb2(),
              TopBarFb3(
                  title: "Settings",
                  upperTitle: "\n View and Edit your account settings"),
              gotEm ? Text("") : Text("Loading..."),
              gotEm
                  ? TextwithCheckBox(
                      title: "Send me an email in case of a blood request",
                      symbol: email
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "email",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title: "Send me blood request notifications ",
                      symbol: notification
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "notification",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title: "Mark me available for donation",
                      symbol: available
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "available",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title: "Mark me available for plasma donation",
                      symbol: available
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "plasma",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title:
                          "Are you vaccinated? \n(Check for Yes. Uncheck for No)",
                      symbol: available
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "vaccinated",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title:
                          "Do you have diabetes? \n(Check for Yes. Uncheck for No)",
                      symbol: available
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "diabetes",
                    )
                  : Text(""),
              gotEm
                  ? TextwithCheckBox(
                      title:
                          "Do you have any blood diseases? \n(Check for Yes. Uncheck for No)",
                      symbol: available
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank,
                      check: "disease",
                    )
                  : Text(""),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: Color(0xffc10110),
                      indent: MediaQuery.of(context).size.width * 0.05,
                      endIndent: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),
              PairButton(),
            ]),
          ]),
        )));
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

//the second bar
class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = Color(0xffc10110);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }
}

class TextwithCheckBox extends StatefulWidget {
  final String title;
  IconData symbol;
  var check;
  TextwithCheckBox(
      {required this.title,
      required this.symbol,
      required this.check,
      Key? key})
      : super(key: key);

  @override
  State<TextwithCheckBox> createState() => _TextwithCheckBoxState();
}

class _TextwithCheckBoxState extends State<TextwithCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.width * 0.02, 0, 0),
        child: Column(
          children: [
            Divider(
              thickness: 1,
              color: Color(0xffc10110),
              indent: MediaQuery.of(context).size.width * 0.05,
              endIndent: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.width * 0.05, 0, 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05, 0, 0, 0),
                    child: Text(
                      widget.title,
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  new Spacer(),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.symbol == Icons.check_box_rounded) {
                              widget.symbol = Icons.check_box_outline_blank;
                            } else {
                              widget.symbol = Icons.check_box_rounded;
                            }
                          });
                          if (widget.check == "email")
                            email = !email;
                          else if (widget.check == "notification")
                            notification = !notification;
                          else if (widget.check == "available")
                            available = !available;
                          else if (widget.check == "vaccinated")
                            vaccinated = !vaccinated;
                          else if (widget.check == "plasma")
                            plasma = !plasma;
                          else if (widget.check == "diabetes")
                            diabetes = !diabetes;
                          else if (widget.check == "disease")
                            disease = !disease;
                        },
                        icon: Icon(widget.symbol,
                            color: Color(0xffc10110),
                            size: MediaQuery.of(context).size.width * 0.08)),
                  )
                ],
              ),
            ),
          ],
        ));
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class PairButton extends StatelessWidget {
  const PairButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffc10110);
    // const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);

    const double borderRadius = 15;

    return DecoratedBox(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
        child: Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.03, 0, 0),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.1, 0, 0, 0),
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
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => homepage(
                            key: key,
                            userName: "user",
                          ))),
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

                    await setting_func(email, notification, available,
                        vaccinated, diabetes, disease, plasma);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? msg = prefs.getString("setting");
                    print("message is:");
                    print(msg);
                    if (msg == "null") {
                      errorGenerator(context, "Error",
                          "There was an error with the server. \nPlease try again later.");
                    } else {
                      errorGenerator(context, "Confirmed",
                          "Your preferences are updated!");
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => homepage(
                              key: key,
                              userName: "user",
                            )));
                  },
                  // onPressed: () => CreateBloodRequestPage2(key: key),
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

setting_func(email, notification, available, vaccinated, diabetes, disease,
    plasma) async {
  var url = base_url + "/register_donor/settings";
  var phone = UserSimplePreferences.getPhoneNumber();
  print("In settings");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone": phone ?? "",
        'email': email,
        'notification': notification,
        'available': available,
        'vaccinated': vaccinated,
        'disease': disease,
        'plasma': plasma,
        'diabetes': diabetes
      }),
    );
    print("this one");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["setting"] == "null") {
      print("it is null");
      await prefs.setString('setting', "null");
    } else {
      await prefs.setString('setting', parse["msg"].toString());

      print("Here they are");
      print(parse["email"]);
      print(parse["notification"]);
      print(parse["available"]);
    }
    print("Message received:");
    print(parse["setting"]);
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
