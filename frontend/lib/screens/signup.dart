import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';

DateTime dateSelection = DateTime.now();
var red = Color(0xffde2c2c);
var backgroundColor = Color.fromARGB(255, 229, 229, 229);
var opacity = 0.3;
var darkred = Color(0xffc10110);
var pass = "";
var confirmPass = "";

class signup extends StatefulWidget {
  String phoneNo;
  signup({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController();
  String dropDownValue = 'A Positive (A+)';
  String genderValue = 'Male';
  var name = "";
  // var pass = "";
  // var confirmPass = "";
  var phone = "";
  var email = "";
  var age = "";
  var gender = "Male";
  var blood = 'A Positive (A+)';
  var items = [
    'A Positive (A+)',
    'A Negative (A-)',
    'B Positive (B+)',
    'B Negative (B-)',
    'O Positive (O+)',
    'O Negative (O-)'
  ];
  var genderItems = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailEditingController.dispose(); // newly added
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    userNameEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var red = Color(0xffde2c2c);
    // var backgroundColor = Color.fromARGB(255, 229, 229, 229);
    // var opacity = 0.3;
    // var darkred = Color(0xffc10110);
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController, //check this
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      validator: (value) => value != null && EmailValidator.validate(value)
          ? 'Enter a valid email'
          : null,
      textInputAction: TextInputAction.next,
      decoration: decoration("Email", "Required", red, opacity),
    );
    final passwordField = passwordBuilder(
        label: "Password",
        hint: "Required",
        controller: passwordEditingController);
    final confirmPasswordField = passwordBuilder(
        label: "Confirm Password",
        hint: "Required",
        controller: confirmPasswordEditingController);
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
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            print("In func");
            print(name);
            print(pass);
            print(confirmPass);
            print(phone);
            print(blood);
            print(email);
            print("Hello from signup on press");
            if (pass != confirmPass) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Passwords dont match'),
                        content: const Text('Please re-enter the passwords'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ok'),
                            child: const Text('Ok'),
                          ),
                        ],
                      ));
            } else {
              DateTime dateonly = DateTime(
                  dateSelection.year, dateSelection.month, dateSelection.day);
              await signup_func(
                  name, pass, email, widget.phoneNo, blood, gender, dateonly);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? msg = prefs.getString("signup");
              print("message is:");
              print(msg);
              if (msg == "Email exists") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Email exists'),
                          content: const Text(
                              'Please choose another email or login'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],
                        ));
              } else if (msg != "null") {
                UserSimplePreferences.setUsername(name); // CHECK --
                UserSimplePreferences.setEmail(email); // CHECK --
                UserSimplePreferences.setGender(gender); // CHECK --
                UserSimplePreferences.setBloodType(blood); // CHECK --
                UserSimplePreferences.setAge(age); // CHECK --
                UserSimplePreferences.setPassword(pass); // CHECK --
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => homepage(
                          userName: name,
                        )));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('There was an error'),
                          content: const Text('Checking'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],
                        ));
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
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      userNameField,
                      SizedBox(height: 35),
                      emailField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 35),
                      confirmPasswordField,
                      SizedBox(height: 35),
                      getDate(title: "Select Date"),
                      SizedBox(height: 20),
                      DropdownButton(
                        value: dropDownValue, // Change
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                            blood = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButton(
                        value: genderValue, // Change
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: genderItems.map((String genderItems) {
                          return DropdownMenuItem(
                            value: genderItems,
                            child: Text(genderItems),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderValue = newValue!;
                            gender = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      signupButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ))),
      )),
    );
  }
}

signup_func(name, pass, email, phone, blood, gender, age) async {
  var url = "http://localhost:8080/auth/signup";
  print("In signup");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': name,
        'password': pass,
        'phoneNumber': phone,
        'bloodType': blood,
        'email': email,
        'age': age,
        'gender': gender
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["signup"] == null) {
      print("it is null");
      // message = "null";
      await prefs.setString('signup', "null");
    } else
      await prefs.setString('signup', parse["signup"]);

    print("Message received:");
    print(parse["signup"]);
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

class getDate extends StatefulWidget {
  getDate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<getDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color.fromARGB(255, 222, 44, 44),
            onPrimary: Colors.white,
            surface: Color.fromARGB(255, 222, 44, 44),
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
        dateSelection = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError();
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: Column(
        children: [
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(
              color: Color.fromARGB(255, 193, 0, 0),
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          ElevatedButton(
            //padding: EdgeInsets.all(1.0),
            //olor: Color.fromARGB(255, 193, 0, 0),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 193, 0, 0)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
            onPressed: () => _selectDate(context),
            child: Text(
              "Select Date",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

decoration(String label, String hint, red, opacity) => InputDecoration(
      labelText: label,
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

class passwordBuilder extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  const passwordBuilder(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller})
      : super(key: key);

  @override
  State<passwordBuilder> createState() => _passwordBuilderState();
}

class _passwordBuilderState extends State<passwordBuilder> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        obscureText: isHidden,
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: widget.hint,
          labelStyle: TextStyle(color: red),
          suffixIcon: IconButton(
            color: red,
            icon:
                isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
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
        ),
        keyboardType: TextInputType.visiblePassword,
        autofillHints: [AutofillHints.password],
        validator: (password) => password != null && password.length < 5
            ? 'Enter min. 5 characters'
            : null,
      );

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
