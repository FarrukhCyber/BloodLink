import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHandler2 {
  String baseurl = "http://10.0.2.2:8080";

  Future<http.Response> post(String url1, Map<String, dynamic> body) async {
    url1 = formater(url1);
    var response = await http.post(
      Uri.parse(url1),
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> get(String url1, dynamic body) async {
    url1 = formater(url1);
    print(url1);
    print("in future get, body:");
    print(body);
    print("url1:");
    print(url1);
    var response = await http.get(Uri.parse(url1),
        headers: {"Content-type": "application/json", "status": body});
    print("response:");
    print(response);
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    url = formater(url);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }
}
