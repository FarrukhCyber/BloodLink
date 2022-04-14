import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:bloodlink/screens/networkHandler.dart';
import 'networkHandler.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

NetworkHandler networkHandler = NetworkHandler();

Future<List<Data>> fetchData() async {
  final response = await networkHandler.get('/my_requests', "336");
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body)["data"];
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String name;
  final String bloodgroup;
  final String date;
  final String time;
  final String location;
  /*name: "Muhammad Hassnain",
        bloodgroup: "O+",
        symbol: MdiIcons.plusCircle,
        date: "21 March",
        time: "3:00 pm",
        location: "National Hospital",
  */
  Data(
      {required this.name,
      required this.bloodgroup,
      required this.date,
      required this.time,
      required this.location});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['attendant_name'],
      bloodgroup: json['blood_group'],
      date: json['deadline'],
      time: json['deadline'],
      location: json['hospital'],
    );
  }
}

class myRequests extends StatefulWidget {
  var futureData;
  myRequests({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<myRequests> {
  @override
  void initState() {
    super.initState();
    widget.futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppBarFb2(),
              TopBarFb3(
                  title: "Active Requests",
                  upperTitle:
                      "\nBelow are requests by \n the people who need Blood"),
              Center(
                child: SingleChildScrollView(
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
                                  symbol: MdiIcons.plusCircle,
                                  date: data[index].date,
                                  time: data[index].time,
                                  location: data[index].location,
                                  bloodgroup: data[index].bloodgroup);
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  @override
  final String name;
  final String date;
  final String time;
  final String location;
  final IconData symbol;
  final String bloodgroup;
  // Function moreDetails;

  // final Size preferredSize;
  const RequestCard(
      {required this.name,
      required this.symbol,
      required this.date,
      required this.time,
      required this.location,
      required this.bloodgroup,
      // required this.moreDetails,
      Key? key})
      : super(key: key);
  // RequestCard({Key? key})
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
                      print('Card tapped.')
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => EnterCustomLocation(
                      //           key: key,
                      // )))
                    },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    // primary: Colors.white,
                                    backgroundColor:
                                        Color(0xffde2c2c) // Text Color
                                    ),
                                onPressed: null,
                                child: Text(
                                  bloodgroup,
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
                                    name,
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
                            ),
                            Stack(
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      0,
                                      0,
                                      0),
                                  child: TextButton(
                                    // backgroundColor: Colors.white,
                                    onPressed: (() => {print("Share clicked")}),
                                    child: const Icon(
                                      Icons.share,
                                      color: Color(0xffde2c2c),
                                      // size: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.085,
                                      MediaQuery.of(context).size.width * 0.09,
                                      0,
                                      0),
                                  child: Text(
                                    "Share",
                                    style: TextStyle(
                                        color: Color(0xffde2c2c),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    // style: (Color(0xffde2c2c)m),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.125,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    child: Text(
                                      "Date",
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
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.125,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    child: Text(
                                      date,
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
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.00,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Expanded(
                                    child: Text(
                                      location,
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.52,
                            MediaQuery.of(context).size.width * 0.03,
                            0,
                            0),
                        child: Row(
                          children: [
                            // Text("More Details",
                            //     style: TextStyle(
                            //         color: Color(0xffde2c2c),
                            //         fontWeight: FontWeight.bold,
                            //         fontSize:
                            //             MediaQuery.of(context).size.width *
                            //                 0.035)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: ElevatedButton(
                                  // backgroundColor:
                                  //     Colors.white.withOpacity(0.8),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      alignment: Alignment.center,
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              top: 10,
                                              bottom: 10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 222, 44, 44)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      )),
                                  onPressed:
                                      null, //remove this request in this case
                                  child: const Text("Mark Resolved",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ),
                          ],
                        ),
                      )
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
    const primaryColor = Color(0xffde2c2c);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      centerTitle: true,
      title:
          const Text("Pending Requests", style: TextStyle(color: Colors.white)),
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
        onPressed: () {},
      ),
    );
  }
}
