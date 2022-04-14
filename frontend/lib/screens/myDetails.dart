import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/edit_profile.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/user_profile.dart';
import 'package:bloodlink/utils/user_info.dart';

class myDetails extends StatefulWidget {
  String attendantName;
  String attendantNum;
  String bloodGroup;
  String status;
  String userContact;
  String date;
  String time;
  String quantity;
  String hospital;
  String id;
  //String city;
  myDetails({
    Key? key,
    required this.attendantName,
    required this.attendantNum,
    required this.bloodGroup,
    required this.status,
    required this.userContact,
    required this.date,
    required this.time,
    required this.hospital,
    required this.quantity,
    required this.id,
  })
  //required this.city
  //})
  : super(key: key);

  @override
  State<myDetails> createState() => _myDetailsState();
}

class _myDetailsState extends State<myDetails> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(title: Text("Bloodlink")),
        body: Column(
          children: [
            AppBarFb2(),
            TopBarFb3(title: "BloodLink", upperTitle: "\nRequest Information"),
            Heading(
                title: "\n  Request Information", phoneNum: widget.userContact),
            Divider(
              height: 5,
              color: Color(0xffc10110),
              indent: MediaQuery.of(context).size.width * 0.05,
              endIndent: MediaQuery.of(context).size.width * 0.05,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 10)),
            DisplayInfo(label: "Attendent Name", data: widget.attendantName),
            DisplayInfo(label: "Attendent Number", data: widget.attendantNum),
            DisplayInfo(label: "Blood Group", data: widget.bloodGroup),
            DisplayInfo(label: "Quantity", data: widget.quantity),
            DisplayInfo(label: "Date", data: widget.date),
            DisplayInfo(label: "Time", data: widget.time),
            DisplayInfo(label: "Status", data: widget.status),
            DisplayInfo(
                label: "Hospital",
                data: "${widget.hospital} "), //, ${widget.city}"),
          ],
        ));
  }
}

class DisplayInfo extends StatelessWidget {
  final String label;
  final String data;
  DisplayInfo({Key? key, required this.label, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data,
              style: TextStyle(color: Color(0xff4B545A)),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

// the app bar
class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarFb2({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffde2c2c);
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

//contains "personal information" and edit button
class Heading extends StatelessWidget {
  final String title;
  final String phoneNum;
  Heading({required this.title, required this.phoneNum, Key? key})
      : super(key: key);
  final primaryColor = const Color.fromARGB(255, 222, 44, 44);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  final double borderRadius = 15;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: accentColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // this is personal information
            style: const TextStyle(
                color: Color.fromARGB(255, 222, 44, 44),
                fontSize: 15,
                fontWeight: FontWeight.bold),
            // textAlign: TextAlign.left,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.40),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.centerRight,
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)),
                      )),
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editProfile(
                              phoneNo: phoneNum,
                            )))
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Color(0xffffffff), fontSize: 16),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

//the second bar
class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = Color.fromARGB(255, 222, 44, 44);
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
