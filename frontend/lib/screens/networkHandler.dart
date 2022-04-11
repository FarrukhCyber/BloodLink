import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseurl = "http://localhost:8080";

  Future<http.Response> post(String url1, Map<String, dynamic> body) async {
    url1 = formater(url1);
    var response = await http.post(
      url1,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> get(String url1, body) async {
    url1 = formater(url1);
    print(url1);
    print("--------------------------------------------...................");
    var response = await http.get(url1, headers: {
      "Content-type": "application/json",
      "user_contact_num": body
    });
    print(response);
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    url = formater(url);
    var response = await http.patch(
      url,
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
