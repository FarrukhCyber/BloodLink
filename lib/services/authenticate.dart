// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signup_signin/screens-2/signup.dart';

class AuthService {
  final IP = "";
  Dio dio = new Dio();
  login(username, password) async {
    try {
      return await dio.post(IP,
          data: {"username": username, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          fontSize: 15);
    }
  }

  sign(username, password, blood, phone, email) async {
    try {
      return await dio.post(IP,
          data: {
            "userName": username,
            "password": password,
            "bloodType": blood,
            "email": email,
            "phoneNumber": phone
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          fontSize: 15);
    }
  }
}
