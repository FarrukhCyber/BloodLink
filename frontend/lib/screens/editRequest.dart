import 'package:bloodlink/base_url.dart';
import 'package:bloodlink/screens/myDetails.dart';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart'; // var bloodGroups = [
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bloodlink/screens/dummy.dart';
// import 'package:bloodlink/utils/user_info.dart';

//   'A Positive (A+)',
//   'A Negative (A-)',
//   'B Positive (B+)',
//   'B Negative (B-)',
//   'AB Positive (AB+)',
//   'AB Negative (AB-)',
//   'O Positive (O+)',
//   'O Negative (O-)'
// ];

var items = [
  'Choose a Blood Group',
  'A Positive (A+)',
  'A Negative (A-)',
  'B Positive (B+)',
  'B Negative (B-)',
  'AB Positive (AB+)',
  'AB Negative (AB-)',
  'O Positive (O+)',
  'O Negative (O-)'
];

String name1 = "";
String number1 = "";
String bloodType1 = "";
String date1 = "";
String time1 = "";
String location1 = "";
String city1 = "";
String quantity1 = "";
String bloodgroup = "";
String time2 = "";
String date2 = "";
String details1 = "";

class editRequest extends StatefulWidget {
  var name;
  var number;
  var bloodType;
  var date;
  var time;
  var location;
  var city;
  var quantity;
  var details;
  var id;
  var owner;
  editRequest(
      {Key? key,
      required this.name,
      required this.number,
      required this.bloodType,
      required this.date,
      required this.time,
      required this.location,
      required this.city,
      required this.id,
      required this.details,
      required this.owner,
      required this.quantity})
      : super(key: key);

  @override
  State<editRequest> createState() => _editRequestState();
}

class _editRequestState extends State<editRequest> {
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
                upperTitle:
                    "Please provide the required \n information to edit the \n blood request"),
            InputFieldWithLabel(
                inputController: new TextEditingController(),
                hintText: widget.name,
                labelText: "Attendant Name",
                name: widget.name,
                number: widget.number,
                location: widget.location,
                city: widget.city,
                quantity: widget.quantity),
            InputFieldWithLabel(
                inputController: new TextEditingController(),
                hintText: widget.number,
                labelText: "Attendant Phone Number",
                name: widget.name,
                number: widget.number,
                location: widget.location,
                city: widget.city,
                quantity: widget.quantity),
            DropDownMenu(
              bloodType: widget.bloodType,
            ),
            getDate(title: "Please select a date", date: widget.date),
            getTime(time: widget.time),
            // continueButton()
            InputFieldWithLabel(
                inputController: new TextEditingController(),
                hintText: widget.city,
                labelText: "City",
                name: widget.name,
                number: widget.number,
                location: widget.location,
                city: widget.city,
                quantity: widget.quantity),
            InputFieldWithLabel(
                inputController: new TextEditingController(),
                hintText: widget.location,
                labelText: "Location",
                name: widget.name,
                number: widget.number,
                location: widget.location,
                city: widget.city,
                quantity: widget.quantity),
            InputFieldWithLabel(
                inputController: new TextEditingController(),
                hintText: widget.quantity,
                labelText: "Quantity",
                name: widget.name,
                number: widget.number,
                location: widget.location,
                city: widget.city,
                quantity: widget.quantity),
            PairButton(
                text: "hello",
                name: widget.name,
                location: widget.location,
                city: widget.city,
                number: widget.number,
                quantity: widget.quantity,
                bloodType: widget.bloodType,
                date: widget.date,
                id: widget.id,
                details: widget.details,
                time: widget.time)
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
          // onPressed: () {},
          onPressed: () {
            Navigator.pop(context, 'Ok');
          }),
    );
  }
}

class InputFieldWithLabel extends StatefulWidget {
  TextEditingController inputController;
  String hintText;
  Color primaryColor;
  String labelText;
  String name;
  String number;
  String location;
  String city;
  String quantity;

