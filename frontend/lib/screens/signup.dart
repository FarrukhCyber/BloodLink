import 'package:bloodlink/base_url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

DateTime dateSelection = DateTime.now();
var red = Color(0xffde2c2c);
var backgroundColor = Colors.white;
var darkred = Color(0xffc10110);
var opacity = 0.3;
var pass = "";
var confirmPass = "";
var gender = "";
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

var genderItems = ['Choose a gender', 'Male', 'Female', 'Other'];
String bloodValue = 'Choose a blood group';
String genderValue = 'Choose a gender';

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

  var name = "";
  var phone = "";
  var email = "";
  var age = "";

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
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController, //check this
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      validator: (value) => value != null && !EmailValidator.validate(value)
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
            final form = _formkey.currentState;
            if (form != null && form.validate()) {
              print(name);
              print(pass);
              print(confirmPass);
              print(phone);
              print(blood);
              print(email);
              print(age);
              print(gender);
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
                await initPlatform();
                await signup_func(
                    name, pass, email, widget.phoneNo, blood, gender, dateonly);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? msg = prefs.getString("signup");
                print("message is:");
                print(msg);
                if (msg == "Email exists") {
                  errorGenerator(context, "Email exists",
                      "Please choose another email or login");
                } else if (msg == "Username exists") {
                  errorGenerator(context, "Username exists",
                      "Please choose another username or login");
                } else if (msg == "null values") {
                  errorGenerator(
                      context, "Empty fields", "Please fill all the fields");
                } else if (msg == "Signup Successful") {
                  print("IT WORKED");
                  UserSimplePreferences.setUsername(name); // CHECK --
                  UserSimplePreferences.setEmail(email); // CHECK --
                  UserSimplePreferences.setGender(gender); // CHECK --
                  UserSimplePreferences.setBloodType(blood); // CHECK --
                  UserSimplePreferences.setAge(age); // CHECK --
                  UserSimplePreferences.setPassword(pass); // CHECK --
                  UserSimplePreferences.setDeviceId(device_id);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => homepage(
                            userName: name,
                          )));
                } else {
                  print("THERE WAS AN ERROR");
                  errorGenerator(context, 'There was an error in server',
                      'Please try again in some time');
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //           title: const Text('There was an error in server'),
                  //           content:
                  //               const Text('Please try again in some time'),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               onPressed: () => Navigator.pop(context, 'Ok'),
                  //               child: const Text('Ok'),
                  //             ),
                  //           ],
                  //         ));
                }
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
                      userNameField,
                      SizedBox(height: 35),
                      emailField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 35),
                      confirmPasswordField,
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
                      getDate(title: "Select Date"),
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

initPlatform() async {
  await OneSignal.shared.setAppId("0a075bcf-6425-4c41-9834-6fa9304050e0");

  //gives the device unique id. TODO: need to store it in Registeredusers collection
  await OneSignal.shared.getDeviceState().then((value) => {
        print("here is the device ID:"+ value!.userId.toString()),
        device_id = value!.userId.toString()
      });
}

signup_func(name, pass, email, phone, blood, gender, age) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("TESTING");
  print(blood);
  print(gender);
  if (blood == "Choose a blood group") {
    await prefs.setString('signup', "null values");
    return;
  }
  if (gender == "Choose a gender") {
    await prefs.setString('signup', "null values");
    return;
  }

  var url = base_url + "/auth/signup";
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
        'age': age.toString(),
        'gender': gender,
        'device_id': device_id
      }),
    );
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
              color: Color(0xffc10110),
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          ElevatedButton(
            //padding: EdgeInsets.all(1.0),
            //olor: Color(0xffc10110),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Color(0xffc10110)),
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
        errorMaxLines: 4,
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: widget.hint,
        labelStyle: TextStyle(color: red),
        suffixIcon: IconButton(
          color: red,
          icon: isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
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
      validator: (password) => checkPass(password ?? "") == false
          ? 'Enter minimum 8 characters + 1 Uppercase + 1 Digit + 1 Special Character'
          : null,
      onChanged: (password) => {
            if (widget.label == "Password")
              pass = password
            else
              confirmPass = password
          },
      onSaved: (password) => {
            if (widget.label == "Password")
              password != null ? pass = password : null
            else
              password != null ? confirmPass = password : null
          });

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
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

bool checkPass(String password) {
  print("in pass");
  print(password);
  if (password == null || password.isEmpty) {
    return false;
  }
  var minLength = 8;

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  print("Returning");
  print(hasDigits & hasUppercase & hasSpecialCharacters & hasMinLength);
  return hasDigits & hasUppercase & hasSpecialCharacters & hasMinLength;
}
