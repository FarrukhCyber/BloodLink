// import 'dart:html';
import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/activeDetails.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:bloodlink/screens/request_success_msg.dart';
// import 'package:bloodlink/utils/request_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // var bloodGroups = [
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/createBloodRequestPage3.dart';

import '../utils/user_info.dart';
import 'admin_dashboard.dart';

var data;
var device_id = "";

class RequestDetails extends StatelessWidget {
  // var admin;
  final attendantName;
  final phoneNumber;
  final bloodGroup;
  final date;
  final time;
  final city;
  final location;
  final quantity;
  final admin;
  const RequestDetails(
      {Key? key,
      required this.attendantName,
      required this.phoneNumber,
      required this.bloodGroup,
      required this.date,
      required this.time,
      required this.city,
      required this.location,
      required this.quantity,
      required this.admin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            AppBarFb2(),
            TopBarFb3(
                title: "Initiate a Request", upperTitle: "\nAny other details"),
            InputFieldWithLabel(
                inputController: TextEditingController(),
                hintText: "Any other details about the request",
                labelText: ""),
            PairButton(
                attendantName: attendantName,
                phoneNumber: phoneNumber,
                bloodGroup: bloodGroup,
                date: date,
                time: time,
                city: city,
                location: location,
                quantity: quantity,
                admin: admin,
                text: "hello")
            // Container(
            //   padding:
            //       EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
            //   width: MediaQuery.of(context).size.width * 0.98,
            //   child: Card(
            //     elevation: 10,
            //     child: new TextField(

            //       keyboardType: TextInputType.multiline,
            //       maxLines: null,
            //     ),
            //   ),
            // )
          ],
        ),
      ]),
      //   ),
      // ),
      // ),
    );
  }
}

class InputFieldWithLabel extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const InputFieldWithLabel(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = const Color(0xffc10110)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 0.5,
      // height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: TextField(
        maxLines: null,
        controller: inputController,
        onChanged: (value) => {data = value},
        keyboardType: TextInputType.multiline,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: primaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          // hintStyle: TextStyle(color: Colors.red),
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffc10110), width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}

class PairButton extends StatelessWidget {
  final String text;
  final attendantName;
  final phoneNumber;
  final bloodGroup;
  final date;
  final time;
  final city;
  final location;
  final quantity;
  final admin;
  const PairButton(
      {Key? key,
      required this.attendantName,
      required this.phoneNumber,
      required this.bloodGroup,
      required this.date,
      required this.time,
      required this.city,
      required this.location,
      required this.quantity,
      required this.admin,
      required this.text})
      : super(key: key);

  // final Function() onPressed;

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
                  onPressed: () => {
                    if (admin == false)
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => homepage(
                                  key: key,
                                  userName:
                                      UserSimplePreferences.getUsername() ?? "",
                                )))
                      }
                    else
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => adminHomepage(
                                  key: key,
                                )))
                      }
                  },
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
                  //TODO: For turning On the maps uncomment the below section---------------------------
                  // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => RequestDetails(
                  //           key: key,
                  //           admin: admin,
                  //         ))),
                  onPressed: () async {
                    await createRequest_func(attendantName, phoneNumber,
                        bloodGroup, time, date, location, city, quantity, data);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? msg = prefs.getString("createRequest");
                    print("message is:");
                    print(msg);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RequestConfirmation(admin: admin)));
                    // if (msg == "Request Added") {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => Confirmation()));
                    // }
                  },
                  //------------------------------------------------------------------------------------
                  // onPressed: () => {print("here")},
                  // onPressed: () async {
                  //   print(name);
                  //   print(number);
                  //   print(bloodType);
                  //   print(date);
                  //   print(time);
                  //   print("Continue pls");
                  //   if (name == "" ||
                  //       number == "" ||
                  //       bloodType == "" ||
                  //       date == "" ||
                  //       time == "" ||
                  //       city == "" ||
                  //       location == "" ||
                  //       quantity == "") {
                  //     errorGenerator(
                  //         context, "Empty fields", "Please fill all fileds");
                  //   } else {
                  //     await createRequest_func(name, number, bloodType, time,
                  //         date, location, city, quantity);
                  //     SharedPreferences prefs =
                  //         await SharedPreferences.getInstance();
                  //     String? msg = prefs.getString("createRequest");
                  //     print("message is:");
                  //     print(msg);
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) =>
                  //             RequestConfirmation(admin: admin)));
                  //     // if (msg == "Request Added") {
                  //     //   Navigator.of(context).push(MaterialPageRoute(
                  //     //       builder: (context) => Confirmation()));
                  //     // }
                  //   }
                  // },
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

initPlatform() async {
  await OneSignal.shared.setAppId("0a075bcf-6425-4c41-9834-6fa9304050e0");

  //gives the device unique id. TODO: need to store it in Registeredusers collection
  // var devuceState = await OneSignal!.getDeviceState().then((value) => {
  //       print("here is the device ID:" + value!.userId.toString()),
  //       device_id = value.userId.toString()
  OneSignal? _instance;
  var deviceState;
  while (OneSignal.shared.getDeviceState() == null) {
    print("waiting");
  }
  // do {
  deviceState = await OneSignal.shared.getDeviceState();
  if (deviceState != null || deviceState?.userId != null) {
    print("I am");
    print(deviceState);
    device_id = deviceState!.userId.toString();
    print("TOKEN ID: " + device_id);
  }
  // } while (deviceState == null);
}

createRequest_func(name, number, bloodType, time, date, location, city,
    quantity, details) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await initPlatform();
  var url = base_url + "/submit_request"; // check what localhost is for you
  print("In createRequest");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'attendant_name': name,
        'time': time,
        'date': date,
        'blood_group': bloodType,
        'attendant_num': number,
        'hospital': location,
        'city': city,
        'quantity': quantity,
        'user_contact_num': UserSimplePreferences.getPhoneNumber(),
        'deviceID': device_id,
        'details': details
      }),
    );
    var parse = jsonDecode(response.body);
    if (parse["createRequest"] == null) {
      print("it is null");
      // message = "null";
      await prefs.setString('createRequest', "null");
    } else
      await prefs.setString('createRequest', parse["createRequest"]);

    print("Message received:");
    print(parse["createRequest"]);
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