  InputFieldWithLabel(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      required this.name,
      required this.number,
      required this.location,
      required this.city,
      required this.quantity,
      this.primaryColor = const Color(0xffc10110)})
      : super(key: key);

  @override
  State<InputFieldWithLabel> createState() => _InputFieldWithLabelState();
}

class _InputFieldWithLabelState extends State<InputFieldWithLabel> {
  @override
  void initState() {
    super.initState();
    () => {
          if (widget.labelText == "Attendant Name")
            {widget.hintText = widget.name}
          else if (widget.labelText == "Attendant Phone Number")
            {widget.hintText = widget.number}
          else if (widget.labelText == "Location")
            {widget.hintText = widget.location}
          else if (widget.labelText == "City")
            {widget.hintText = widget.city}
          else if (widget.labelText == "Quantity")
            {widget.hintText = widget.quantity}
        };
  }

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
        controller: widget.inputController,
        onChanged: (value) {
          if (widget.labelText == "Attendant Name") {
            widget.name = value;
            name1 = value;
          } else if (widget.labelText == "Attendant Phone Number") {
            widget.number = value;
            number1 = value;
          } else if (widget.labelText == "Location") {
            widget.location = value;
            location1 = value;
          } else if (widget.labelText == "City") {
            widget.city = value;
            city1 = value;
          } else if (widget.labelText == "Quantity") {
            widget.quantity = value;
            quantity1 = value;
          }
          //Do something with value
        },
        keyboardType: TextInputType.name,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.primaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: widget.hintText,
          // hintStyle: TextStyle(color: Colors.red),
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: widget.primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffc10110), width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: widget.primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  String bloodType;
  DropDownMenu({Key? key, required this.bloodType}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropDownValue1 = "Choose a Blood Group";
  void initState() {
    super.initState();
    () => {dropDownValue1 = widget.bloodType};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.03, 0, 0),
        child: DropdownButton(
          isExpanded: true,
          value: dropDownValue1,
          icon: Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue1 = newValue!;
              widget.bloodType = newValue;
            });
          },
        ));
  }
}

class getDate extends StatefulWidget {
  String date;
  getDate({Key? key, required this.title, required this.date})
      : super(key: key);

  final String title;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<getDate> {
  DateTime selectedDate = DateTime.now();

  void initState() {
    super.initState();
    () => {finalDate = widget.date};
  }

  String finalDate = "";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color(0xffc10110),
            onPrimary: Colors.white,
            surface: Color(0xffc10110),
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.date = picked.toIso8601String();
        finalDate = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: Column(
        children: <Widget>[
          Text(finalDate.split(' ')[0]),
          SizedBox(
            height: 0,
          ),
          RaisedButton(
            color: Color(0xffc10110),
            onPressed: () => _selectDate(context),
            child: Text('Please select date on which blood is required',
                style: TextStyle(color: Color(0xffffffff))),
          ),
        ],
      ),
    );
  }
}

class getTime extends StatefulWidget {
  String time;
  String finalTime = "";
  getTime({Key? key, required this.time}) : super(key: key);
  @override
  _getTimeState createState() {
    return _getTimeState();
  }
}

class _getTimeState extends State<getTime> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  void initState() {
    super.initState();
    () => {widget.finalTime = widget.time};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xffc10110))),
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Please select time by which blood is requried",
                  style: TextStyle(color: Color(0xffffffff))),
            ),
            Text(widget.finalTime),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? obtainedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color(0xffc10110),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xffc10110),
          ),
          // dialogBackgroundColor: Color.fromARGB(255, 17, 70, 168),
        ),
        child: child!,
      ),
    );
    if (obtainedTime != null && obtainedTime != _selectedTime) {
      setState(() {
        _selectedTime = obtainedTime;
        widget.time = obtainedTime.toString();
        time2 = obtainedTime.toString();
        widget.finalTime = obtainedTime.toString();
        ;
      });
    }
  }
}

