import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class aboutPage extends StatefulWidget {
  aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  var aboutContent = "Loading...";
  var lcssContent = "Loading...";
  var lumsContent = "Loading...";
  var bloodlinkContent = "Loading...";

  getData() async {
    var temp1 = await rootBundle.loadString("assets/about.txt");
    var temp2 = await rootBundle.loadString("assets/lcss.txt");
    var temp3 = await rootBundle.loadString("assets/lums.txt");
    var temp4 = await rootBundle.loadString("assets/bloodlink.txt");

    setState(() {
      aboutContent = temp1;
      lcssContent = temp2;
      lumsContent = temp3;
      bloodlinkContent = temp4;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var aboutSize = MediaQuery.of(context).size.width * 0.12;
    var headSize = MediaQuery.of(context).size.width * 0.08;
    var paraSize = MediaQuery.of(context).size.width * 0.05;
    var imgSize = MediaQuery.of(context).size.width * 0.2;
    var dist = MediaQuery.of(context).size.height * 0.1;
    var mar = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: width,
          child: Column(
            children: [
              AppBarFb2(),
              Container(
                margin: EdgeInsets.only(left: mar, right: mar),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      "About",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: aboutSize, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      aboutContent,
                      style: TextStyle(fontSize: paraSize),
                    ),
                    infoFunc("Bloodlink", "assets/bloodlink.png",
                        bloodlinkContent, headSize, paraSize, imgSize, dist),
                    infoFunc("LCSS", "assets/lcss_logo.png", lcssContent,
                        headSize, paraSize, imgSize, dist),
                    infoFunc("LUMS", "assets/lums_logo_2.png", lumsContent,
                        headSize, paraSize, imgSize, dist),
                  ],
                ),
              )

              // TopBarFb3(
              //   title: "BloodLink",
              // ),
            ],
          ),
        ),
      ),
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
    );
  }
}

class TopBarFb3 extends StatelessWidget {
  final String title;
  TopBarFb3({required this.title, Key? key}) : super(key: key);
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
            color: Colors.yellow,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/bloodlink.png',
                width: MediaQuery.of(context).size.width * 0.2,
                color: Colors.white,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/lums_logo_2.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/lcss_logo.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
        ));
  }
}

headingDecoration(headSize) {
  return TextStyle(fontSize: headSize, fontWeight: FontWeight.bold);
}

paraDecoration(paraSize) {
  return TextStyle(fontSize: paraSize);
}

infoFunc(heading, logo, content, headSize, paraSize, imgSize, dist) {
  return Container(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: dist,
          ),
          Text(
            heading,
            style: headingDecoration(headSize),
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  content,
                  style: paraDecoration(paraSize),
                ),
              ),
              Image.asset(
                logo,
                width: imgSize,
                alignment: Alignment.centerRight,
              )
            ],
          )
        ]),
  );
}
