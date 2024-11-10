// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> setLoginStatus(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogin', isLogin);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool('isLogin');
    return isLogin ?? false;
  }

  static Future<void> setProduct(
    List<Map<String, dynamic>> alarmList,
  ) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String> listOfStrings =
        alarmList.map((map) => json.encode(map)).toList();

    sharedPref.setStringList('product', listOfStrings);
  }

  static Future<List<Map<String, dynamic>>> getProduct() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? product = sharedPref.getStringList('product') ?? [];
    List<Map<String, dynamic>> products = [];

    for (var item in product) {
      products.add(json.decode(item));
    }
    print(products);

    return products;
  }
}
