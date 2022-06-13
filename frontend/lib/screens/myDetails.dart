import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/editRequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/edit_profile.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/user_profile.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:url_launcher/url_launcher.dart';

String attendNum = "";

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
  String city;
  myDetails(
      {Key? key,
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
      required this.city})
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
                title: "\n  Request Information",
                name: widget.attendantName,
                number: widget.attendantNum,
                bloodType: widget.bloodGroup,
                date: widget.date,
                time: widget.time,
                location: widget.hospital,
                city: widget.city,
                quantity: widget.quantity),
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
            DisplayInfo(
                label: "Date",
                data: (widget.date.split('T')[0]).split('-')[2] +
                    "-" +
                    (widget.date.split('T')[0]).split('-')[1] +
                    "-" +
                    (widget.date.split('T')[0]).split('-')[0]),
            DisplayInfo(
                label: "Time",
                data: (widget.time.split('T')[1]).split(':')[0] +
                    ':' +
                    (widget.time.split('T')[1]).split(':')[1]),
            DisplayInfo(label: "Status", data: widget.status),
            DisplayInfo(
                label: "Hospital", data: "${widget.hospital} , ${widget.city}"),
            PairButton(
                text: "Hello",
                attendNumber: widget.attendantNum,
                userContact: widget.userContact)
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

//contains "personal information" and edit button
class Heading extends StatefulWidget {
  final String title;
  var name;
  var number;
  var bloodType;
  var date;
  var time;
  var location;
  var city;
  var quantity;

  Heading(
      {Key? key,
      required this.title,
      required this.name,
      required this.number,
      required this.bloodType,
      required this.date,
      required this.time,
      required this.location,
      required this.city,
      required this.quantity})
      : super(key: key);

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  final primaryColor = Color(0xffc10110);

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
            widget.title, // this is personal information
            style: const TextStyle(
                color: Color(0xffc10110),
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
                    print(widget.time),
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editRequest(
                            name: widget.name,
                            number: widget.number,
                            bloodType: widget.bloodType,
                            date: widget.date,
                            time: widget.time,
                            location: widget.location,
                            city: widget.city,
                            quantity: widget.quantity)))
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

class PairButton extends StatelessWidget {
  final String text;
  final String attendNumber;
  final String userContact;
  // final Function() onPressed;
  const PairButton(
      {required this.text,
      required this.attendNumber,
      required this.userContact,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffc10110);
    // const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);

    const double borderRadius = 15;

    return DecoratedBox(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)
                // gradient:
                // const LinearGradient(colors: [primaryColor, secondaryColor])
                ),
        child: Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.03, 0, 0),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.06, 0, 0, 0),
                child: Row(
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 30, left: 30, top: 10, bottom: 10)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          )),
                      onPressed: () async {
                        print("Notify button is pressed");
                        print("userContact: " + userContact);
                        print("Attend Number: " + attendNumber);
                        await sendNotification(userContact, attendNumber);
                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // String? msg = prefs.getString("send");
                        // print("message is:");
                        // print(msg);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text('Notified Successfully'),
                                    content: Text('The requestor has been notified that you are interested in donating blood'),
                                    actions: [
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {Navigator.pop(context);},
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                          },
                        );

                      },
                      child: Row(
                        children: [
                          Text(
                            "Notify",
                            style: const TextStyle(
                                color: primaryColor, fontSize: 16),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.02,
                                  0,
                                  0,
                                  0),
                              child: Icon(
                                Icons.notifications,
                                color: primaryColor,
                              ))
                        ],
                      ),
                    ),
                  ],
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
                  // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => CreateBloodRequestPage2(key: key))),
                  onPressed: () => {
                    print("contact button:"),
                    print(attendNumber),
                    _makePhoneCall(attendNumber)
                  },
                  // onPressed: () => CreateBloodRequestPage2(key: key),
                  child: Row(
                    children: [
                      Text(
                        "Contact",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.02,
                              0,
                              0,
                              0),
                          child: Icon(Icons.call, color: accentColor))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Future<void> _makePhoneCall(String url) async {
  url = 'tel:' + url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

sendNotification(userContact, attendNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = base_url + "/notify";
  print("In sendNotification");

  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'attendant_num': attendNumber,
        'user_contact_num': userContact,
      }),
    );

    // await prefs.setString('send', "ok");

    // var parse = jsonDecode(response.body);
    // if (parse["createRequest"] == null) {
    //   print("it is null");
    //   // message = "null";
    //   await prefs.setString('createRequest', "null");
    // } else
    //   await prefs.setString('createRequest', parse["createRequest"]);

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
