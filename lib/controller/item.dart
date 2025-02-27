import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:primajasa/constant.dart';
import 'package:primajasa/model/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> createItemList(String title, int checkListId) async {
  var data = jsonEncode({
    'title': title,
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist/$checkListId/item");
  var res = await http.post(url, body: data, headers: headers);
  print(res.body);
  return res.statusCode;
}

Future<void> fetchListItemList(
    PagingController<int, Item> pagingController, int page, int checkListId) async {
  // try {
  int pageSize = 6;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

  var url = Uri.parse("$apiURl/checklist/$checkListId/item?page=$page&pageSize=$pageSize");

  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final body = json.decode(res.body);
    ItemResponse modelItemList = ItemResponse.fromJson(body);
    final isLastPage = page == (modelItemList.data.count / pageSize).ceil();

    if (isLastPage) {
      pagingController.appendLastPage(modelItemList.data.checklist);
    } else {
      pagingController.appendPage(modelItemList.data.checklist, (page + 1));
    }
  } else {
    throw Exception([res.statusCode, res.body]);
  }
  // } catch (e) {
  //   pagingController.error = e;
  //   throw Exception(e);
  // }
}

Future<int> updateItem(int id, int checkListId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist/$checkListId/item/$id");
  var res = await http.put(url, headers: headers);
  return res.statusCode;
}

Future<int> deleteItemList(int id, int checkListId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  var url = Uri.parse("$apiURl/checklist/$checkListId/item/$id");
  var res = await http.delete(url, headers: headers);
  return res.statusCode;
}
