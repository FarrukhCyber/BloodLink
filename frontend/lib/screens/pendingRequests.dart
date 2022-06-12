import 'dart:async';
import 'dart:convert';
import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/activeDetails.dart';
import 'package:bloodlink/screens/addDonor.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloodlink/screens/networkHandler.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:bloodlink/screens/myDetails.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/admin_dashboard.dart';
import 'package:bloodlink/screens/changePassword.dart';
import 'package:bloodlink/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/screens/phone_auth.dart';
import 'signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/signup.dart';

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

String converter(_selectedTime) {
  DateTime tempDate = DateFormat("hh:mm").parse(
      (_selectedTime.split('T')[1].split(":"))[0].toString() +
          ":" +
          (_selectedTime.split('T')[1].split(":"))[1].toString());
  var dateFormat = DateFormat("h:mm a"); // you can change the format here
  return dateFormat.format(tempDate);
}

bool error = false;
NetworkHandler networkHandler = NetworkHandler();
String userPhoneNum = UserSimplePreferences.getPhoneNumber() ?? "Error";
Future<List<Data>> fetchData() async {
  final response = await networkHandler.active('/pending_request');
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body)["data"];
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    error = true;
    throw Exception('Unexpected error occured!');
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

class Data {
  final String name;
  final String bloodgroup;
  final String date;
  final String time;
  final String location;
  final String status;
  final String city;
  final String quantity;
  final String attendantNum;
  var id;
  Data({
    required this.name,
    required this.bloodgroup,
    required this.date,
    required this.time,
    required this.location,
    required this.city,
    required this.quantity,
    required this.status,
    required this.attendantNum,
    required this.id,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['attendant_name'],
      bloodgroup: json['blood_group'],
      date: json['date'],
      time: json['time'],
      location: json['hospital'],
      status: json['status'] == true ? "Active" : "Resolved",
      city: json["city"],
      quantity: json["quantity"],
      attendantNum: json["attendant_num"],
      id: json["_id"],
    );
  }
}

class pendingRequests extends StatefulWidget {
  var futureData;
  pendingRequests({Key? key}) : super(key: key);

  @override
  State<pendingRequests> createState() => _pendingRequestsState();
}

