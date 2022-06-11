import 'package:bloodlink/base_url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_dashboard.dart';
// Name Roll blood status city last gender number

var red = Color(0xffde2c2c);
var backgroundColor = Colors.white;
var darkred = Color(0xffc10110);
var opacity = 0.3;

var name = "";
var city = "";
var gender = "";
var roll = "";
var lastContact = "";
var status = "";
var blood = '';
var bloodItems = [
  'Choose a blood group',
  'A Positive (A+)',
  'A Negative (A-)',
  'B Positive (B+)',
  'B Negative (B-)',
  'AB Positive (AB+)',
  'AB Negative (AB-)',
  'O Positive (O+)',
  'O Negative (O-)'
];
var device_id = "";
var phone = "";

var genderItems = ['Choose a gender', 'Male', 'Female', 'Other'];
String bloodValue = 'Choose a blood group';
String genderValue = 'Choose a gender';

class addDonor extends StatefulWidget {
  const addDonor({Key? key}) : super(key: key);

  @override
  State<addDonor> createState() => _addDonorState();
}
// Name Roll blood status city last gender number

class _addDonorState extends State<addDonor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final rollEditingController = new TextEditingController();
  final statusEditingController = new TextEditingController();
  final cityEditingController = new TextEditingController();
  final lastContactEditingController = new TextEditingController();
  final numberEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    userNameEditingController.dispose();
    statusEditingController.dispose();
    lastContactEditingController.dispose();
    numberEditingController.dispose();
    cityEditingController.dispose();
    rollEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: userNameEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        name = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Username", "Required", red, opacity),
    );
    final statusField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: statusEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        status = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Status", "Required", red, opacity),
    );
    final lastContactField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: lastContactEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        lastContact = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Last Contact", "Required", red, opacity),
    );
    final rollField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: rollEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        roll = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Roll Number", "Required", red, opacity),
    );
    final cityField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: cityEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        city = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("City", "Required", red, opacity),
    );
    final numberField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: numberEditingController, //check this
      onChanged: (value) {
        // userNameEditingController.text = value!;
        phone = value;
      },
      textInputAction: TextInputAction.next,
      decoration: decoration("Phone Number", "Required", red, opacity),
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            print("I was clicked");
            final form = _formkey.currentState;
            if (form != null && form.validate()) {
              print(name);
              print(phone);
              print(gender);
              print(blood);
              print(status);
              print(lastContact);
              print(city);
              print(roll);
              print("Hello from signup on press");
              await addDonor_func(
                  name, roll, status, lastContact, blood, gender, phone, city);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? msg = prefs.getString("addDonor");
              print("message is:");
              print(msg);
              if (msg == "Success") {
                print("IT WORKED");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => adminHomepage()));
              } else if (msg == "null values") {
                errorGenerator(context, "Please fill all the values",
                    "Not all fields are filled. Please fill and try again.");
              } else {
                print("THERE WAS AN ERROR");
                errorGenerator(context, 'There was an error in server',
                    'Please try again in some time');
              }
            }
          },
          child: Text(
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloodlink"),
        backgroundColor: red,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // const { userName, roll, status, lastContact, blood, gender, phone, city} = req.body
                      userNameField,
                      SizedBox(height: 35),
                      rollField,
                      SizedBox(height: 35),
                      numberField,
                      SizedBox(height: 35),
                      cityField,
                      SizedBox(height: 35),
                      statusField,
                      SizedBox(height: 35),
                      lastContactField,
                      SizedBox(height: 35),
                      DropDownMenu(
                          item: bloodItems,
                          dropDownValue: bloodValue,
                          selection: "blood"),
                      SizedBox(height: 20),
                      DropDownMenu(
                          item: genderItems,
                          dropDownValue: genderValue,
                          selection: "gender"),
                      SizedBox(height: 20),
                      submitButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ))),
      )),
    );
  }
}

addDonor_func(
    name, roll, status, lastContact, blood, gender, phone, city) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (blood == "Choose a blood group") {
    await prefs.setString('addDonor', "null values");
    return;
  }
  if (gender == "Choose a gender") {
    await prefs.setString('addDonor', "null values");
    return;
  }

  // var url = base_url + "cat/add";
  var url = "http://10.0.2.2:8080/cat/add";
  print("In add donor");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': name,
        'roll': roll,
        "status": status,
        "lastContact": lastContact,
        "blood": blood,
        "gender": gender,
        "phone": phone,
        "city": city
      }),
    );
    var parse = jsonDecode(response.body);
    if (parse["addDonor"] == null) {
      print("it is null");
      // message = "null";
      await prefs.setString('addDonor', "null");
    } else
      await prefs.setString('addDonor', parse["addDonor"]);

    print("Message received:");
    print(parse["addDonor"]);
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

decoration(String label, String hint, red, opacity) => InputDecoration(
      labelText: label,
      errorMaxLines: 4,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hint,
      labelStyle: TextStyle(color: red),
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

class DropDownMenu extends StatefulWidget {
  var item;
  String dropDownValue;
  String selection;
  DropDownMenu(
      {Key? key,
      required this.item,
      required this.dropDownValue,
      required this.selection})
      : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.01, 0, 0),
        child: DropdownButton(
          isExpanded: true,
          value: widget.dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: widget.item.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropDownValue = newValue!;
              if (widget.selection == 'blood') {
                blood = newValue;
              } else {
                gender = newValue;
              }
            });
          },
        ));
  }
}
