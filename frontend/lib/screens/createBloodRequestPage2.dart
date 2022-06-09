import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/screens/request_success_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // var bloodGroups = [
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/createBloodRequestPage3.dart';

import '../utils/user_info.dart';

class CreateBloodRequestPage2 extends StatelessWidget {
  const CreateBloodRequestPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            AppBarFb2(),
            TopBarFb3(
                title: "Initiate a Request",
                upperTitle: "\nWhere is the blood required?"),
            const CurrentLocation(
              heading: "Use my current location",
              text: "\nUse your current location as required \n location",
              symbol: Icons.my_location,
            ),
            const CustomLocation(
              heading: "Enter a custom location",
              text: "\nChoose a location manually on map   ",
              symbol: Icons.location_on,
            )
          ],
        ),
      ]),
      //   ),
      // ),
      // ),
    );
  }
}

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
      // gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
      // child: Padding(
      //   padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(title,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //         color: Colors.white70,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold)),
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
      // ),
    );
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
      actions: [
        // IconButton(
        // icon: Icon(
        // Icons.share,
        // color: accentColor,
        // ),
        // onPressed: () {},
        // )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: accentColor,
        ),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => homepage(
                  key: key,
                  userName: "user",
                ))),
      ),
    );
  }
}

class CurrentLocation extends StatelessWidget {
  @override
  final String heading;
  final String text;
  final IconData symbol;
  // final Size preferredSize;
  const CurrentLocation(
      {required this.heading,
      required this.text,
      required this.symbol,
      Key? key})
      : super(key: key);
  // CurrentLocation({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => {
            // print('Card tapped.')
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp()))
          },
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.0250,
                        MediaQuery.of(context).size.width * 0.0120,
                        0,
                        0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              heading,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 222, 44, 44),
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06),
                              textAlign: TextAlign.right,
                            ),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    // fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.15,
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Icon(
                      symbol,
                      color: Color.fromARGB(255, 222, 44, 44),
                      size: 36,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}

class CustomLocation extends StatelessWidget {
  @override
  final String heading;
  final String text;
  final IconData symbol;
  // final Size preferredSize;
  const CustomLocation(
      {required this.heading,
      required this.text,
      required this.symbol,
      Key? key})
      : super(key: key);
  // CustomLocation({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => {
            // print('Card tapped.');
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => EnterCustomLocation(
            //           key: key,
            //         )))
          },
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.0250,
                        MediaQuery.of(context).size.width * 0.0120,
                        0,
                        0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              heading,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 222, 44, 44),
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06),
                              textAlign: TextAlign.right,
                            ),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    // fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.15,
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Icon(
                      symbol,
                      color: Color.fromARGB(255, 222, 44, 44),
                      size: 36,
                    ),
                  ),
                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}