class _pendingRequestsState extends State<pendingRequests> {
  @override
  void initState() {
    super.initState();
    widget.futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //errorGenerator(context, "There was an error in server",
    //    "Please try again in some time");
    NetworkHandler networkHandler = NetworkHandler();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      body: Column(
        children: <Widget>[
          AppBarFb2(),
          TopBarFb3(
              title: "Resolved Requests",
              upperTitle: "\nFollowing are your blood requests."),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            margin: EdgeInsets.only(top: 20),
            child: FutureBuilder<List<Data>>(
              future: widget.futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data> data = snapshot.data!;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RequestCard(
                          name: data[index].name,
                          date: data[index].date,
                          time: data[index].time,
                          location: data[index].location,
                          bloodgroup: data[index].bloodgroup,
                          status: data[index].status,
                          attendantNum: data[index].attendantNum,
                          city: data[index].city,
                          quantity: data[index].quantity,
                          id: data[index].id,
                          visible:
                              data[index].status == "Active" ? false : true,
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                // return CircularProgressIndicator(
                //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.red));
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: Color(0xffc10110)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCard extends StatefulWidget {
  @override
  final String name;
  final String date;
  final String time;
  final String location;
  final String id;
  final String bloodgroup;
  final String attendantNum;
  final String city;
  final String status;
  final String quantity;
  bool visible;
  // Function moreDetails;

  // final Size preferredSize;
  RequestCard(
      {required this.name,
      required this.date,
      required this.time,
      required this.location,
      required this.bloodgroup,
      required this.attendantNum,
      required this.city,
      required this.quantity,
      required this.status,
      required this.id,
      required this.visible,
      Key? key})
      : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  // RequestCard({Key? key})
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
        child: Card(
            elevation: 10,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () => {
                      print('Card tapped.'),
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => EnterCustomLocation(
                      //           key: key,
                      // )))
                      print(widget.id),
                    },
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.75,
                  height: null,
                  // height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        // padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.0250,
                            MediaQuery.of(context).size.width * 0.03,
                            0,
                            0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    // primary: Colors.white,
                                    backgroundColor:
                                        Color(0xffc10110) // Text Color
                                    ),
                                onPressed: null,
                                child: Text(
                                  widget.bloodgroup.split('(')[1].split(')')[0],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.02,
                                      MediaQuery.of(context).size.width * 0.0,
                                      0,
                                      0),
                                  child: Text(
                                    widget.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(
                      //       0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                      //   child: Column(
                      //     children: [
                      //       Divider(
                      //         thickness: 2,
                      //         color: Color(0xffc10110),
                      //         indent: MediaQuery.of(context).size.width * 0.05,
                      //         endIndent:
                      //             MediaQuery.of(context).size.width * 0.05,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Row(children: [
                      //   Container(
                      //       padding: EdgeInsets.fromLTRB(
                      //           MediaQuery.of(context).size.width * 0.03,
                      //           0,
                      //           0,
                      //           0),
                      //       child: Icon(Icons.circle,
                      //           color:
                      //               widget.visible ? Colors.green : Colors.red,
                      //           size: 24)),
                      //   Container(
                      //       padding: EdgeInsets.fromLTRB(
                      //           MediaQuery.of(context).size.width * 0.03,
                      //           0,
                      //           0,
                      //           0),
                      //       child: const Text("Status: ")),
                      //   TextButton(
                      //       // backgroundColor: Colors.white,
                      //       onPressed: (() => {print("Share clicked")}),
                      //       child: Text(
                      //         widget.visible ? "Resolved" : "Active",
                      //         style: TextStyle(
                      //             color: widget.visible
                      //                 ? Colors.green
                      //                 : Colors.red),
                      //       )),
                      //   Visibility(
                      //       visible: widget.visible,
                      //       child: const Icon(Icons.check_circle,
                      //           color: Colors.green))
                      // ]),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          MediaQuery.of(context).size.width *
                                              0.005,
                                          0,
                                          0),
                                      child: Icon(
                                        Icons.calendar_month_rounded,
                                        color: Color(0xffc10110),
                                        size: 24,
                                      )),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        MediaQuery.of(context).size.width *
                                            0.01,
                                        0,
                                        0),
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                      // textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.085,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    child: Text(
                                      ((widget.date
                                              .split('T')[0]
                                              .split('-'))[2] +
                                          " " +
                                          (months[int.parse((widget.date
                                                  .split('T')[0]
                                                  .split('-'))[1]) -
                                              1]) +
                                          " " +
                                          (widget.date
                                              .split('T')[0]
                                              .split('-'))[0]),
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]),
                            Row(
                              children: [
                                // Spacer(),
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    // alignment: Alignment.center,
                                    child: Icon(
                                      Icons.watch_later,
                                      color: Color(0xffc10110),
                                      size: 24,
                                    )),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    // textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.08,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    converter(widget.time),
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    // textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    // alignment: Alignment.center,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xffc10110),
                                      size: 24,
                                    )),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    // textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      0,
                                      0,
                                      0),
                                  // child: Expanded(
                                  child: Text(
                                    widget.location,
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(
                      //       0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                      //   child: Column(
                      //     children: [
                      //       Divider(
                      //         thickness: 2,
                      //         color: Color(0xffc10110),
                      //         indent: MediaQuery.of(context).size.width * 0.05,
                      //         endIndent:
                      //             MediaQuery.of(context).size.width * 0.05,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        // padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 116, 4)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                                child: Text("Send Email",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: OutlinedButton(
                                onPressed: () async {
                                  bool error = false;
                                  NetworkHandler networkHandler =
                                      NetworkHandler();
                                  final response =
                                      await pending_request(widget.id);

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var msg = prefs.getString("msg");
                                  if (msg == null) {
                                    errorGenerator(context, "Error",
                                        "There is an error on server");
                                  } else {
                                    var key;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                pendingRequests(key: key)));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                                child: Text("Remove",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035)),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: OutlinedButton(
                                onPressed: () {
                                  print("hi");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => myDetails(
                                            attendantName: widget.name,
                                            attendantNum: widget.attendantNum,
                                            bloodGroup: widget.bloodgroup,
                                            status: widget.status,
                                            userContact: userPhoneNum,
                                            date: widget.date,
                                            time: widget.time,
                                            quantity: widget.quantity,
                                            hospital: widget.location,
                                            id: widget.id,
                                            city: widget.city,
                                            ownership: true,
                                          )));
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                                child: Text("View Details",
                                    style: TextStyle(
                                        color: Color(0xffc10110),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
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
      height: MediaQuery.of(context).size.height * 0.08,
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
      title: const Text("My Requests", style: TextStyle(color: Colors.white)),
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
        onPressed: () {
          Navigator.pop(context, 'Ok');
        },
      ),
    );
  }
}

pending_request(id) async {
  var url = base_url + "/rejectEmail/rej";
  print("In pending request");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
      }),
    );
    print("DONE WITH HTTPS");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    print("DONE PARSE");
    if (parse["msg"] == "null") {
      print("it is null");
      // message = "null";
      await prefs.setString('msg', "null");
    }
    print("Message received:");
    print(parse["msg"]);
  } on HttpException catch (err) {
    print(err);
    return null;
  } on Error catch (error) {
    print(error);
    return null;
  } on Object catch (error) {
    print("Error here ");
    print(error);
    print("Done");
    return null;
  }
}
