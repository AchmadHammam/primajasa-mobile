import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:primajasa/constant.dart';
import 'package:primajasa/model/checklist.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> createCheckList(String title) async {
  var data = jsonEncode({
    'title': title,
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist");
  var res = await http.post(url, body: data, headers: headers);
  return res.statusCode;
}

Future<void> fetchListCheckList(
  PagingController<int, Checklist> pagingController,
  int page,
) async {
  try {
    int pageSize = 6;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('token');
    final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var url = Uri.parse("$apiURl/checklist?page=$page&pageSize=$pageSize");

    final res = await http.get(url, headers: headers);
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      ChecklistResponse modelCheckList = ChecklistResponse.fromJson(body);
      final isLastPage = page == (modelCheckList.data.count / pageSize).ceil();

      if (isLastPage) {
        pagingController.appendLastPage(modelCheckList.data.checklist);
      } else {
        pagingController.appendPage(modelCheckList.data.checklist, (page + 1));
      }
    } else {
      throw Exception([res.statusCode, res.body]);
    }
  } catch (e) {
    pagingController.error = e;
    throw Exception(e);
  }
}

Future<int> updateCheckList(int id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist/$id");
  var res = await http.put(url, headers: headers);
  return res.statusCode;
}

Future<int> deleteCheckList(int id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist/$id");
  var res = await http.delete(url, headers: headers);
  return res.statusCode;
}
