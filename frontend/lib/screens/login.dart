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
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bloodlink/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/signup.dart';

const red = Color(0xffc10110);
var backgroundColor = Color.fromARGB(255, 229, 229, 229);
var opacity = 0.3;
var darkred = Color(0xffc10110);
var pass = "";
var white = Colors.white;

var device_id = "";

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formkey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  var name = "";
  var phone = "";
  var message = "";

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
    passwordEditingController.dispose();
    phoneNumberEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordField = passwordBuilder(
        label: "Password",
        hint: "Required",
        controller: passwordEditingController);
    final userNameField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        controller: userNameEditingController, //check this
        onSaved: (value) {
          value != null ? name = value : null;
        },
        onChanged: (value) {
          name = value;
        },
        textInputAction: TextInputAction.next,
        decoration: decoration("Phone Number", "Required", red, opacity));
    final phoneNumberField = TextFormField(
        validator: (value) => isValidPhoneNumber(value ?? "") == false
            ? "Please enter a number of lenght 10"
            : null,
        textInputAction: TextInputAction.next,
        autofocus: false,
        controller: phoneNumberEditingController, //check this
        onSaved: (value) {
          value != null ? phone = value : null;
        },
        onChanged: (value) {
          phone = value;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "Phone Number",
            errorMaxLines: 4,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "3xxxxxxxxx",
            border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: red.withOpacity(opacity), width: 2.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: red, width: 2.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: red, width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: red.withOpacity(opacity), width: 2.0),
            ),
            prefix: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '(+92)',
              ),
            ),
            suffixIcon: Visibility(
              visible: phoneNumberEditingController.text.length == 10,
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 32,
              ),
            )));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            final form = _formkey.currentState;
            if (form != null && form.validate()) {
              print("Hello");
              await login_func(name, pass, "92" + phone.toString());
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? msg = prefs.getString("msg");
              print("message is:");
              print(msg);

              if (msg == "ERROR") {
                errorGenerator(context, "There was an error in server",
                    "Please try again in some time");
              } else if (msg == "ADMIN MODE") {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => adminHomepage()));
              }
              // else if (msg != "null" && msg != null) {
              else if (msg == "Login Successful") {
                UserSimplePreferences.setUsername(
                    prefs.getString("userName") ?? "ERROR"); // CHECK --
                UserSimplePreferences.setEmail(
                    prefs.getString("email") ?? "ERROR");
                UserSimplePreferences.setPhoneNumber(
                    prefs.getString("phoneNumber") ?? "ERROR");
                UserSimplePreferences.setAge(prefs.getString("age") ?? "ERROR");
                UserSimplePreferences.setBloodType(
                    prefs.getString("bloodType") ?? "ERROR");
                UserSimplePreferences.setPassword(
                    prefs.getString("password") ?? "ERROR");
                UserSimplePreferences.setGender(
                    prefs.getString("gender") ?? "ERROR");
                UserSimplePreferences.setisDonor(
                    prefs.getString("donor") ?? "ERROR");

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => homepage(
                          userName: name,
                        )));
              } else {
                errorGenerator(context, "Creddentials are Incorrect!",
                    'Please re-enter the credentials or signup instead');
              }
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, color: Colors.white //Color(0xffC10100),
                    ),
          )),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            color: backgroundColor,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/bloodlink.png',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fill,
                        color: red,
                      ),
                      SizedBox(height: 35),
                      phoneNumberField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 45),
                      loginButton,
                      SizedBox(height: 15),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SigupButton()),
                      SizedBox(height: 15),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: forgetButton())
                    ],
                  ),
                ))),
      )),
    );
  }
}

login_func(name, pass, phone) async {
  await initPlatform();
  var url = base_url + "/auth/login";
  print("In login");
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': name,
        'password': pass,
        'phoneNumber': phone.toString(),
        'deviceID': device_id
      }),
    );
    print("this one");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    if (parse["msg"] == "null") {
      print("it is null");
      // message = "null";
      await prefs.setString('msg', "null");
    } else if (parse["msg"] == "ADMIN MODE") {
      await prefs.setString('msg', "ADMIN MODE");
    } else {
      await prefs.setString('msg', parse["msg"]);
      await prefs.setString('userName', parse["userName"]);
      await prefs.setString('phoneNumber', parse["phoneNumber"]);
      await prefs.setString('bloodType', parse["bloodType"]);
      await prefs.setString('password', parse["password"]);
      await prefs.setString('gender', parse["gender"]);
      await prefs.setString('age', parse["age"]);
      await prefs.setString('email', parse["email"]);
      await prefs.setString('donor', parse["donor"]);
      print("Here they are");
      print(parse["userName"]);
      print(parse["email"]);
      print(parse["gender"]);
      print(parse["age"]);
      print(parse["phoneNumber"]);
      print(parse["password"]);
      print(parse["bloodType"]);
      print(parse["donor"]);
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

bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string == null || string.isEmpty) {
    return false;
  }
  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+][9][2][0-9]*';
  // const pattern = r'^[0-9]*';
  final regExp = RegExp(pattern);

  if (string.length != 10) {
    return false;
  }
  return true;
}

class SigupButton extends StatelessWidget {
  const SigupButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.06),
        Text("Don't have an Account? "),
        TextButton(
            onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginWithPhone(forget: false)))
                },
            child: const Text(
              "Sign up",
              style: TextStyle(
                  fontSize: 15,
                  color: red,
                  decoration: TextDecoration.underline),
            )),
      ],
    );
  }
}

class forgetButton extends StatelessWidget {
  const forgetButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginWithPhone(forget: true)))
            },
        child: const Text(
          "Forget Password?",
          style: TextStyle(
              fontSize: 15, color: red, decoration: TextDecoration.underline),
        ));
  }
}

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
      onChanged: (password) => {pass = password},
      onSaved: (password) => {password != null ? pass = password : null});

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
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
