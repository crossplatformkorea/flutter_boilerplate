import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

Future<String> fetchFirebaseToken(String uid) async {
  final String requestURL = "${env('FUNCTIONS_URL')}/sign-up";
  final appCheckToken = await FirebaseAppCheck.instance.getToken();

  final response = await http.post(Uri.parse(requestURL),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "X-Firebase-AppCheck": appCheckToken!,
      },
      body: jsonEncode(<String, String>{
        "uid": uid,
      }));

  if (response.statusCode == HttpStatus.ok) {
    return jsonDecode(response.body)["firebaseToken"];
  }

  throw Exception('Failed to fetch firebase token');
}