createRequest_func(name, number, bloodType, time, date, location, city,
    quantity, id, details) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var url = base_url + "/edit_request";
  print("In createRequest");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //TODO: Need to add requestor contact number
        'attendant_name': name,
        'attendant_num': number,
        'blood_group': bloodType,
        'quantity': quantity,
        'time': time,
        'date': date,
        'hospital': location,
        'city': city,
        'user_contact_num': UserSimplePreferences.getPhoneNumber(),
        'id': id,
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

class PairButton extends StatefulWidget {
  final String text;
  String name;
  String number;
  String location;
  String city;
  String quantity;
  String bloodType;
  String date;
  String time;
  String id;
  String details;
  // final Function() onPressed;
  PairButton(
      {required this.text,
      Key? key,
      required this.name,
      required this.location,
      required this.city,
      required this.number,
      required this.quantity,
      required this.bloodType,
      required this.date,
      required this.id,
      required this.details,
      required this.time})
      : super(key: key);

  @override
  State<PairButton> createState() => _PairButtonState();
}

class _PairButtonState extends State<PairButton> {
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
                            borderRadius: BorderRadius.circular(borderRadius)),
                      )),
                  // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => myRequests(key: widget.key))),
                  onPressed: () {
                    Navigator.pop(context, 'Ok');
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
                  // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => CreateBloodRequestPage2(key: key))),
                  // onPressed: () => {print("here")},
                  onPressed: () async {
                    print(widget.name);
                    print(widget.number);
                    print(widget.bloodType);
                    print(widget.date);
                    print(widget.time);
                    print("Continue pls");
                    if (widget.name == "" ||
                        widget.number == "" ||
                        widget.bloodType == "" ||
                        widget.date == "" ||
                        widget.time == "" ||
                        widget.city == "" ||
                        widget.location == "" ||
                        widget.quantity == "") {
                      errorGenerator(
                          context, "Empty fields", "Please fill all fileds");
                    } else {
                      if (time2 != widget.time && time2 != "") {
                        print("time");
                        widget.time = time2;
                      }
                      if (name1 != widget.name && name1 != "") {
                        print("name1: " + name1);
                        widget.name = name1;
                        print("new widget.name is " + widget.name);
                      }
                      if (location1 != widget.location && location1 != "") {
                        print("location1: " + location1);
                        print("widget.location: " + widget.location);
                        widget.location = location1;
                      }
                      if (quantity1 != widget.quantity && quantity1 != "") {
                        print("quantity");
                        widget.quantity = quantity1;
                      }
                      if (number1 != widget.number && number1 != "") {
                        print("number");
                        widget.number = number1;
                      }
                      if (date2 != widget.date && date2 != "") {
                        print("date2 is: " + date2);
                        print("widget.date is: " + widget.date);
                        widget.date = date2;
                      }
                      if (city1 != widget.city && city1 != "") {
                        print("city");
                        widget.city = city1;
                      }
                      if (bloodType1 != widget.bloodType && bloodType1 != "") {
                        print("bloodtype");
                        widget.bloodType = bloodType1;
                      }

                      await createRequest_func(
                          widget.name,
                          widget.number,
                          widget.bloodType,
                          widget.time,
                          widget.date,
                          widget.location,
                          widget.city,
                          widget.quantity,
                          widget.id,
                          widget.details);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? msg = prefs.getString("createRequest");
                      print("message is:");
                      print(msg);
                      if (msg == "ok") {
                        Fluttertoast.showToast(
                            msg: "Request Updated",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 32, 193, 0),
                            textColor: Colors.white,
                            fontSize: 16.0);
                        // Navigator.pop(context, 'Ok');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>myDetails(
                              attendantName: widget.name,
                              attendantNum: widget.number,
                              bloodGroup: widget.bloodType,
                              status: "true",
                              userContact: userPhoneNum,
                              date: widget.date,
                              time: widget.time,
                              quantity: widget.quantity,
                              hospital: widget.location,
                              id: widget.id,
                              city: widget.city,
                              ownership: true,
                              details: widget.details,
                            )));
                      }

                    }
                  },
                  child: Text(
                    "Update",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
