import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:primajasa/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> login(String username, String password) async {
  var data = jsonEncode({
    'username': username,
    'password': password,
    'oneSignalId': OneSignal.User.pushSubscription.id ?? '-',
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final headers = {'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/login");
  var res = await http.post(url, body: data, headers: headers);
  print(res.statusCode);
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    sharedPreferences.setString('token', data['token']);
  }
  return res.statusCode;
}

Future<int> register(
  String username,
  String password,
  String passwordConfirmation,
  String email,
  String nama,
  String noHanphone,
) async {
  var data = jsonEncode({
    'username': username,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'email': email,
    'nama': nama,
    'noHanphone': noHanphone,
  });
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final headers = {'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/register");
  var res = await http.post(url, body: data, headers: headers);
  print(res.statusCode);
  // if (res.statusCode == 200) {
  //   var data = jsonDecode(res.body);
  //   sharedPreferences.setString('token', data['token']);
  // }
  return res.statusCode;
}
